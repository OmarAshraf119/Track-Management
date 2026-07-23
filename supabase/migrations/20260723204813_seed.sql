BEGIN;

-- 1) Artists (3) - create only if missing
INSERT INTO public.artists (name, email, country)
SELECT * FROM (
  VALUES
    ('Taylor Avenue', 'hello@tayloravenue.com', 'US'),
    ('Neon Harbor', 'contact@neonharbor.fm', 'GB'),
    ('Kumquat Collective', 'team@kumquatcollective.org', 'AU')
) AS v(name, email, country)
WHERE NOT EXISTS (
  SELECT 1 FROM public.artists a WHERE a.name = v.name
);

-- 2) Resolve artist IDs by name (works regardless of uniqueness constraints)
WITH art AS (
  SELECT id, name
  FROM public.artists
  WHERE name IN ('Taylor Avenue','Neon Harbor','Kumquat Collective')
),

-- 3) Tracks (8) - insert only if ISRC missing (your schema says tracks.isrc is UNIQUE)
ins_tracks AS (
  INSERT INTO public.tracks (title, artist_id, isrc, release_date, genre, status)
  SELECT
    v.title,
    art.id,
    v.isrc,
    v.release_date,
    v.genre,
    v.status
  FROM (
    VALUES
      ('Midnight Commute',        'Taylor Avenue',        'US-A1Z-24-00001'::text, DATE '2024-01-18', 'Pop',          'draft'::track_status),
      ('Signal in the Static',   'Taylor Avenue',        'US-A1Z-24-00002'::text, DATE '2024-03-02', 'Synth-pop',   'submitted'::track_status),
      ('Glass Skyline',          'Taylor Avenue',        'US-A1Z-24-00003'::text, DATE '2024-05-21', 'Indie Pop',   'distributed'::track_status),

      ('Harbor Lights (Radio Edit)', 'Neon Harbor',     'GB-NH1-24-00001'::text, DATE '2024-02-10', 'UK Garage',   'draft'::track_status),
      ('Chrome Waves',              'Neon Harbor',       'GB-NH1-24-00002'::text, DATE '2024-04-14', 'Drum and Bass','submitted'::track_status),
      ('Afterglow Boulevard',      'Neon Harbor',       'GB-NH1-24-00003'::text, DATE '2024-06-08', 'Electronic',  'distributed'::track_status),

      ('Citrus Satellites',        'Kumquat Collective','AU-KC1-24-00001'::text, DATE '2024-01-29', 'Alt Rock',    'submitted'::track_status),
      ('Quiet Thunder',           'Kumquat Collective',  'AU-KC1-24-00002'::text, DATE '2024-07-01', 'Indie Rock',  'distributed'::track_status)
  ) AS v(title, artist_name, isrc, release_date, genre, status)
  JOIN art ON art.name = v.artist_name
  WHERE NOT EXISTS (
    SELECT 1 FROM public.tracks t WHERE t.isrc = v.isrc
  )
  RETURNING id, isrc
),

-- 4) DSPs (3) - create only if missing by name
ins_dsps AS (
  INSERT INTO public.dsps (name)
  SELECT v.name
  FROM (
    VALUES
      ('Spotify'),('Apple Music'),('YouTube Music')
  ) AS v(name)
  WHERE NOT EXISTS (
    SELECT 1 FROM public.dsps d WHERE d.name = v.name
  )
)

-- 5) Track distributions (8+) - insert only if distribution ISRC missing (your schema says track_distributions.isrc is UNIQUE)
INSERT INTO public.track_distributions (title, track_id, dsp_id, isrc, status, submitted_at)
SELECT
  v.title,
  t.id AS track_id,
  d.id AS dsp_id,
  v.isrc,
  v.status,
  v.submitted_at
FROM (
  VALUES
    ('Midnight Commute',        'US-A1Z-24-00001'::text, 'Spotify',        'pending'::track_distribution_status,   NOW() - INTERVAL '20 days'),
    ('Signal in the Static',   'US-A1Z-24-00002'::text, 'Spotify',        'live'::track_distribution_status,      NOW() - INTERVAL '40 days'),
    ('Glass Skyline',          'US-A1Z-24-00003'::text, 'Apple Music',    'live'::track_distribution_status,      NOW() - INTERVAL '35 days'),

    ('Harbor Lights (Radio Edit)', 'GB-NH1-24-00001'::text, 'YouTube Music', 'pending'::track_distribution_status, NOW() - INTERVAL '12 days'),
    ('Chrome Waves',              'GB-NH1-24-00002'::text, 'Spotify',        'rejected'::track_distribution_status, NOW() - INTERVAL '28 days'),
    ('Afterglow Boulevard',      'GB-NH1-24-00003'::text, 'Apple Music',    'live'::track_distribution_status,      NOW() - INTERVAL '33 days'),

    ('Citrus Satellites',        'AU-KC1-24-00001'::text, 'Spotify',        'live'::track_distribution_status,      NOW() - INTERVAL '25 days'),
    ('Quiet Thunder',           'AU-KC1-24-00002'::text, 'YouTube Music',  'live'::track_distribution_status,      NOW() - INTERVAL '18 days')
) AS v(title, isrc, dsp_name, status, submitted_at)
JOIN public.tracks t ON t.isrc = v.isrc
JOIN public.dsps d ON d.name = v.dsp_name
WHERE NOT EXISTS (
  SELECT 1 FROM public.track_distributions td WHERE td.isrc = v.isrc
);

COMMIT;