# Módulo Configuración General

Módulo central de parametrización del ERP-COMPACTO. Administra todos los maestros del sistema que son requeridos por los demás módulos.

## Funcionalidades

### 📄 Tipos de Documento
- Cédula de Ciudadanía (CC)
- NIT
- Cédula de Extranjería (CE)
- Pasaporte (PA)
- Registro Civil (RC)
- Tarjeta de Identidad (TI)
- NUIP

### 🏛️ Resoluciones DIAN
- Registro de resoluciones de facturación electrónica
- Control de rangos de numeración autorizados
- Fechas de vigencia y vencimiento
- Prefijos de factura (ej: FV, FE, NC)
- Alertas de vencimiento próximo

### ⚙️ Parámetros Generales
- Datos de la empresa
- Configuración de impuestos (IVA, INC)
- Moneda y formato numérico
- Plantillas de correo
- Conexión con facturación electrónica DIAN

## Integración con otros módulos

| Módulo | Uso |
|---|---|
| POS | Resolución activa para numeración de facturas |
| Comercio | Tipos de documento para proveedores |
| Seguridad | Tipos de documento para usuarios |
| eCommerce | Datos empresa en recibos online |
