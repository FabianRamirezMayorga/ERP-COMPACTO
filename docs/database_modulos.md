# Base de datos: tabla `t_modulos`

## Ubicación de creación

La tabla se crea en la migración:

- `database/migrations/004_modulos.sql`

## Nombre de la base de datos

El nombre de la base de datos es:

- `erp_compacto`

Esto se define en el script inicial con `CREATE DATABASE erp_compacto;` y se usa luego con `\c erp_compacto;`.

## Esquema

En PostgreSQL, al no declarar un esquema explícito en `CREATE TABLE t_modulos (...)`, la tabla queda en el esquema por defecto (`public`) del `search_path` activo.

## Definición funcional aplicada

- Tabla: `t_modulos`
- Llave primaria compuesta: `(f_id_cia, f_id)`
- `f_id` único global (`UNIQUE`)
- Protección de edición de `f_id_cia` y `f_id` mediante trigger `BEFORE UPDATE`

## Orden de ejecución de migraciones

1. `database/migrations/001_initial_schema.sql`
2. `database/migrations/003_configuracion_schema.sql`
3. `database/migrations/004_modulos.sql`

