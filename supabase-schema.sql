-- Run this complete file in Supabase SQL Editor.
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  role text not null default 'student' check (role in ('student','admin')),
  created_at timestamptz not null default now()
);

create table if not exists public.exercises (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  image_url text not null,
  correct_text text not null,
  published boolean not null default true,
  created_by uuid references auth.users(id),
  created_at timestamptz not null default now()
);

create table if not exists public.results (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  exercise_id uuid references public.exercises(id) on delete set null,
  practice_type text not null check (practice_type in ('shorthand','typing')),
  accuracy numeric,
  gross_wpm numeric,
  net_wpm numeric,
  details jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into public.profiles (id, full_name)
  values (new.id, coalesce(new.raw_user_meta_data->>'full_name','Student'))
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
after insert on auth.users
for each row execute procedure public.handle_new_user();

alter table public.profiles enable row level security;
alter table public.exercises enable row level security;
alter table public.results enable row level security;

-- Security-definer helper avoids recursive profile-policy checks.
create or replace function public.is_admin()
returns boolean language sql stable security definer set search_path = public as $$
  select exists (select 1 from public.profiles where id = auth.uid() and role = 'admin');
$$;

-- Profile: each student can read their own profile; admins can read all profiles.
drop policy if exists "Read own profile or admin" on public.profiles;
create policy "Read own profile or admin" on public.profiles for select to authenticated
using (id = auth.uid() or public.is_admin());

-- Students can see published exercises. Admins can manage all exercises.
drop policy if exists "Read published exercises" on public.exercises;
create policy "Read published exercises" on public.exercises for select to authenticated
using (published = true or public.is_admin());
drop policy if exists "Admin insert exercises" on public.exercises;
create policy "Admin insert exercises" on public.exercises for insert to authenticated
with check (public.is_admin());
drop policy if exists "Admin update exercises" on public.exercises;
create policy "Admin update exercises" on public.exercises for update to authenticated
using (public.is_admin())
with check (public.is_admin());
drop policy if exists "Admin delete exercises" on public.exercises;
create policy "Admin delete exercises" on public.exercises for delete to authenticated
using (public.is_admin());

-- Students can insert and read their own results; admins can read all results.
drop policy if exists "Insert own results" on public.results;
create policy "Insert own results" on public.results for insert to authenticated
with check (user_id = auth.uid());
drop policy if exists "Read own results or admin" on public.results;
create policy "Read own results or admin" on public.results for select to authenticated
using (user_id = auth.uid() or public.is_admin());

-- After registering your own account, replace YOUR_EMAIL below and run this once
-- to grant yourself admin access:
-- update public.profiles p set role='admin'
-- from auth.users u where p.id=u.id and u.email='YOUR_EMAIL';
