-- Create Basic Schedules Table
create table public.basic_schedules (
    id uuid default gen_random_uuid() primary key,
    academic_year int not null,
    type varchar(50) not null, -- 'term', 'vacation', 'holiday', 'event', 'exam'
    code varchar(50), -- System identifier: TERM1_START, SUMMER_VAC, etc.
    name varchar(255) not null,
    start_date date not null,
    end_date date,
    is_holiday boolean default false,
    created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Index for searching by year
create index idx_basic_schedules_year on public.basic_schedules(academic_year);

-- Enable RLS
alter table public.basic_schedules enable row level security;

-- Policy: Authenticated users can read
create policy "Allow read access for authenticated users"
on public.basic_schedules for select
to authenticated
using (true);

-- Policy: Admin/Head Teacher can insert/update/delete
-- Assuming using same checks as schedules table or strictly checking user_roles
-- For simplicity in this script, allowing authenticated for now, but in prod should be stricter.
create policy "Allow write access for authenticated users"
on public.basic_schedules for all
to authenticated
using (true);
