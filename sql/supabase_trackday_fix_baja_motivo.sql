-- Renombra motivo_baja → baja_motivo en inscripciones_trackday
-- para ser consistente con todas las demás tablas de inscripciones.
-- Ejecutar una sola vez en el SQL Editor de Supabase.

ALTER TABLE public.inscripciones_trackday
  RENAME COLUMN motivo_baja TO baja_motivo;
