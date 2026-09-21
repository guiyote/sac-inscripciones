-- ============================================================
-- SAC Inscripciones - Agregar departamento a Turismo, Track Day y Regularidad
-- Ejecutar en Supabase SQL Editor ANTES de subir los formularios y el admin
-- Prerequisitos: supabase_setup.sql (karting ya tiene departamento), supabase_trackday.sql
-- Convención de nombres igual a cedula: sufijo _piloto / _conductor
-- ============================================================

-- Turismo
ALTER TABLE inscripciones_turismo
  ADD COLUMN IF NOT EXISTS departamento TEXT;

-- Regularidad (piloto)
ALTER TABLE inscripciones_regularidad
  ADD COLUMN IF NOT EXISTS departamento_piloto TEXT;

-- Track Day (conductor)
ALTER TABLE inscripciones_trackday
  ADD COLUMN IF NOT EXISTS departamento_conductor TEXT;
