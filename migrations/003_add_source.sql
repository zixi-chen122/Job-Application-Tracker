-- Adds the Source field (LinkedIn, Xing, StepStone, ... or a raw domain).
-- Empty means "not chosen yet"; the app then falls back to the link's domain.
alter table public.applications add column if not exists source text;
