-- Adds the Industry field (free text, e.g. Automotive, Consulting, Software).
alter table public.applications add column if not exists industry text;
