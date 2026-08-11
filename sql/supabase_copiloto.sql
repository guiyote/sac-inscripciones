-- ============================================================
-- SAC Inscripciones - Tabla Copiloto (paseos de 4 vueltas para el público)
-- Ejecutar en Supabase SQL Editor
-- Prerequisito: supabase_setup.sql, supabase_configuracion.sql, supabase_roles.sql
-- ============================================================

CREATE TABLE IF NOT EXISTS public.inscripciones_copiloto (
  id                BIGSERIAL PRIMARY KEY,
  created_at        TIMESTAMPTZ DEFAULT NOW(),
  fecha_carrera     DATE NOT NULL,
  nombre            TEXT NOT NULL,
  cedula            TEXT NOT NULL,
  celular           TEXT,
  fecha_nacimiento  DATE NOT NULL,
  acepta_deslinde   BOOLEAN NOT NULL DEFAULT FALSE,
  pago_confirmado   BOOLEAN DEFAULT FALSE,
  pago_monto        NUMERIC(10,2),
  pago_fecha        DATE,
  pago_medio        TEXT,
  baja              BOOLEAN DEFAULT FALSE,
  baja_motivo       TEXT
);

ALTER TABLE public.inscripciones_copiloto ENABLE ROW LEVEL SECURITY;

-- INSERT público (anon y autenticados)
CREATE POLICY "insert_public_copiloto" ON public.inscripciones_copiloto
  FOR INSERT WITH CHECK (true);

-- SELECT público (anon necesita leer para detectar duplicados; autenticados = admin/viewer)
CREATE POLICY "select_public_copiloto" ON public.inscripciones_copiloto
  FOR SELECT USING (true);

-- UPDATE solo admins (pago, baja, modificación)
CREATE POLICY "admin_update_copiloto" ON public.inscripciones_copiloto
  FOR UPDATE TO authenticated USING (get_my_role() = 'admin');

-- Grants (requerido para que supabase-js vea la tabla)
GRANT SELECT, INSERT ON public.inscripciones_copiloto TO anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.inscripciones_copiloto TO authenticated;
GRANT ALL ON public.inscripciones_copiloto TO service_role;

-- Habilitar/deshabilitar desde el panel de configuración (inscripciones-config.html)
INSERT INTO configuracion (clave, valor)
VALUES ('inscripciones_copiloto', 'true')
ON CONFLICT (clave) DO NOTHING;
