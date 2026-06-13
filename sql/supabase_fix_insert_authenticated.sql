-- Fix: permitir INSERT a usuarios autenticados en formularios de inscripción
-- Las policies originales solo tenían TO anon, bloqueando inserts cuando el admin está logueado.
-- Ejecutar en Supabase SQL Editor.

CREATE POLICY "autenticados pueden insertar trackday"
  ON public.inscripciones_trackday FOR INSERT
  TO authenticated WITH CHECK (true);

CREATE POLICY "insert_auth_karting"
  ON public.inscripciones_karting FOR INSERT
  TO authenticated WITH CHECK (true);

CREATE POLICY "insert_auth_turismo"
  ON public.inscripciones_turismo FOR INSERT
  TO authenticated WITH CHECK (true);

CREATE POLICY "insert_auth_regularidad"
  ON public.inscripciones_regularidad FOR INSERT
  TO authenticated WITH CHECK (true);
