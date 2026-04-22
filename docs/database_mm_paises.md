# Base de datos: tabla `t_mm_paises`

## Propósito de negocio

`t_mm_paises` almacena el catálogo de países del ERP.
Es una tabla maestra de uso transversal para validaciones, direcciones, terceros, documentos fiscales y parametrizaciones por compañía.

## Regla clave solicitada

- `f_id_cia` y `f_id` se manejan como campos numéricos
- `f_id` debe ser único, no repetible y no editable
- `f_id_cia` no editable

## Implementación en PostgreSQL

- `f_id_cia SMALLINT NOT NULL`
- `f_id BIGINT GENERATED ALWAYS AS IDENTITY`
- `f_descripcion VARCHAR(40) NOT NULL`
- PK compuesta: `(f_id_cia, f_id)`
- `UNIQUE (f_id)`
- Trigger `BEFORE UPDATE` para bloquear edición de IDs

## Ubicación de creación

- `database/migrations/008_mm_paises.sql`

## Base de datos y esquema

- Base de datos objetivo: `erp_compacto`
- Esquema por defecto: `public`

## Buenas prácticas

- `CHECK` para impedir descripción vacía
- Índice de consulta por descripción

## Orden sugerido de migraciones

1. `001_initial_schema.sql`
2. `003_configuracion_schema.sql`
3. `004_modulos.sql`
4. `005_pp_provee_integracion.sql`
5. `006_pp_plataformas_pago.sql`
6. `007_mm_companias.sql`
7. `008_mm_paises.sql`
