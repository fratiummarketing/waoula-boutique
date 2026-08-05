-- WAOULA CMS V5 — mise à jour non destructive
alter table public.site_settings add column if not exists primary_color text default '#d2b36f';
alter table public.site_settings add column if not exists secondary_color text default '#9b7a35';
alter table public.site_settings add column if not exists background_color text default '#ffffff';
alter table public.site_settings add column if not exists text_color text default '#080808';
alter table public.site_settings add column if not exists font_family text default 'Arial, Helvetica, sans-serif';
alter table public.site_settings add column if not exists favicon_url text default '';
alter table public.site_settings add column if not exists hero_poster_url text default '';

-- Les pages légales V5 utilisent les colonnes legal_* déjà créées en V4.
-- Les contenus peuvent désormais contenir du HTML produit par l’éditeur visuel.
