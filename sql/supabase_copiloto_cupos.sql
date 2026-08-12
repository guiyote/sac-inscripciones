-- ============================================================
-- SAC Inscripciones - Cupos por día para Copiloto (sábado / domingo)
-- Ejecutar en Supabase SQL Editor
-- Prerequisito: supabase_copiloto.sql
-- ============================================================

-- Día del evento en que se anota el copiloto
ALTER TABLE public.inscripciones_copiloto
  ADD COLUMN IF NOT EXISTS dia TEXT CHECK (dia IN ('sabado', 'domingo'));

-- Cupos máximos por día, editables desde inscripciones-config.html
INSERT INTO configuracion (clave, valor) VALUES
  ('cupos_copiloto_sabado', '4'),
  ('cupos_copiloto_domingo', '6')
ON CONFLICT (clave) DO NOTHING;

-- Bloquea la inscripción (o el alta) si el cupo del día ya está lleno.
-- Es la validación de respaldo del lado del servidor; el formulario
-- también valida antes de insertar para dar feedback inmediato al usuario.
CREATE OR REPLACE FUNCTION public.check_cupo_copiloto()
RETURNS TRIGGER AS $$
DECLARE
  cupo_max INTEGER;
  ocupados INTEGER;
BEGIN
  IF NEW.dia IS NULL OR NEW.baja THEN
    RETURN NEW;
  END IF;

  -- Solo recalcular cupo si cambia el día, la fecha o se reactiva (alta);
  -- así no bloquea ediciones de pago sobre una inscripción ya válida.
  IF TG_OP = 'UPDATE'
     AND NEW.dia IS NOT DISTINCT FROM OLD.dia
     AND NEW.fecha_carrera IS NOT DISTINCT FROM OLD.fecha_carrera
     AND NEW.baja IS NOT DISTINCT FROM OLD.baja THEN
    RETURN NEW;
  END IF;

  SELECT valor::INTEGER INTO cupo_max
    FROM configuracion WHERE clave = 'cupos_copiloto_' || NEW.dia;

  SELECT COUNT(*) INTO ocupados
    FROM public.inscripciones_copiloto
    WHERE fecha_carrera = NEW.fecha_carrera
      AND dia = NEW.dia
      AND baja = FALSE
      AND id IS DISTINCT FROM NEW.id;

  IF ocupados >= COALESCE(cupo_max, 0) THEN
    RAISE EXCEPTION 'Cupo lleno para el día %', NEW.dia;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS trg_check_cupo_copiloto ON public.inscripciones_copiloto;
CREATE TRIGGER trg_check_cupo_copiloto
  BEFORE INSERT OR UPDATE ON public.inscripciones_copiloto
  FOR EACH ROW EXECUTE FUNCTION public.check_cupo_copiloto();
