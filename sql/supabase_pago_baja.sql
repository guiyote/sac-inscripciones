-- ============================================================
-- SAC Inscripciones - Agregar columnas de pago y baja
-- Ejecutar en Supabase SQL Editor
-- ============================================================

-- Karting
ALTER TABLE inscripciones_karting
  ADD COLUMN IF NOT EXISTS pago_confirmado BOOLEAN DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS pago_monto NUMERIC(10,2),
  ADD COLUMN IF NOT EXISTS pago_fecha DATE,
  ADD COLUMN IF NOT EXISTS pago_medio TEXT, -- 'efectivo' | 'transferencia'
  ADD COLUMN IF NOT EXISTS baja BOOLEAN DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS baja_motivo TEXT;

-- Turismo
ALTER TABLE inscripciones_turismo
  ADD COLUMN IF NOT EXISTS pago_confirmado BOOLEAN DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS pago_monto NUMERIC(10,2),
  ADD COLUMN IF NOT EXISTS pago_fecha DATE,
  ADD COLUMN IF NOT EXISTS pago_medio TEXT,
  ADD COLUMN IF NOT EXISTS baja BOOLEAN DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS baja_motivo TEXT;

-- Regularidad
ALTER TABLE inscripciones_regularidad
  ADD COLUMN IF NOT EXISTS pago_confirmado BOOLEAN DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS pago_monto NUMERIC(10,2),
  ADD COLUMN IF NOT EXISTS pago_fecha DATE,
  ADD COLUMN IF NOT EXISTS pago_medio TEXT,
  ADD COLUMN IF NOT EXISTS baja BOOLEAN DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS baja_motivo TEXT;

-- Políticas para que el admin autenticado pueda actualizar
CREATE POLICY "update_auth_karting" ON inscripciones_karting
  FOR UPDATE TO authenticated USING (true);

CREATE POLICY "update_auth_turismo" ON inscripciones_turismo
  FOR UPDATE TO authenticated USING (true);

CREATE POLICY "update_auth_regularidad" ON inscripciones_regularidad
  FOR UPDATE TO authenticated USING (true);
