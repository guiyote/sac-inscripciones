-- Agrega 'devolucion' como valor válido en la columna tipo de stock_movimientos
-- Ejecutar en el SQL Editor de Supabase

ALTER TABLE stock_movimientos
  DROP CONSTRAINT IF EXISTS stock_movimientos_tipo_check;

ALTER TABLE stock_movimientos
  ADD CONSTRAINT stock_movimientos_tipo_check
  CHECK (tipo IN ('entrada', 'salida', 'transferencia', 'devolucion'));
