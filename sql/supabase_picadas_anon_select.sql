-- ============================================================
-- SAC Inscripciones - Habilitar SELECT anon en inscripciones_picadas
-- Ejecutar en Supabase SQL Editor
--
-- El formulario público necesita leer la tabla para:
--   1. Verificar que existe inscripción base antes de reinscripción
--   2. Detectar número de vehículo duplicado
-- Sin esta política, ambas validaciones siempre devuelven vacío
-- porque el usuario no está autenticado.
-- ============================================================

CREATE POLICY "select_anon_picadas" ON inscripciones_picadas
  FOR SELECT TO anon USING (true);
