-- DimiEat : à exécuter une fois dans Supabase > SQL Editor
-- Tables préfixées dimi_ pour cohabiter avec d'autres projets (ex. ADbot) dans le même projet Supabase.

create table if not exists public.dimi_aliments (
  id uuid primary key default gen_random_uuid(),
  nom text not null check (char_length(nom) between 1 and 40),
  cat text not null,
  emoji text default '',
  alg text default '',
  par text default '',
  created_at timestamptz not null default now()
);

create table if not exists public.dimi_essais (
  id uuid primary key default gen_random_uuid(),
  aliment text not null,               -- id d'un aliment intégré (b-...) ou uuid d'un aliment ajouté
  date date not null default current_date,
  reaction text default '' check (reaction in ('', 'adore', 'aime', 'bof', 'pas', 'vomi')),
  note text default '' check (char_length(note) <= 300),
  alerte boolean not null default false,
  par text default '',
  created_at timestamptz not null default now()
);
create index if not exists dimi_essais_aliment_idx on public.dimi_essais (aliment);

-- Seuls les comptes connectés (vous deux) peuvent lire et écrire
alter table public.dimi_aliments enable row level security;
alter table public.dimi_essais   enable row level security;

drop policy if exists "dimieat_famille" on public.dimi_aliments;
drop policy if exists "dimieat_famille" on public.dimi_essais;
create policy "dimieat_famille" on public.dimi_aliments for all to authenticated using (true) with check (true);
create policy "dimieat_famille" on public.dimi_essais   for all to authenticated using (true) with check (true);

-- Synchro en temps réel entre les téléphones
alter publication supabase_realtime add table public.dimi_aliments, public.dimi_essais;
