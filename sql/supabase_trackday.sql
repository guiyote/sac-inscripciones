-- Tabla para inscripciones Track Day
-- Ejecutar después de supabase_setup.sql

create table if not exists public.inscripciones_trackday (
  id              bigserial primary key,
  created_at      timestamptz default now(),
  fecha_carrera   date not null,
  nombre_conductor        text not null,
  cedula_conductor        text,
  celular_conductor       text,
  fecha_nacimiento_conductor date,
  nombre_acompanante      text,
  fecha_nacimiento_acompanante date,
  marca           text,
  modelo          text,
  anio            int,
  numero_auto     text,
  pago_confirmado boolean default false,
  pago_monto      numeric,
  pago_fecha      date,
  pago_medio      text,
  baja            boolean default false,
  motivo_baja     text
);

-- RLS: INSERT público (anon), SELECT solo autenticados
alter table public.inscripciones_trackday enable row level security;

create policy "anon puede insertar trackday"
  on public.inscripciones_trackday for insert
  to anon with check (true);

create policy "autenticados pueden leer trackday"
  on public.inscripciones_trackday for select
  to authenticated using (true);

create policy "autenticados pueden actualizar trackday"
  on public.inscripciones_trackday for update
  to authenticated using (true);
