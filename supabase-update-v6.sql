-- WAOULA CMS V6 : lecture publique des réglages et rechargement du schéma
alter table public.site_settings enable row level security;
drop policy if exists "Public reads settings" on public.site_settings;
create policy "Public reads settings" on public.site_settings for select to anon, authenticated using (true);
grant select on table public.site_settings to anon, authenticated;
NOTIFY pgrst, 'reload schema';
