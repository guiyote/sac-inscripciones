-- Agregar fecha_carrera a stock_movimientos para poder filtrar ventas por fecha de carrera
ALTER TABLE stock_movimientos
  ADD COLUMN IF NOT EXISTS fecha_carrera DATE;
