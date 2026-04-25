# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development

No build step. All files are static HTML/CSS/JS served directly.

**Run locally:**
```bash
python3 -m http.server 8080
# then open http://localhost:8080
```

All forms connect to the real Supabase project — there is no local/mock database.

**Deploy:** Push to `main` → GitHub Pages auto-deploys to `https://guiyote.github.io/sac-inscripciones`.

## Architecture

Pure static frontend — no framework, no bundler, no npm. Each page is a self-contained HTML file with inline `<style>` and `<script>` tags. There is no shared JS module; Supabase client code and business logic are duplicated across files.

**Supabase integration pattern** (same in every file):
```js
const SUPABASE_URL = 'https://qpveivsqkudlqjbxcxzh.supabase.co';
const SUPABASE_KEY = '<publishable-anon-key>';
const supabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_KEY);
```
The Supabase JS client is loaded from CDN via `<script>` tag.

**Auth pattern** (admin.html and stock.html): Pages show a login screen by default. On `supabase.auth.signInWithPassword()` success, the `#loginScreen` div is hidden and `#adminPanel` / `#stockPanel` is shown. Session is shared between admin.html and stock.html via Supabase's built-in session persistence (localStorage).

**Role system**: `user_roles` table maps `user_id → role ('admin' | 'viewer')`. The `get_my_role()` SQL function (SECURITY DEFINER) returns the role and is referenced in RLS policies. Viewers can read but cannot write to stock or update inscriptions. Users without a row in `user_roles` default to `'admin'` (see the COALESCE in the function).

## Database schema (Supabase / PostgreSQL)

Inscription tables (public INSERT via anon key, SELECT only for authenticated):
- `inscripciones_karting` — fecha_carrera, nombre, cedula, celular, departamento, fecha_nacimiento, cilindrada, numero_kart, pagado, monto_pago, fecha_pago, medio_pago, baja, motivo_baja
- `inscripciones_turismo` — same base columns + categoria (TNS/TMZ), numero_auto, marca_modelo, nombre_concurrente, nombre_equipo, cantidad_gomas, cantidad_pastillas, cantidad_discos
- `inscripciones_regularidad` — nombre_piloto, fecha_nacimiento_piloto, nombre_navegante, fecha_nacimiento_navegante, marca, modelo, anio, numero_auto

Stock tables (authenticated only):
- `stock_articulos` — fixed 4 items (Pastillas $120, Cubiertas $60, Discos $70, Difusores TNS $120), `stock_actual` is a legacy aggregate; real stock is in `stock_por_ubicacion`
- `stock_ubicaciones` — 3 warehouses: Todo Truck, André Lafon, El Revoltijo
- `stock_por_ubicacion` — `(articulo_id, ubicacion_id)` unique pair with `stock_actual`; this is the source of truth for current stock
- `stock_movimientos` — every entry/exit event; columns: tipo ('entrada'|'salida'), cantidad, piloto, pago_confirmado, pago_monto, pago_medio, pago_fecha, proveedor, notas, ubicacion_id, fecha_carrera

Auth:
- `user_roles` — `(user_id PK, role CHECK ('admin'|'viewer'))`

## SQL migrations

The `sql/` directory contains ordered migration scripts. When adding schema changes, create a new numbered file following the existing naming pattern and document which files must be run before it. The README lists the correct execution order for initial setup.

## Design system

Dark theme with CSS custom properties defined in `:root` on each page:
- `--rojo: #CC0000` — primary accent (borders, buttons, badges)
- `--gris: #1a1a1a` — page background
- `--gris-medio: #2d2d2d` — card/panel background
- Fonts: `Barlow Condensed` (headings, labels, uppercase UI) and `Barlow` (body), loaded from Google Fonts

## Championship dates 2026

The date selector in all inscription forms is pre-populated with these 7 race weekends:
25-26 Apr · 13-14 Jun · 11-12 Jul · 15-16 Aug · 12-13 Sep · 17-18 Oct · 28-29 Nov

The current month's date is pre-selected dynamically in JS.

## Duplicate prevention

Each inscription form checks for duplicates before INSERT by querying for matching `nombre` + `numero_kart`/`numero_auto` + `fecha_carrera` (case-insensitive via `.ilike()`).
