-- NBA Mini App backend schema draft for Supabase/PostgreSQL.
-- Review and apply only after configuring authentication and RLS policies.
create extension if not exists pgcrypto;

create table if not exists public.players (
  id uuid primary key default gen_random_uuid(),
  telegram_user_id bigint unique not null,
  username text not null,
  created_at timestamptz not null default now(),
  constraint username_length check (char_length(username) between 3 and 24)
);

create table if not exists public.wallets (
  player_id uuid primary key references public.players(id) on delete cascade,
  demo_coin_balance bigint not null default 1200 check (demo_coin_balance >= 0),
  updated_at timestamptz not null default now()
);

create table if not exists public.ledger (
  id uuid primary key default gen_random_uuid(),
  player_id uuid not null references public.players(id),
  entry_type text not null check (entry_type in ('credit','debit','adjustment')),
  amount bigint not null check (amount > 0),
  currency text not null default 'DEMO_COIN',
  reason text not null,
  reference_id text unique,
  approved_by bigint,
  created_at timestamptz not null default now()
);

create table if not exists public.game_rounds (
  id uuid primary key default gen_random_uuid(),
  player_id uuid not null references public.players(id),
  game_type text not null check (game_type in ('six_dice','wheel')),
  selected_numbers smallint[] not null,
  results smallint[] not null,
  outcome_label text not null,
  demo_only boolean not null default true,
  created_at timestamptz not null default now(),
  constraint two_picks check (cardinality(selected_numbers) = 2),
  constraint dice_results check (
    (game_type = 'six_dice' and cardinality(results) = 6)
    or (game_type = 'wheel' and cardinality(results) = 1)
  )
);

create table if not exists public_payment_requests (
  id uuid primary key default gen_random_uuid(),
  player_id uuid not null references public.players(id),
  request_type text not null check (request_type in ('token_topup','withdrawal','ticket')),
  amount bigint not null check (amount > 0),
  payment_reference text,
  evidence_path text,
  status text not null default 'pending' check (status in ('pending','approved','rejected')),
  reviewed_by bigint,
  reviewed_at timestamptz,
  created_at timestamptz not null default now()
);

create table if not exists public.admin_audit_log (
  id uuid primary key default gen_random_uuid(),
  admin_telegram_user_id bigint not null,
  action text not null,
  target_id text,
  details jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

-- Production checklist:
-- 1. Enable RLS on every table.
-- 2. Do not grant clients direct INSERT/UPDATE on wallets or ledger.
-- 3. Validate Telegram initData and perform balance changes in server-side functions.
-- 4. Restrict admin actions to a server-verified allowlist; never trust a client flag.
-- 5. Add indexes, retention rules, monitoring and legal/payment controls before production.
