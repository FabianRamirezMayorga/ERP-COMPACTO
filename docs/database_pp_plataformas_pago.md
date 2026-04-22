# Base de datos: tabla `t_pp_plataformas_pago`

## Propósito de negocio (IMPORTANTE)

`t_pp_plataformas_pago` controla y almacena las plataformas/pasarelas de pago integradas al ERP (ejemplos: Mercado Pago, RappiPay, Nequi y futuras integraciones).

Es una tabla transversal: todos los módulos que requieran iniciar cobros, validar medios de pago o consultar configuración de plataformas deben poder leer esta información.

## Ubicación de creación

- `database/migrations/006_pp_plataformas_pago.sql`

## Base de datos y esquema

- Base de datos objetivo: `erp_compacto`
- Esquema por defecto: `public` (si no se define otro)

## Reglas críticas de integridad

- Llave primaria compuesta: `(f_id_cia, f_id)`
- `f_id` autogenerado, único y no editable
- `f_id_cia` no editable
- Trigger `BEFORE UPDATE` para bloquear cambios de IDs
- No se permiten IDs repetidos (`UNIQUE`)

## Campos definidos

- `f_id_cia SMALLINT NOT NULL`
- `f_id BIGINT GENERATED ALWAYS AS IDENTITY`
- `f_descripcion VARCHAR(60) NOT NULL`
- `f_xml_estructura TEXT NOT NULL` (estructura/configuración del proveedor; puede incluir parámetros de conexión)
- `f_ind_tipo SMALLINT NOT NULL DEFAULT 0`

## Buenas prácticas aplicadas

- `CHECK` para evitar indicadores negativos y textos vacíos
- Índice de consulta por compañía y tipo: `(f_id_cia, f_ind_tipo)`

## Orden sugerido de migraciones

1. `001_initial_schema.sql`
2. `003_configuracion_schema.sql`
3. `004_modulos.sql`
4. `005_pp_provee_integracion.sql`
5. `006_pp_plataformas_pago.sql`
