-- ============================================================
-- SAC Stock - Agregar ubicación Eduardo Ramirez
-- Ejecutar en Supabase SQL Editor
-- ============================================================

-- Agregar la ubicación
INSERT INTO stock_ubicaciones (nombre) VALUES ('Eduardo Ramirez');

-- Inicializar stock en 0 para todos los artículos existentes
INSERT INTO stock_por_ubicacion (articulo_id, ubicacion_id, stock_actual)
SELECT a.id, u.id, 0
FROM stock_articulos a
CROSS JOIN stock_ubicaciones u
WHERE u.nombre = 'Eduardo Ramirez'
ON CONFLICT (articulo_id, ubicacion_id) DO NOTHING;
