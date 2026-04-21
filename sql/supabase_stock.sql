-- ============================================================
-- SAC Stock - Tablas de repuestos
-- Ejecutar en Supabase SQL Editor
-- ============================================================

-- Tabla de artículos (fija, se carga con los 4 items)
CREATE TABLE IF NOT EXISTS stock_articulos (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  nombre TEXT NOT NULL,
  precio_usd NUMERIC(10,2) NOT NULL,
  stock_actual INTEGER DEFAULT 0
);

-- Tabla de movimientos (entradas y salidas)
CREATE TABLE IF NOT EXISTS stock_movimientos (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  articulo_id UUID REFERENCES stock_articulos(id),
  tipo TEXT NOT NULL, -- 'entrada' | 'salida'
  cantidad INTEGER NOT NULL,
  -- Solo para salidas
  piloto TEXT,
  pago_confirmado BOOLEAN DEFAULT FALSE,
  pago_monto NUMERIC(10,2),
  pago_medio TEXT, -- 'efectivo' | 'transferencia'
  pago_fecha DATE,
  -- Para entradas
  proveedor TEXT,
  notas TEXT
);

-- RLS
ALTER TABLE stock_articulos ENABLE ROW LEVEL SECURITY;
ALTER TABLE stock_movimientos ENABLE ROW LEVEL SECURITY;

-- Solo autenticados pueden leer y escribir
CREATE POLICY "auth_select_articulos" ON stock_articulos FOR SELECT TO authenticated USING (true);
CREATE POLICY "auth_update_articulos" ON stock_articulos FOR UPDATE TO authenticated USING (true);

CREATE POLICY "auth_select_movimientos" ON stock_movimientos FOR SELECT TO authenticated USING (true);
CREATE POLICY "auth_insert_movimientos" ON stock_movimientos FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "auth_update_movimientos" ON stock_movimientos FOR UPDATE TO authenticated USING (true);

-- Cargar los 4 artículos iniciales
INSERT INTO stock_articulos (nombre, precio_usd, stock_actual) VALUES
  ('Pastillas', 120.00, 0),
  ('Cubiertas', 60.00, 0),
  ('Discos de freno', 70.00, 0),
  ('Difusores (TNS)', 120.00, 0);
