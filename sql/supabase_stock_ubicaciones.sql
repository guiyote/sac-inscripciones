-- ============================================================
-- SAC Stock - Agregar ubicaciones
-- Ejecutar en Supabase SQL Editor
-- ============================================================

-- Tabla de ubicaciones
CREATE TABLE IF NOT EXISTS stock_ubicaciones (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  nombre TEXT NOT NULL
);

-- RLS
ALTER TABLE stock_ubicaciones ENABLE ROW LEVEL SECURITY;
CREATE POLICY "auth_select_ubicaciones" ON stock_ubicaciones FOR SELECT TO authenticated USING (true);

-- Cargar las 3 ubicaciones
INSERT INTO stock_ubicaciones (nombre) VALUES
  ('Todo Truck'),
  ('André Lafon'),
  ('El Revoltijo');

-- Agregar columna ubicacion_id a stock_articulos
-- Ahora el stock se maneja por artículo + ubicación en una tabla separada
CREATE TABLE IF NOT EXISTS stock_por_ubicacion (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  articulo_id UUID REFERENCES stock_articulos(id),
  ubicacion_id UUID REFERENCES stock_ubicaciones(id),
  stock_actual INTEGER DEFAULT 0,
  UNIQUE(articulo_id, ubicacion_id)
);

ALTER TABLE stock_por_ubicacion ENABLE ROW LEVEL SECURITY;
CREATE POLICY "auth_select_stock_ub" ON stock_por_ubicacion FOR SELECT TO authenticated USING (true);
CREATE POLICY "auth_insert_stock_ub" ON stock_por_ubicacion FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "auth_update_stock_ub" ON stock_por_ubicacion FOR UPDATE TO authenticated USING (true);

-- Agregar columna ubicacion_id a stock_movimientos
ALTER TABLE stock_movimientos
  ADD COLUMN IF NOT EXISTS ubicacion_id UUID REFERENCES stock_ubicaciones(id);

-- Inicializar stock_por_ubicacion con 0 para cada artículo x ubicación
INSERT INTO stock_por_ubicacion (articulo_id, ubicacion_id, stock_actual)
SELECT a.id, u.id, 0
FROM stock_articulos a
CROSS JOIN stock_ubicaciones u
ON CONFLICT (articulo_id, ubicacion_id) DO NOTHING;
