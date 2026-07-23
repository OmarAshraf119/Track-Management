-- Enable UUID generator (safe if already enabled)
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Optional: create an enum for status (safe if already created)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'track_status') THEN
    CREATE TYPE public.track_status AS ENUM ('draft', 'submitted', 'distributed');
  END IF;
END $$;

-- Create tracks table
CREATE TABLE IF NOT EXISTS public.tracks (
  id bigint primary key generated always as identity,
  title text NOT NULL,

  -- FK to public.artists(id)
  artist_id bigint NOT NULL REFERENCES public.artists(id) ON DELETE CASCADE,

  -- ISRC is unique per track
  isrc text NOT NULL UNIQUE,


  -- Release date
  release_date date,

  genre text,

  status public.track_status NOT NULL DEFAULT 'draft'

);

-- Helpful indexes
CREATE INDEX IF NOT EXISTS idx_tracks_artist_id ON public.tracks(artist_id);
CREATE INDEX IF NOT EXISTS idx_tracks_status ON public.tracks(status);