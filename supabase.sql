-- DimiEat : à exécuter une fois dans Supabase > SQL Editor

create table if not exists public.aliments (
  id uuid primary key default gen_random_uuid(),
  nom text not null check (char_length(nom) between 1 and 40),
  cat text not null,
  emoji text default '',
  alg text default '',
  par text default '',
  created_at timestamptz not null default now()
);

create table if not exists public.essais (
  id uuid primary key default gen_random_uuid(),
  aliment text not null,               -- id d'un aliment intégré (b-...) ou uuid d'un aliment ajouté
  date date not null default current_date,
  reaction text default '' check (reaction in ('', 'adore', 'aime', 'bof', 'pas', 'vomi')),
  note text default '' check (char_length(note) <= 300),
  alerte boolean not null default false,
  par text default '',
  created_at timestamptz not null default now()
);
create index if not exists essais_aliment_idx on public.essais (aliment);

-- Seuls les comptes connectés (vous deux) peuvent lire et écrire
alter table public.aliments enable row level security;
alter table public.essais   enable row level security;

drop policy if exists "famille" on public.aliments;
drop policy if exists "famille" on public.essais;
create policy "famille" on public.aliments for all to authenticated using (true) with check (true);
create policy "famille" on public.essais   for all to authenticated using (true) with check (true);

-- Accès de l'API pour les comptes connectés (nécessaire si « Grant API access to new tables automatically » est décoché)
grant select, insert, update, delete on public.aliments to authenticated;
grant select, insert, update, delete on public.essais   to authenticated;

-- Synchro en temps réel entre les téléphones
alter publication supabase_realtime add table public.aliments, public.essais;
