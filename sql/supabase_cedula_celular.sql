-- ============================================================
-- SAC Inscripciones - Agregar cédula y celular
-- Ejecutar en Supabase SQL Editor
-- ============================================================

-- Karting
ALTER TABLE inscripciones_karting
  ADD COLUMN IF NOT EXISTS cedula TEXT,
  ADD COLUMN IF NOT EXISTS celular TEXT;

-- Turismo
ALTER TABLE inscripciones_turismo
  ADD COLUMN IF NOT EXISTS cedula TEXT,
  ADD COLUMN IF NOT EXISTS celular TEXT;

-- Regularidad (piloto)
ALTER TABLE inscripciones_regularidad
  ADD COLUMN IF NOT EXISTS cedula_piloto TEXT,
  ADD COLUMN IF NOT EXISTS celular_piloto TEXT;
