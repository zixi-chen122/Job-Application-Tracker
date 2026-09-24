-- Adds a manual override for the role category tag (AI / ML, Data, ...).
-- Empty = auto-classify from the job title; '-' = explicitly no tag.
alter table public.applications add column if not exists category text;
