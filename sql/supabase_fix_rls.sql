-- ============================================================
-- Corregir políticas RLS para INSERT anónimo
-- Ejecutar en Supabase SQL Editor
-- ============================================================

-- Borrar políticas existentes y recrear correctamente
DROP POLICY IF EXISTS "insert_public_karting" ON inscripciones_karting;
DROP POLICY IF EXISTS "insert_public_turismo" ON inscripciones_turismo;
DROP POLICY IF EXISTS "insert_public_regularidad" ON inscripciones_regularidad;

-- Recrear permitiendo INSERT a cualquiera (anon + authenticated)
CREATE POLICY "insert_public_karting" ON inscripciones_karting
  FOR INSERT WITH CHECK (true);

CREATE POLICY "insert_public_turismo" ON inscripciones_turismo
  FOR INSERT WITH CHECK (true);

CREATE POLICY "insert_public_regularidad" ON inscripciones_regularidad
  FOR INSERT WITH CHECK (true);
