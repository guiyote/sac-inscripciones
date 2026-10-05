-- Karting SHIFTER 200cc standard: reemplaza el único "número de precinto" por 4 precintos
-- Ejecutar en el editor SQL de Supabase
-- Prerequisito: supabase_karting_motor_precintado.sql

ALTER TABLE inscripciones_karting ADD COLUMN IF NOT EXISTS precinto_tapa_valvula TEXT;
ALTER TABLE inscripciones_karting ADD COLUMN IF NOT EXISTS precinto_tapa_cilindro TEXT;
ALTER TABLE inscripciones_karting ADD COLUMN IF NOT EXISTS precinto_tapa_encendido TEXT;
ALTER TABLE inscripciones_karting ADD COLUMN IF NOT EXISTS precinto_carburador TEXT;

-- numero_precinto ya no se usa. Antes de borrarla, verificar que no haya datos:
--   SELECT id, nombre, numero_precinto FROM inscripciones_karting WHERE numero_precinto IS NOT NULL;
-- ALTER TABLE inscripciones_karting DROP COLUMN IF EXISTS numero_precinto;
