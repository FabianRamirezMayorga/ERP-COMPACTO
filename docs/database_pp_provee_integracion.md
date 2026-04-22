# Base de datos: tabla `t_pp_provee_integracion`

## Ubicación de creación

La tabla se crea en:

- `database/migrations/005_pp_provee_integracion.sql`

## Base de datos y esquema

- Base de datos objetivo: `erp_compacto`
- Esquema por defecto en PostgreSQL: `public` (si no se especifica otro)

## Diseño aplicado (administración y buenas prácticas)

- Nombre de tabla respetado según requerimiento: `t_pp_provee_integracion`
- Llave primaria compuesta: `(f_id_cia, f_id)`
- `f_id` autogenerado como `IDENTITY` y además `UNIQUE`
- Inmutabilidad de `f_id_cia` y `f_id` vía trigger `BEFORE UPDATE`
- Defaults para:
  - `f_ind_tipo` = `0`
  - `f_ind_clase` = `0`
- Validaciones (`CHECK`) para evitar:
  - valores negativos en indicadores
  - descripciones/XML vacíos
- Índice operativo: `(f_id_cia, f_ind_tipo, f_ind_clase)`

## Campos definidos

- `f_id_cia SMALLINT NOT NULL`
- `f_id BIGINT GENERATED ALWAYS AS IDENTITY`
- `f_descripcion VARCHAR(60) NOT NULL`
- `f_xml_estructura TEXT NOT NULL`
- `f_ind_tipo SMALLINT NOT NULL DEFAULT 0`
- `f_ind_clase SMALLINT NOT NULL DEFAULT 0`

## Orden sugerido de migraciones

1. `001_initial_schema.sql`
2. `003_configuracion_schema.sql`
3. `004_modulos.sql`
4. `005_pp_provee_integracion.sql`
