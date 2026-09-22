# Reservas — Universo Park

Sistema simples de reservas: sem pagamento, lançamento manual já confirma. Roda como site estático (GitHub Pages) com banco no Supabase.

## 1. Criar o projeto Supabase

1. Acesse https://supabase.com e crie um projeto novo dedicado a isso (nome sugerido: `universo-park-reservas`).
2. Espere o projeto provisionar (leva um ou dois minutos).
3. Vá em **SQL Editor** e rode o conteúdo do arquivo `supabase-schema.sql` deste repositório. Isso cria a tabela, as políticas de acesso e liga o realtime.
4. Vá em **Project Settings → API** e copie:
   - **Project URL**
   - **anon public key**

## 2. Configurar o site

Abra `config.js` e cole os dois valores:

```js
window.SUPABASE_CONFIG = {
  url: "https://SEUPROJETO.supabase.co",
  anonKey: "SUA_ANON_KEY"
};
```

A chave `anon` é feita pra ficar pública em apps client-side como esse — quem protege os dados são as políticas (RLS) que já vêm no `supabase-schema.sql`. Nunca cole aqui a **service_role key** (essa sim é secreta).

## 3. Subir pro GitHub

```bash
cd universo-park-reservas
git init
git add .
git commit -m "primeira versão do sistema de reservas"
git branch -M main
git remote add origin https://github.com/SEU_USUARIO/universo-park-reservas.git
git push -u origin main
```

Troque `SEU_USUARIO` pelo seu usuário/organização do GitHub. Se o repositório ainda não existe, crie ele antes em https://github.com/new (pode ser privado).

## 4. Ativar o GitHub Pages

1. No repositório, vá em **Settings → Pages**.
2. Em **Source**, escolha **Deploy from a branch**.
3. Branch: **main**, pasta: **/ (root)**.
4. Salva. Em alguns minutos o site fica no ar em `https://SEU_USUARIO.github.io/universo-park-reservas/`.

A partir daí, todo `git push` pra `main` atualiza o site sozinho — não precisa repetir esses passos.

## O que mudou em relação à versão anterior (Claude Artifact)

- Banco agora é Supabase (Postgres de verdade, seu, exportável).
- Link é público na internet (GitHub Pages), sem depender de estar logado numa organização do Claude.
- **Saiu**: o recurso de colar texto do Direct/WhatsApp e a IA preencher os campos sozinha. Isso dependia de rodar dentro do Claude; pra recuperar isso aqui, precisaria de uma função de backend (Supabase Edge Function, por exemplo) que chama a API da Anthropic com uma chave guardada em segredo — dá pra montar depois, se quiser.
- Check-in (chegou/não veio), busca por nome/telefone e visão de semana continuam do mesmo jeito.
