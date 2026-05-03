-- Enki /goal operational visibility mirror.
-- Canonical runtime state remains Hermes SessionDB.state_meta under goal:<session_id>.
-- This table is best-effort local control-plane state for Enki/Postgres reporting.

create table if not exists enki_session_goals (
  session_id text primary key,
  goal text not null,
  status text not null check (status in ('active', 'paused', 'done', 'cleared')),
  turns_used integer not null default 0,
  max_turns integer not null default 20,
  last_verdict text,
  last_reason text,
  paused_reason text,
  state_json jsonb not null,
  created_at timestamptz not null default now(),
  last_turn_at timestamptz,
  modified_at timestamptz not null default now()
);

create index if not exists enki_session_goals_status_idx
  on enki_session_goals (status);

create index if not exists enki_session_goals_modified_at_idx
  on enki_session_goals (modified_at desc);
