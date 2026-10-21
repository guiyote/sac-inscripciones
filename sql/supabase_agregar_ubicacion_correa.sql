-- ============================================================
-- SAC Stock - Agregar ubicación Emiliano Correa
-- Ejecutar en Supabase SQL Editor
-- ============================================================

-- Agregar la ubicación
INSERT INTO stock_ubicaciones (nombre) VALUES ('Emiliano Correa');

-- Inicializar stock en 0 para todos los artículos existentes
INSERT INTO stock_por_ubicacion (articulo_id, ubicacion_id, stock_actual)
SELECT a.id, u.id, 0
FROM stock_articulos a
CROSS JOIN stock_ubicaciones u
WHERE u.nombre = 'Emiliano Correa'
ON CONFLICT (articulo_id, ubicacion_id) DO NOTHING;
