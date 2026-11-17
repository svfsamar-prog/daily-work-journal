-- Daily Work Journal Schema for Supabase
-- Run this in Supabase SQL Editor if setting up a new project

create table if not exists public.profile (
  user_id uuid primary key references auth.users(id) on delete cascade,
  name text,
  employee_id text,
  designation text,
  branch text,
  updated_at timestamptz default now()
);

create table if not exists public.entries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  entry_date date not null,
  to_date date,
  task text not null,
  status text not null default 'Done' check (status in ('Done','Pending','Follow-up')),
  remarks text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);
create index if not exists entries_user_date on public.entries(user_id, entry_date);

create table if not exists public.holidays (
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  holiday_date date not null,
  name text not null,
  primary key (user_id, holiday_date)
);

alter table public.profile  enable row level security;
alter table public.entries  enable row level security;
alter table public.holidays enable row level security;

do $$
begin
  if not exists (select 1 from pg_policies where tablename = 'profile' and policyname = 'own profile') then
    create policy "own profile" on public.profile for all using (user_id = auth.uid()) with check (user_id = auth.uid());
  end if;
  if not exists (select 1 from pg_policies where tablename = 'entries' and policyname = 'own entries') then
    create policy "own entries" on public.entries for all using (user_id = auth.uid()) with check (user_id = auth.uid());
  end if;
  if not exists (select 1 from pg_policies where tablename = 'holidays' and policyname = 'own holidays') then
    create policy "own holidays" on public.holidays for all using (user_id = auth.uid()) with check (user_id = auth.uid());
  end if;
end $$;
