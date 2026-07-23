BEGIN;

-- Artists
INSERT INTO public.artists (id, name, email, country)
VALUES
  (1, 'Taylor Avenue', 'hello@tayloravenue.com', 'US'),
  (2, 'Neon Harbor', 'contact@neonharbor.fm', 'GB'),
  (3, 'Kumquat Collective', 'team@kumquatcollective.org', 'AU')
ON CONFLICT (id) DO NOTHING;

-- Tracks (8+; using your table shape: id, title, artist_id, isrc, release_date, genre, status)
INSERT INTO public.tracks (id, title, artist_id, isrc, release_date, genre, status)
VALUES
  (101, 'Midnight Commute', 1, 'US-A1Z-24-00001', DATE '2024-01-18', 'Pop', 'draft'),
  (102, 'Signal in the Static', 1, 'US-A1Z-24-00002', DATE '2024-03-02', 'Synth-pop', 'submitted'),
  (103, 'Glass Skyline', 1, 'US-A1Z-24-00003', DATE '2024-05-21', 'Indie Pop', 'distributed'),

  (201, 'Harbor Lights (Radio Edit)', 2, 'GB-NH1-24-00001', DATE '2024-02-10', 'UK Garage', 'draft'),
  (202, 'Chrome Waves', 2, 'GB-NH1-24-00002', DATE '2024-04-14', 'Drum and Bass', 'submitted'),
  (203, 'Afterglow Boulevard', 2, 'GB-NH1-24-00003', DATE '2024-06-08', 'Electronic', 'distributed'),

  (301, 'Citrus Satellites', 3, 'AU-KC1-24-00001', DATE '2024-01-29', 'Alt Rock', 'submitted'),
  (302, 'Quiet Thunder', 3, 'AU-KC1-24-00002', DATE '2024-07-01', 'Indie Rock', 'distributed');

-- DSPs
INSERT INTO public.dsps (id, name)
VALUES
  (1001, 'Spotify'),
  (1002, 'Apple Music'),
  (1003, 'YouTube Music')
ON CONFLICT (id) DO NOTHING;

-- Optional: track distributions (keep it realistic across statuses)
INSERT INTO public.track_distributions (id, title, track_id, dsp_id, isrc, status, submitted_at)
VALUES
  (50001, 'Midnight Commute', 101, 1001, 'US-A1Z-24-00001', 'pending', NOW() - INTERVAL '20 days'),
  (50002, 'Signal in the Static', 102, 1001, 'US-A1Z-24-00002', 'live', NOW() - INTERVAL '40 days'),
  (50003, 'Glass Skyline', 103, 1002, 'US-A1Z-24-00003', 'live', NOW() - INTERVAL '35 days'),

  (50004, 'Harbor Lights (Radio Edit)', 201, 1003, 'GB-NH1-24-00001', 'pending', NOW() - INTERVAL '12 days'),
  (50005, 'Chrome Waves', 202, 1001, 'GB-NH1-24-00002', 'rejected', NOW() - INTERVAL '28 days'),
  (50006, 'Afterglow Boulevard', 203, 1002, 'GB-NH1-24-00003', 'live', NOW() - INTERVAL '33 days'),

  (50007, 'Citrus Satellites', 301, 1001, 'AU-KC1-24-00001', 'live', NOW() - INTERVAL '25 days'),
  (50008, 'Quiet Thunder', 302, 1003, 'AU-KC1-24-00002', 'live', NOW() - INTERVAL '18 days');

COMMIT;
