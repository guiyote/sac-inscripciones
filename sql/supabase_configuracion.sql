-- Tabla de configuración general del sistema
CREATE TABLE IF NOT EXISTS configuracion (
  clave TEXT PRIMARY KEY,
  valor TEXT NOT NULL
);

INSERT INTO configuracion (clave, valor)
VALUES ('inscripciones_habilitadas', 'true')
ON CONFLICT (clave) DO NOTHING;

ALTER TABLE configuracion ENABLE ROW LEVEL SECURITY;

-- Lectura pública (anon y autenticados)
CREATE POLICY "lectura_publica" ON configuracion
  FOR SELECT USING (true);

-- Solo usuarios autenticados pueden actualizar
CREATE POLICY "escritura_autenticados" ON configuracion
  FOR UPDATE USING (auth.role() = 'authenticated');

-- Grants (required for new projects after May 30 2026 / existing projects after Oct 30 2026)
GRANT SELECT ON public.configuracion TO anon;
GRANT SELECT, UPDATE ON public.configuracion TO authenticated;
GRANT ALL ON public.configuracion TO service_role;
