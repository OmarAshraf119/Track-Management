-- 2026xxxxxx_artists_tracks_rls.sql

-- 1) Enable RLS
ALTER TABLE public.artists ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tracks ENABLE ROW LEVEL SECURITY;

-- Optional but recommended to avoid “bypass” surprises
-- ALTER TABLE public.artists FORCE ROW LEVEL SECURITY;
-- ALTER TABLE public.tracks FORCE ROW LEVEL SECURITY;

-- 2) ARTISTS policies (authenticated: read all, write all)
CREATE POLICY artists_auth_select_all
ON public.artists
FOR SELECT
TO authenticated
USING (true);

CREATE POLICY artists_auth_insert_all
ON public.artists
FOR INSERT
TO authenticated
WITH CHECK (true);

CREATE POLICY artists_auth_update_all
ON public.artists
FOR UPDATE
TO authenticated
USING (true)
WITH CHECK (true);

CREATE POLICY artists_auth_delete_all
ON public.artists
FOR DELETE
TO authenticated
USING (true);

-- 3) TRACKS policies (authenticated: read all, write all)
CREATE POLICY tracks_auth_select_all
ON public.tracks
FOR SELECT
TO authenticated
USING (true);

CREATE POLICY tracks_auth_insert_all
ON public.tracks
FOR INSERT
TO authenticated
WITH CHECK (true);

CREATE POLICY tracks_auth_update_all
ON public.tracks
FOR UPDATE
TO authenticated
USING (true)
WITH CHECK (true);

CREATE POLICY tracks_auth_delete_all
ON public.tracks
FOR DELETE
TO authenticated
USING (true);

-- 4) Privileges for PostgREST roles (minimum typical CRUD)
-- If you already have these grants, these are harmless in practice but may error
-- if your org enforces strict migrations; remove if already present.
GRANT SELECT, INSERT, UPDATE, DELETE ON public.artists TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.tracks TO authenticated;