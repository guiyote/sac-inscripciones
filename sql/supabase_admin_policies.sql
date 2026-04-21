-- Permitir lectura a usuarios autenticados (admin)
-- Ejecutar en Supabase SQL Editor

CREATE POLICY "select_auth_karting" ON inscripciones_karting
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "select_auth_turismo" ON inscripciones_turismo
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "select_auth_regularidad" ON inscripciones_regularidad
  FOR SELECT TO authenticated USING (true);
