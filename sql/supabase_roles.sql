-- ============================================================
-- SAC - Sistema de roles (admin / viewer)
-- Ejecutar en Supabase SQL Editor
-- ============================================================

-- Tabla de roles por usuario
CREATE TABLE IF NOT EXISTS user_roles (
  user_id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  role TEXT NOT NULL DEFAULT 'viewer' CHECK (role IN ('admin', 'viewer'))
);

ALTER TABLE user_roles ENABLE ROW LEVEL SECURITY;

-- Cada usuario puede leer su propio rol
CREATE POLICY "select_own_role" ON user_roles FOR SELECT TO authenticated USING (auth.uid() = user_id);

-- Función que devuelve el rol del usuario actual
CREATE OR REPLACE FUNCTION get_my_role()
RETURNS TEXT AS $$
  SELECT role FROM user_roles WHERE user_id = auth.uid();
$$ LANGUAGE sql SECURITY DEFINER STABLE;

-- ============================================================
-- Restringir escrituras a solo admins
-- ============================================================

-- stock_articulos
DROP POLICY IF EXISTS "auth_update_articulos" ON stock_articulos;
CREATE POLICY "admin_update_articulos" ON stock_articulos FOR UPDATE TO authenticated
  USING (get_my_role() = 'admin');

-- stock_movimientos
DROP POLICY IF EXISTS "auth_insert_movimientos" ON stock_movimientos;
CREATE POLICY "admin_insert_movimientos" ON stock_movimientos FOR INSERT TO authenticated
  WITH CHECK (get_my_role() = 'admin');

DROP POLICY IF EXISTS "auth_update_movimientos" ON stock_movimientos;
CREATE POLICY "admin_update_movimientos" ON stock_movimientos FOR UPDATE TO authenticated
  USING (get_my_role() = 'admin');

-- stock_por_ubicacion
DROP POLICY IF EXISTS "auth_insert_stock_ub" ON stock_por_ubicacion;
CREATE POLICY "admin_insert_stock_ub" ON stock_por_ubicacion FOR INSERT TO authenticated
  WITH CHECK (get_my_role() = 'admin');

DROP POLICY IF EXISTS "auth_update_stock_ub" ON stock_por_ubicacion;
CREATE POLICY "admin_update_stock_ub" ON stock_por_ubicacion FOR UPDATE TO authenticated
  USING (get_my_role() = 'admin');

-- inscripciones (baja/pago en admin.html)
DROP POLICY IF EXISTS "auth_update_karting" ON inscripciones_karting;
CREATE POLICY "admin_update_karting" ON inscripciones_karting FOR UPDATE TO authenticated
  USING (get_my_role() = 'admin');

DROP POLICY IF EXISTS "auth_update_turismo" ON inscripciones_turismo;
CREATE POLICY "admin_update_turismo" ON inscripciones_turismo FOR UPDATE TO authenticated
  USING (get_my_role() = 'admin');

DROP POLICY IF EXISTS "auth_update_regularidad" ON inscripciones_regularidad;
CREATE POLICY "admin_update_regularidad" ON inscripciones_regularidad FOR UPDATE TO authenticated
  USING (get_my_role() = 'admin');

-- ============================================================
-- Asignar roles a usuarios existentes
-- Reemplazá el UUID por el user_id real de cada usuario en Auth > Users
-- ============================================================

-- Ejemplo:
-- INSERT INTO user_roles (user_id, role) VALUES
--   ('uuid-del-admin', 'admin'),
--   ('uuid-del-viewer', 'viewer')
-- ON CONFLICT (user_id) DO UPDATE SET role = EXCLUDED.role;
