-- ============================================================
-- SAC Stock - Reset completo (arrancar de cero)
-- Ejecutar en Supabase SQL Editor
-- ============================================================

-- 1. Borrar todos los movimientos
DELETE FROM stock_movimientos;

-- 2. Resetear stock por ubicación a 0
UPDATE stock_por_ubicacion SET stock_actual = 0;

-- 3. Resetear stock_actual en artículos a 0
UPDATE stock_articulos SET stock_actual = 0;
