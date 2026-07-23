create table if not exists artists (
  id bigint primary key generated always as identity,
  name text not null,
  email text,
  country text
);