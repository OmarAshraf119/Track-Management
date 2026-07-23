-- 2026xxxxxx_dsps_track_distributions_rls.sql

-- Enable RLS
ALTER TABLE public.dsps ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.track_distributions ENABLE ROW LEVEL SECURITY;

-- D S P S
CREATE POLICY dsps_auth_select_all
ON public.dsps
FOR SELECT
TO authenticated
USING (true);

CREATE POLICY dsps_auth_insert_all
ON public.dsps
FOR INSERT
TO authenticated
WITH CHECK (true);

CREATE POLICY dsps_auth_update_all
ON public.dsps
FOR UPDATE
TO authenticated
USING (true)
WITH CHECK (true);

CREATE POLICY dsps_auth_delete_all
ON public.dsps
FOR DELETE
TO authenticated
USING (true);

-- T R A C K  D I S T R I B U T I O N S
CREATE POLICY track_distributions_auth_select_all
ON public.track_distributions
FOR SELECT
TO authenticated
USING (true);

CREATE POLICY track_distributions_auth_insert_all
ON public.track_distributions
FOR INSERT
TO authenticated
WITH CHECK (true);

CREATE POLICY track_distributions_auth_update_all
ON public.track_distributions
FOR UPDATE
TO authenticated
USING (true)
WITH CHECK (true);

CREATE POLICY track_distributions_auth_delete_all
ON public.track_distributions
FOR DELETE
TO authenticated
USING (true);

-- Grants (typical for PostgREST/Data API usage)
GRANT SELECT, INSERT, UPDATE, DELETE ON public.dsps TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.track_distributions TO authenticated;