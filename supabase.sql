-- Run this in Supabase Dashboard > SQL Editor.
create table if not exists public.rpg_saves (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.rpg_saves enable row level security;
create policy "users manage own save" on public.rpg_saves
  for all using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
