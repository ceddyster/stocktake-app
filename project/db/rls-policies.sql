-- Row Level Security for the `public.stocktakes` table
-- (Supabase project ijzuvrwcfipvsxbxginz). This file documents the live policies;
-- they were applied via Supabase migrations, not run from here.
--
-- Model
-- -----
-- The whole app stores everything in one table: `stocktakes(code text pk, doc jsonb)`.
-- The `code` prefix decides what a row is:
--   p:<uid>  profile           a:<uid>  personal past-stocktakes (archive)
--   u:<uid>  active-stocktake pointer    m:<uid>  org membership
--   o:<id>   org record        oc:<CODE> invite-code -> org id
--   ou:<id>  org live stocktakes         oa:<id>  org shared archive
--   <CODE>   a stocktake document (5-char join code)
--
-- Personal rows (p:/a:/u:/m:) belong to exactly one signed-in account and are
-- locked to that owner. Everything else is shared: stocktakes are counted by
-- anonymous participants who join with just a code, so those rows stay reachable
-- by the anon key (the code is the credential, like a shared link). Org-level
-- isolation is deliberately NOT enforced at the DB layer because that would
-- require every counter to log in.
--
-- The client sends the user's Supabase auth token only for personal-prefixed
-- codes; all other calls use the anon key. So the counting/sync path never
-- depends on a token and can't break when one expires.

alter table public.stocktakes enable row level security;

-- Anonymous requests: everything except personal rows.
create policy "anon shared only" on public.stocktakes
  for all to anon
  using  (not (code like 'p:%' or code like 'a:%' or code like 'u:%' or code like 'm:%'))
  with check (not (code like 'p:%' or code like 'a:%' or code like 'u:%' or code like 'm:%'));

-- Signed-in requests: shared rows, plus this user's own personal rows.
create policy "auth own personal and shared" on public.stocktakes
  for all to authenticated
  using  ((not (code like 'p:%' or code like 'a:%' or code like 'u:%' or code like 'm:%'))
          or code = 'p:'||auth.uid()::text or code = 'a:'||auth.uid()::text
          or code = 'u:'||auth.uid()::text or code = 'm:'||auth.uid()::text)
  with check ((not (code like 'p:%' or code like 'a:%' or code like 'u:%' or code like 'm:%'))
          or code = 'p:'||auth.uid()::text or code = 'a:'||auth.uid()::text
          or code = 'u:'||auth.uid()::text or code = 'm:'||auth.uid()::text);
