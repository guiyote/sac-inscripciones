-- ============================================================
-- SAC Inscripciones - Tabla Picadas 201mts
-- Ejecutar en Supabase SQL Editor
-- ============================================================

CREATE TABLE IF NOT EXISTS inscripciones_picadas (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  fecha_carrera DATE NOT NULL,
  nombre_dueno TEXT,
  nombre_piloto TEXT NOT NULL,
  cedula TEXT,
  celular TEXT,
  fecha_nacimiento DATE,
  categoria TEXT NOT NULL,
  numero_vehiculo TEXT,
  reinscripcion BOOLEAN DEFAULT FALSE,
  pago_confirmado BOOLEAN DEFAULT FALSE,
  pago_monto NUMERIC(10,2),
  pago_fecha DATE,
  pago_medio TEXT,
  baja BOOLEAN DEFAULT FALSE,
  baja_motivo TEXT
);

ALTER TABLE inscripciones_picadas ENABLE ROW LEVEL SECURITY;

-- INSERT público (anon y autenticados)
CREATE POLICY "insert_public_picadas" ON inscripciones_picadas
  FOR INSERT WITH CHECK (true);

-- SELECT solo autenticados (admin)
CREATE POLICY "select_auth_picadas" ON inscripciones_picadas
  FOR SELECT TO authenticated USING (true);

-- UPDATE solo autenticados (admin)
CREATE POLICY "update_auth_picadas" ON inscripciones_picadas
  FOR UPDATE TO authenticated USING (true);

-- Agregar clave de configuración para habilitar/deshabilitar inscripciones
INSERT INTO configuracion (clave, valor)
VALUES ('inscripciones_picadas', 'true')
ON CONFLICT (clave) DO NOTHING;
