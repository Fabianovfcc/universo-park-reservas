-- Rode isso no SQL Editor do seu projeto Supabase novo (dedicado a esse sistema de reservas).

create table if not exists reservations (
  id uuid primary key default gen_random_uuid(),
  nome text not null,
  telefone text not null default '',
  data date not null,
  horario text not null,
  pessoas integer not null default 1,
  observacao text not null default '',
  atendente text not null default '',
  status text not null default 'pendente',
  criado_em timestamptz not null default now()
);

create index if not exists reservations_data_idx on reservations (data);
create index if not exists reservations_nome_idx on reservations (nome);

-- Ativa Row Level Security
alter table reservations enable row level security;

-- Acesso liberado pra chave anon (sem login de usuário) -- é uma ferramenta interna simples,
-- então qualquer pessoa com o link do site consegue ler e escrever. Se quiser travar mais no
-- futuro (ex: exigir login), me avisa que a gente ajusta essas policies.
create policy "allow all select" on reservations for select using (true);
create policy "allow all insert" on reservations for insert with check (true);
create policy "allow all update" on reservations for update using (true);
create policy "allow all delete" on reservations for delete using (true);

-- Ativa realtime (pra tela atualizar sozinha quando alguém lança/edita uma reserva)
alter publication supabase_realtime add table reservations;
