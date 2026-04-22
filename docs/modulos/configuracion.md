# Arquitectura Módulo Configuración General

## Responsabilidad

Este módulo es el **núcleo de parametrización** del ERP. Todos los demás módulos dependen de él para obtener:
- Tipos de documento válidos
- Resolución DIAN activa para numeración
- Datos de la empresa para encabezados de documentos
- Impuestos aplicables

## Flujo Resolución DIAN

```
Registrar Resolución DIAN
    → Definir prefijo (ej: FV)
    → Definir rango autorizado (ej: 1 - 5000)
    → Activar resolución
    → POS/eCommerce consumen consecutivo automáticamente
    → Alerta cuando quedan < 100 consecutivos
    → Alerta 30 días antes del vencimiento
```

## Endpoints API (planificados)

| Método | Endpoint | Descripción |
|---|---|---|
| GET | `/api/config/tipos-documento` | Listar tipos de documento |
| GET | `/api/config/resoluciones-dian` | Listar resoluciones |
| GET | `/api/config/resoluciones-dian/activa` | Obtener resolución activa |
| POST | `/api/config/resoluciones-dian` | Registrar nueva resolución |
| GET | `/api/config/empresa` | Obtener datos empresa |
| PUT | `/api/config/empresa` | Actualizar datos empresa |
| GET | `/api/config/impuestos` | Listar impuestos |
| GET | `/api/config/parametros/{clave}` | Obtener parámetro |
