-- Ubicación "Defectuoso" para repuestos que no sirven.
-- El stock en esta ubicación no se cuenta como stock disponible.

ALTER TABLE stock_ubicaciones
  ADD COLUMN IF NOT EXISTS es_descarte boolean NOT NULL DEFAULT false;

-- Crear la ubicación averiados (solo si no existe ya)
INSERT INTO stock_ubicaciones (nombre, es_descarte)
SELECT 'Defectuoso', true
WHERE NOT EXISTS (
  SELECT 1 FROM stock_ubicaciones WHERE nombre = 'Defectuoso'
);

-- Inicializar filas en stock_por_ubicacion para todos los artículos
-- (stock_actual = 0, se irá incrementando con traslados)
INSERT INTO stock_por_ubicacion (articulo_id, ubicacion_id, stock_actual)
SELECT a.id, u.id, 0
FROM stock_articulos a
CROSS JOIN stock_ubicaciones u
WHERE u.es_descarte = true
ON CONFLICT (articulo_id, ubicacion_id) DO NOTHING;
