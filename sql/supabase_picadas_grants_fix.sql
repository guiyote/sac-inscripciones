-- Fix: grants faltantes en inscripciones_picadas
-- La tabla fue creada el 30 de abril sin GRANTs explícitos.
-- El GRANT fue agregado al SQL original el 13 de mayo pero puede no haberse aplicado.
-- Ejecutar en Supabase SQL Editor si el formulario de picadas falla al enviar.

GRANT SELECT ON public.inscripciones_picadas TO anon;
GRANT INSERT ON public.inscripciones_picadas TO anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.inscripciones_picadas TO authenticated;
GRANT ALL ON public.inscripciones_picadas TO service_role;
