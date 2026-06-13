-- Fix: grants faltantes en inscripciones_trackday
-- La tabla fue creada antes de que se agregaran los GRANTs al SQL original.
-- Ejecutar en Supabase SQL Editor si el formulario público falla al enviar.

GRANT SELECT ON public.inscripciones_trackday TO anon;
GRANT INSERT ON public.inscripciones_trackday TO anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.inscripciones_trackday TO authenticated;
GRANT ALL ON public.inscripciones_trackday TO service_role;

-- Permite que el formulario público detecte duplicados (igual que inscripciones_picadas)
CREATE POLICY "select_anon_trackday" ON inscripciones_trackday
  FOR SELECT TO anon USING (true);
