create extension if not exists pgcrypto;

create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  category text default '',
  sku text default '',
  price numeric(10,2) not null check (price >= 0),
  sale_price numeric(10,2) check (sale_price is null or sale_price >= 0),
  stock integer not null default 0 check (stock >= 0),
  description text default '',
  sizes jsonb not null default '["Unique"]'::jsonb,
  colors jsonb not null default '["Standard"]'::jsonb,
  variants jsonb not null default '[]'::jsonb,
  image_url text not null,
  gallery jsonb not null default '[]'::jsonb,
  featured boolean not null default false,
  position integer not null default 0,
  active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
alter table public.products add column if not exists category text default '';
alter table public.products add column if not exists sku text default '';
alter table public.products add column if not exists sale_price numeric(10,2);
alter table public.products add column if not exists stock integer not null default 0;
alter table public.products add column if not exists variants jsonb not null default '[]'::jsonb;
alter table public.products add column if not exists featured boolean not null default false;

create table if not exists public.site_settings (
  id integer primary key default 1 check (id = 1),
  shop_name text not null default 'WAOULA',
  slogan text default 'Pardonne. Avance. Réussis.',
  hero_eyebrow text default 'Collection 2026',
  hero_title text default 'PARDONNE.\nAVANCE.\nRÉUSSIS.',
  hero_text text default 'Streetwear premium minimaliste. Conçu pour bouger, pensé pour durer.',
  hero_button text default 'Découvrir la collection',
  hero_media_url text default '',
  logo_url text default '',
  email text default 'contact@waoula.fr',
  phone text default '',
  whatsapp text default '',
  instagram text default '',
  facebook text default '',
  tiktok text default '',
  address text default '',
  stripe_link text default '',
  paypal_link text default '',
  updated_at timestamptz not null default now()
);
insert into public.site_settings(id) values (1) on conflict (id) do nothing;

alter table public.products enable row level security;
alter table public.site_settings enable row level security;

drop policy if exists "Public can read active products" on public.products;
create policy "Public can read active products" on public.products for select using (active = true or auth.role() = 'authenticated');
drop policy if exists "Admins insert products" on public.products;
create policy "Admins insert products" on public.products for insert to authenticated with check (true);
drop policy if exists "Admins update products" on public.products;
create policy "Admins update products" on public.products for update to authenticated using (true) with check (true);
drop policy if exists "Admins delete products" on public.products;
create policy "Admins delete products" on public.products for delete to authenticated using (true);

drop policy if exists "Public reads settings" on public.site_settings;
create policy "Public reads settings" on public.site_settings for select using (true);
drop policy if exists "Admins update settings" on public.site_settings;
create policy "Admins update settings" on public.site_settings for update to authenticated using (true) with check (true);
drop policy if exists "Admins insert settings" on public.site_settings;
create policy "Admins insert settings" on public.site_settings for insert to authenticated with check (true);

insert into storage.buckets (id,name,public,file_size_limit,allowed_mime_types)
values ('site-assets','site-assets',true,10485760,array['image/jpeg','image/png','image/webp','image/gif','video/mp4','video/webm'])
on conflict (id) do update set public=true, file_size_limit=10485760, allowed_mime_types=array['image/jpeg','image/png','image/webp','image/gif','video/mp4','video/webm'];

drop policy if exists "Public views site assets" on storage.objects;
create policy "Public views site assets" on storage.objects for select using (bucket_id='site-assets');
drop policy if exists "Admins upload site assets" on storage.objects;
create policy "Admins upload site assets" on storage.objects for insert to authenticated with check (bucket_id='site-assets');
drop policy if exists "Admins update site assets" on storage.objects;
create policy "Admins update site assets" on storage.objects for update to authenticated using (bucket_id='site-assets');
drop policy if exists "Admins delete site assets" on storage.objects;
create policy "Admins delete site assets" on storage.objects for delete to authenticated using (bucket_id='site-assets');


-- Colonnes CMS V4
alter table public.site_settings add column if not exists collection_eyebrow text default 'Collection 2026';
alter table public.site_settings add column if not exists collection_title text default 'Une identité brute, pensée pour avancer.';
alter table public.site_settings add column if not exists collection_text text default 'WAOULA mélange esthétique streetwear, détails graphiques forts et pièces faciles à porter au quotidien. Une collection compacte, directe et premium.';
alter table public.site_settings add column if not exists shop_eyebrow text default 'Boutique';
alter table public.site_settings add column if not exists shop_title text default 'Nos essentiels';
alter table public.site_settings add column if not exists about_eyebrow text default 'À propos';
alter table public.site_settings add column if not exists about_title text default 'Pardonne. Avance. Réussis.';
alter table public.site_settings add column if not exists about_text text default 'WAOULA est une marque streetwear fondée sur une phrase simple : transformer le passé en énergie.';
alter table public.site_settings add column if not exists about_button text default 'Voir les produits';
alter table public.site_settings add column if not exists about_image_url text default '';
alter table public.site_settings add column if not exists benefit_1_title text default 'Respirant & extensible';
alter table public.site_settings add column if not exists benefit_1_text text default 'Confort au quotidien';
alter table public.site_settings add column if not exists benefit_2_title text default 'Maintien optimal';
alter table public.site_settings add column if not exists benefit_2_text text default 'Pour bouger librement';
alter table public.site_settings add column if not exists benefit_3_title text default 'Évacuation rapide';
alter table public.site_settings add column if not exists benefit_3_text text default 'Pensé pour la performance';
alter table public.site_settings add column if not exists benefit_4_title text default 'Qualité premium';
alter table public.site_settings add column if not exists benefit_4_text text default 'Finitions soignées';
alter table public.site_settings add column if not exists newsletter_eyebrow text default 'Newsletter';
alter table public.site_settings add column if not exists newsletter_title text default '-10% sur votre première commande';
alter table public.site_settings add column if not exists newsletter_button text default 'Recevoir mon code';
alter table public.site_settings add column if not exists newsletter_code text default 'WELCOME10';
alter table public.site_settings add column if not exists footer_shop_title text default 'Boutique';
alter table public.site_settings add column if not exists footer_info_title text default 'Infos';
alter table public.site_settings add column if not exists footer_contact_title text default 'Contact';
alter table public.site_settings add column if not exists contact_extra text default 'Réponse sous 24h.';
alter table public.site_settings add column if not exists legal_mentions text default 'WAOULA — marque streetwear premium. Email : contact@waoula.fr.';
alter table public.site_settings add column if not exists legal_cgv text default 'Les commandes sont réglées via Stripe ou PayPal. Les prix sont indiqués en euros TTC.';
alter table public.site_settings add column if not exists legal_privacy text default 'Les données collectées servent uniquement au traitement des commandes et à la newsletter si consentement.';
alter table public.site_settings add column if not exists legal_shipping text default 'Expédition sous 24/48h. Droit de rétractation de 14 jours après réception.';
