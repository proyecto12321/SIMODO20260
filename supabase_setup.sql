-- ============================================================
-- Ejecuta esto UNA sola vez en Supabase:
-- Panel de tu proyecto → SQL Editor → New query → pega esto → Run
-- ============================================================

create table if not exists public.sgi_kv (
    key text primary key,
    value jsonb not null,
    actualizado timestamptz default now()
);

-- Habilita seguridad a nivel de fila (obligatorio en Supabase)
alter table public.sgi_kv enable row level security;

-- El sistema ya tiene su propio login por DNI, así que permitimos que
-- la clave "anon" (pública) lea y escriba esta tabla. Si más adelante
-- quieres reforzarlo con el login real de Supabase, se puede restringir.
create policy "Permitir lectura publica sgi_kv"
    on public.sgi_kv for select
    to anon
    using (true);

create policy "Permitir escritura publica sgi_kv"
    on public.sgi_kv for insert
    to anon
    with check (true);

create policy "Permitir actualizacion publica sgi_kv"
    on public.sgi_kv for update
    to anon
    using (true);

create policy "Permitir borrado publico sgi_kv"
    on public.sgi_kv for delete
    to anon
    using (true);

-- ============================================================
-- BUCKET DE ARCHIVOS (fotos, logo institucional, PDFs, etc.)
-- ============================================================
-- Esto NO se puede crear por SQL en todos los proyectos; si el insert
-- de abajo falla, créalo manualmente: Panel → Storage → New bucket →
-- nombre "sgi-files" → marca "Public bucket" → Create.
insert into storage.buckets (id, name, public)
values ('sgi-files', 'sgi-files', true)
on conflict (id) do nothing;

-- Permite subir, leer, actualizar y borrar archivos en ese bucket
-- (igual que con sgi_kv, el sistema ya controla el acceso con su
-- propio login por DNI, así que se deja abierto a la clave anon).
create policy "Lectura publica sgi-files"
    on storage.objects for select
    to anon
    using (bucket_id = 'sgi-files');

create policy "Subida publica sgi-files"
    on storage.objects for insert
    to anon
    with check (bucket_id = 'sgi-files');

create policy "Actualizacion publica sgi-files"
    on storage.objects for update
    to anon
    using (bucket_id = 'sgi-files');

create policy "Borrado publico sgi-files"
    on storage.objects for delete
    to anon
    using (bucket_id = 'sgi-files');
