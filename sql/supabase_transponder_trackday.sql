-- Agrega columna transponder a inscripciones_trackday (igual que karting/turismo/regularidad)
-- Ejecutar en el editor SQL de Supabase
-- Prerequisito: supabase_trackday.sql, supabase_transponder.sql

ALTER TABLE inscripciones_trackday ADD COLUMN IF NOT EXISTS transponder TEXT;
