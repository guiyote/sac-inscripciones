-- ============================================================
-- SAC Inscripciones - Actualización schema inscripciones_picadas
-- Ejecutar en Supabase SQL Editor
--
-- El formulario pasó a capturar datos por vehículo (dueño + número)
-- en vez de por piloto. Se eliminan los campos que ya no se usan.
-- ============================================================

-- Eliminar columnas que ya no se usan
ALTER TABLE inscripciones_picadas
  DROP COLUMN IF EXISTS nombre_piloto,
  DROP COLUMN IF EXISTS cedula,
  DROP COLUMN IF EXISTS fecha_nacimiento;

-- nombre_dueno y numero_vehiculo pasan a ser obligatorios
ALTER TABLE inscripciones_picadas
  ALTER COLUMN nombre_dueno SET NOT NULL,
  ALTER COLUMN numero_vehiculo SET NOT NULL;
