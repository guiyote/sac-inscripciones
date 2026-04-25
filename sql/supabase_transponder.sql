-- Agrega columna transponder a las tablas de inscripciones
-- Ejecutar en el editor SQL de Supabase
-- Prerequisito: supabase_pago_baja.sql

ALTER TABLE inscripciones_karting ADD COLUMN IF NOT EXISTS transponder TEXT;
ALTER TABLE inscripciones_turismo ADD COLUMN IF NOT EXISTS transponder TEXT;
ALTER TABLE inscripciones_regularidad ADD COLUMN IF NOT EXISTS transponder TEXT;
