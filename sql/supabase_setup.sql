-- ============================================================
-- SAC Inscripciones - Setup de tablas
-- Ejecutar en Supabase SQL Editor
-- ============================================================

-- TABLA: Inscripciones Karting
CREATE TABLE IF NOT EXISTS inscripciones_karting (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  fecha_carrera DATE NOT NULL,
  nombre TEXT NOT NULL,
  departamento TEXT,
  fecha_nacimiento DATE,
  cilindrada TEXT NOT NULL,
  numero_kart TEXT
);

-- TABLA: Inscripciones Turismo (TNS/TMZ)
CREATE TABLE IF NOT EXISTS inscripciones_turismo (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  fecha_carrera DATE NOT NULL,
  nombre TEXT NOT NULL,
  fecha_nacimiento DATE,
  categoria TEXT NOT NULL,
  numero_auto TEXT,
  marca_modelo TEXT,
  nombre_concurrente TEXT,
  nombre_equipo TEXT,
  cantidad_gomas INTEGER,
  cantidad_pastillas INTEGER,
  cantidad_discos INTEGER
);

-- TABLA: Inscripciones Regularidad
CREATE TABLE IF NOT EXISTS inscripciones_regularidad (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  fecha_carrera DATE NOT NULL,
  nombre_piloto TEXT NOT NULL,
  fecha_nacimiento_piloto DATE,
  nombre_navegante TEXT,
  fecha_nacimiento_navegante DATE,
  marca TEXT,
  modelo TEXT,
  anio INTEGER,
  numero_auto TEXT
);

-- ============================================================
-- Row Level Security: permitir INSERT público (sin auth)
-- ============================================================
ALTER TABLE inscripciones_karting ENABLE ROW LEVEL SECURITY;
ALTER TABLE inscripciones_turismo ENABLE ROW LEVEL SECURITY;
ALTER TABLE inscripciones_regularidad ENABLE ROW LEVEL SECURITY;

-- Política: cualquiera puede insertar
CREATE POLICY "insert_public_karting" ON inscripciones_karting
  FOR INSERT TO anon WITH CHECK (true);

CREATE POLICY "insert_public_turismo" ON inscripciones_turismo
  FOR INSERT TO anon WITH CHECK (true);

CREATE POLICY "insert_public_regularidad" ON inscripciones_regularidad
  FOR INSERT TO anon WITH CHECK (true);

-- Política: solo autenticados pueden leer (para el admin)
CREATE POLICY "select_auth_karting" ON inscripciones_karting
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "select_auth_turismo" ON inscripciones_turismo
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "select_auth_regularidad" ON inscripciones_regularidad
  FOR SELECT TO authenticated USING (true);
