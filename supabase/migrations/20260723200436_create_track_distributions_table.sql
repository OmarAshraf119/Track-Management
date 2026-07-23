
-- Optional: create an enum for status (safe if already created)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'track_distribution_status') THEN
    CREATE TYPE public.track_distribution_status AS ENUM ('pending', 'live', 'rejected');
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS public.track_distributions (
  id bigint primary key generated always as identity,
  title text NOT NULL,

  -- FK to public.tracks(id)
  track_id bigint NOT NULL REFERENCES public.tracks(id) ON DELETE CASCADE,
-- FK to public.dsps(id)
  dsp_id  bigint NOT NULL REFERENCES public.dsps(id) ON DELETE CASCADE,

  -- ISRC is unique per track
  isrc text NOT NULL UNIQUE,


  -- Release date

  status public.track_distribution_status NOT NULL DEFAULT 'pending',

  submitted_at timestamptz NOT NULL DEFAULT now()

);
