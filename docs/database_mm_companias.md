# Base de datos: tabla `t_mm_companias`

## Propósito de negocio (CRÍTICO)

`t_mm_companias` es la tabla maestra donde se almacena la información de la compañía/empresa.
Estos datos son críticos para cumplimiento fiscal, identificación legal y configuración contable del ERP.

> Regla clave: el campo `f_id` de esta tabla representa el `f_id_cia` utilizado en las demás tablas del sistema.

## Ubicación de creación

- `database/migrations/007_mm_companias.sql`

## Base de datos y esquema

- Base de datos objetivo: `erp_compacto`
- Esquema por defecto: `public`

## Regla de identificación (obligatoria)

- `f_id` es único (PK + `UNIQUE`)
- `f_id` no se puede editar después de creado
- Se aplica trigger `BEFORE UPDATE` para bloquear cambios en `f_id`

## Buenas prácticas aplicadas

- Conversión de tipos SQL Server a PostgreSQL (`money` → `NUMERIC(19,4)`, `datetime` → `TIMESTAMP`)
- Defaults operativos migrados desde el script fuente
- `CHECK` para rangos y banderas fiscales clave
- Índice de soporte para `f_rowid_movto_entidad`

## Alcance transversal

Todos los módulos deben poder consultar esta tabla porque de aquí sale el identificador de compañía (`f_id_cia`) y parte de la parametrización fiscal/contable base.

## Orden sugerido de migraciones

1. `001_initial_schema.sql`
2. `003_configuracion_schema.sql`
3. `004_modulos.sql`
4. `005_pp_provee_integracion.sql`
5. `006_pp_plataformas_pago.sql`
6. `007_mm_companias.sql`
