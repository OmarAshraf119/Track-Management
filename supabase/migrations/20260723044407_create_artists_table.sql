create table if not exists artists (
  id bigint primary key generated always as identity,
  name text not null,
  email text,
  country text
);

ALTER TABLE public.artists ENABLE ROW LEVEL SECURITY;

