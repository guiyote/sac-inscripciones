-- Configuración por página de inscripciones
-- Reemplaza la clave global 'inscripciones_habilitadas' con claves por categoría.
-- Requiere: supabase_configuracion.sql ejecutado previamente.

INSERT INTO configuracion (clave, valor) VALUES
  ('inscripciones_karting',      'true'),
  ('inscripciones_turismo',      'true'),
  ('inscripciones_regularidad',  'true'),
  ('inscripciones_trackday',     'true')
ON CONFLICT (clave) DO NOTHING;
