-- Karting SHIFTER 200cc standard: motor precintado, número de motor y número de precinto
-- Ejecutar en el editor SQL de Supabase
-- Prerequisito: supabase_setup.sql

ALTER TABLE inscripciones_karting ADD COLUMN IF NOT EXISTS motor_precintado BOOLEAN;
ALTER TABLE inscripciones_karting ADD COLUMN IF NOT EXISTS numero_motor TEXT;
ALTER TABLE inscripciones_karting ADD COLUMN IF NOT EXISTS numero_precinto TEXT;
