# SAC Inscripciones

Sitio de pre-inscripciones y gestión del Campeonato Regional 2026 del Salto Automóvil Club.

## Estructura de archivos

```
sac-inscripciones/
├── index.html                    ← Landing con las 3 categorías
├── karting.html                  ← Pre-inscripción Karting (Copa Nuevo Uruguay)
├── turismo.html                  ← Inscripción Turismo TNS/TMZ
├── regularidad.html              ← Inscripción Regularidad
├── admin.html                    ← Panel de administración (requiere login)
├── stock.html                    ← Gestión de stock de repuestos (requiere login)
├── logo.jpeg                     ← Logo SAC
└── sql/
    ├── supabase_setup.sql            ← Tablas base + RLS inicial
    ├── supabase_admin_policies.sql   ← Políticas de lectura para admin
    ├── supabase_pago_baja.sql        ← Columnas de pago y baja
    ├── supabase_cedula_celular.sql   ← Columnas cédula y celular
    ├── supabase_fix_rls.sql          ← Corrección políticas INSERT
    ├── supabase_stock.sql            ← Tablas de stock de repuestos
    └── supabase_limpiar_datos.sql    ← Limpieza de datos de prueba
```

## Stack

- **Frontend**: HTML/CSS/JS estático
- **Base de datos**: Supabase (PostgreSQL)
- **Hosting**: GitHub Pages
- **Autenticación admin**: Supabase Auth

## Setup inicial

### 1. Supabase — ejecutar SQL en orden

Ir a **SQL Editor** en el dashboard de Supabase y ejecutar los archivos en este orden:

1. `supabase_setup.sql` — crea las 3 tablas de inscripciones y políticas RLS
2. `supabase_admin_policies.sql` — permisos de lectura para el admin autenticado
3. `supabase_pago_baja.sql` — columnas de pago y baja en las 3 tablas
4. `supabase_cedula_celular.sql` — columnas cédula y celular
5. `supabase_fix_rls.sql` — corrección de políticas INSERT para la publishable key
6. `supabase_stock.sql` — tablas de stock + carga inicial de los 4 artículos

### 2. Usuario admin

En Supabase → **Authentication → Users → Add user → Create new user**. Ese mismo usuario sirve para el admin y el stock.

### 3. GitHub Pages

```bash
git init
git add .
git commit -m "SAC inscripciones v1"
git branch -M main
git remote add origin https://github.com/guiyote/sac-inscripciones.git
git push -u origin main
```

En el repo → **Settings → Pages → Deploy from branch → main / root → Save**.

El sitio queda en: `https://guiyote.github.io/sac-inscripciones`

## Credenciales Supabase

- **Project URL**: `https://qpveivsqkudlqjbxcxzh.supabase.co`
- **Publishable key**: incluida en todos los archivos HTML

## Formularios de inscripción

### Campos comunes a los 3 formularios
- Fecha de carrera (selector con las 7 fechas del campeonato, preseleccionada según mes actual)
- Nombre y apellido (obligatorio)
- Cédula de identidad (obligatorio)
- Celular (opcional)

### Karting
- Departamento (combo con los 19 departamentos de Uruguay)
- Fecha de nacimiento
- Cilindrada motor (radio button — una sola opción): Shifter 200cc standard / Shifter 125cc / Libre
- Número de kart

### Turismo TNS/TMZ
- Fecha de nacimiento
- Categoría: TNS (Turismo N SAC) / TMZ (Turismo Multimarca SAC)
- Número de auto
- Marca y modelo
- Nombre del concurrente
- Nombre del equipo
- Cantidad de gomas, pastillas de freno, discos de freno

### Regularidad
- Piloto: nombre, fecha de nacimiento
- Navegante: nombre, fecha de nacimiento
- Vehículo: marca, modelo, año, número de auto (opcional)

### Validaciones
- No se permiten inscripciones duplicadas: mismo nombre + número de kart/auto para la misma fecha y categoría (insensible a mayúsculas)
- Solo se muestra la fecha del mes corriente habilitada (JS dinámico)

## Panel de administración — admin.html

Acceso: `https://guiyote.github.io/sac-inscripciones/admin.html`

Login con usuario Supabase Auth. La sesión se comparte con stock.html.

### Funcionalidades
- Ver inscripciones de las 3 categorías
- Filtrar por fecha de carrera, categoría, estado de pago y bajas
- Registrar pago por piloto: monto (UYU), fecha, medio (efectivo / transferencia)
- Registrar baja con motivo
- Dar de alta a un piloto dado de baja
- Resumen con totales por categoría y recaudado en UYU
- Tabla de inscripciones por fecha con desglose TNS/TMZ, pagados y recaudado
- Link directo al módulo de stock

## Módulo de stock — stock.html

Acceso: desde el link "Stock" en el header del admin.

Solo para repuestos TNS/TMZ. Artículos fijos con precio en dólares:

| Artículo | Precio |
|---|---|
| Pastillas | U$S 120 |
| Cubiertas | U$S 60 |
| Discos de freno | U$S 70 |
| Difusores (TNS) | U$S 120 |

### Funcionalidades
- Cards de stock actual por artículo (verde / amarillo si queda poco / rojo si no hay)
- Entrada de mercadería: cantidad, proveedor opcional, notas
- Salida: cantidad, piloto, pago (con monto automático según precio × cantidad, medio, fecha)
- Botón de pago en historial para salidas pendientes de cobro
- Historial de movimientos con filtros por artículo, tipo y estado de pago

## Fechas del campeonato 2026

| # | Fechas |
|---|---|
| 1º | 25 / 26 Abril |
| 2º | 13 / 14 Junio |
| 3º | 11 / 12 Julio |
| 4º | 15 / 16 Agosto |
| 5º | 12 / 13 Setiembre |
| 6º | 17 / 18 Octubre |
| 7º | 28 / 29 Noviembre |

## Desarrollo local

**Opción 1 — VS Code + Live Server:**
Instalar extensión Live Server → click derecho en `index.html` → Open with Live Server → `http://127.0.0.1:5500`

**Opción 2 — Python:**
```bash
cd sac-inscripciones
python3 -m http.server 8080
```
Abrir `http://localhost:8080`

Los formularios conectan a Supabase real en ambos casos — no hay entorno local separado.

## Ver y exportar inscripciones

Supabase → **Table Editor** → seleccionar tabla → botón **Export** para descargar CSV.
