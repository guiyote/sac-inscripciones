-- ============================================================
-- SAC Inscripciones - Recargo por inscripción tardía
-- Ejecutar en Supabase SQL Editor (después de supabase_pago_baja.sql)
-- ============================================================
-- Marca las inscripciones realizadas después del jueves previo a la
-- fecha de carrera, para que el admin sepa que debe cobrar $500 extra.

ALTER TABLE inscripciones_karting
  ADD COLUMN IF NOT EXISTS con_recargo BOOLEAN DEFAULT FALSE;

ALTER TABLE inscripciones_turismo
  ADD COLUMN IF NOT EXISTS con_recargo BOOLEAN DEFAULT FALSE;

ALTER TABLE inscripciones_regularidad
  ADD COLUMN IF NOT EXISTS con_recargo BOOLEAN DEFAULT FALSE;
