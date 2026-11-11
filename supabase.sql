-- Run once in Supabase: SQL Editor > New query > paste > Run
create table if not exists public.transactions(
  id text primary key,
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  date date not null,
  type text not null check (type in ('Income','Expense')),
  cat text not null,
  sub text not null,
  amt numeric(12,2) not null check (amt >= 0),
  mv numeric(12,2) not null default 0 check (mv >= 0 and mv <= amt),
  note text not null default '',
  updated_at timestamptz not null default now()
);
create index if not exists transactions_user_date on public.transactions(user_id, date);
create table if not exists public.settings(
  user_id uuid primary key default auth.uid() references auth.users(id) on delete cascade,
  data jsonb not null default '{}'
);
alter table public.transactions enable row level security;
alter table public.settings enable row level security;
create policy "own transactions" on public.transactions for all to authenticated
  using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy "own settings" on public.settings for all to authenticated
  using (user_id = auth.uid()) with check (user_id = auth.uid());

-- Explicit access rights. Needed if "Automatically expose new tables" is turned off
-- (recommended); harmless if it is on. Only signed-in users get access; anonymous visitors get none.
grant usage on schema public to authenticated;
grant select, insert, update, delete on public.transactions to authenticated;
grant select, insert, update, delete on public.settings to authenticated;
