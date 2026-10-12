-- Adds when and at which stage an application was rejected
-- (Resume, Screening, Assessment or Interview).
alter table public.applications add column if not exists rejected_date date;
alter table public.applications add column if not exists rejected_stage text;

-- Rejections recorded before this change are counted as rejected at Resume.
update public.applications
set rejected_stage = 'Resume'
where status = 'Rejected' and rejected_stage is null;
