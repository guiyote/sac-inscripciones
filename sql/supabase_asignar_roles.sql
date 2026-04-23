-- ============================================================
-- SAC - Asignar roles a usuarios
-- Ejecutar en Supabase SQL Editor
-- ============================================================

INSERT INTO user_roles (user_id, role) VALUES
  ('ad9f2e54-02e7-436c-a84b-7ce184c2217d', 'admin'),
  ('f6cb2e14-5dc7-4548-af5e-c6822e5f0ead', 'admin'),
  ('6e874992-26cd-4784-b0f9-536ce149d2c8', 'admin'),
  ('5feb6693-ec86-41bf-bc3a-bf15c8db502e', 'admin'),
  ('f37efe7d-9dc5-4877-ba16-00754bf31e0c', 'viewer')
ON CONFLICT (user_id) DO UPDATE SET role = EXCLUDED.role;
