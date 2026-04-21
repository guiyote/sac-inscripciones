# SAC Inscripciones

Sitio de pre-inscripciones para el Campeonato Regional 2026 del Salto Automóvil Club.

## Estructura

```
sac-inscripciones/
├── index.html          ← Landing con los 3 formularios
├── karting.html        ← Pre-inscripción Karting (Copa Nuevo Uruguay)
├── turismo.html        ← Inscripción Turismo TNS/TMZ
├── regularidad.html    ← Inscripción Regularidad
└── supabase_setup.sql  ← SQL para crear las tablas (solo se ejecuta una vez)
```

## Setup inicial

### 1. Crear las tablas en Supabase

1. Entrá a tu proyecto en [supabase.com](https://supabase.com)
2. Menú izquierdo → **SQL Editor** → **New query**
3. Pegá el contenido de `supabase_setup.sql` y ejecutá (botón **Run**)
4. Verificá que las 3 tablas aparezcan en **Table Editor**

### 2. Subir a GitHub Pages

```bash
# Cloná o creá el repo
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/TU_USUARIO/sac-inscripciones.git
git push -u origin main
```

Luego en GitHub:
- **Settings** → **Pages**
- Source: **Deploy from a branch**
- Branch: `main` / `/ (root)`
- Guardá → en unos minutos el sitio estará en `https://TU_USUARIO.github.io/sac-inscripciones`

## Ver inscripciones

Desde el dashboard de Supabase → **Table Editor** → seleccionás la tabla que querés ver.

Para exportar a CSV: botón **Export** arriba a la derecha de cualquier tabla.

## Actualizar fechas

Las fechas del campeonato están hardcodeadas en los 3 formularios dentro del `<select id="fecha_carrera">`. Para modificarlas, editá ese bloque en cada archivo HTML.

## Credenciales configuradas

- Project URL: `https://qpveivsqkudlqjbxcxzh.supabase.co`
- Publishable key: ya incluida en los archivos HTML
