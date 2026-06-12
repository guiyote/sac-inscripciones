-- Vincula cada devolución a la salida original que la originó
-- Ejecutar en el SQL Editor de Supabase

ALTER TABLE stock_movimientos
  ADD COLUMN IF NOT EXISTS origen_id UUID REFERENCES stock_movimientos(id);
