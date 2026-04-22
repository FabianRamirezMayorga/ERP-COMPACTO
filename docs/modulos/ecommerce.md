# Arquitectura Módulo eCommerce

## Flujo de Compra

```
Cliente visita tienda
    → Agrega productos al carrito
    → Aplica cupón (opcional)
    → Selecciona dirección de envío
    → Elige método de pago
    → Confirma pedido
    → Notificación por email
    → Actualización de inventario (Módulo Comercio)
    → Registro en ventas (Módulo POS)
```

## Endpoints API (planificados)

| Método | Endpoint | Descripción |
|---|---|---|
| GET | `/api/ecommerce/productos` | Listar productos publicados |
| GET | `/api/ecommerce/productos/{id}` | Detalle de producto |
| POST | `/api/ecommerce/carrito` | Crear/actualizar carrito |
| POST | `/api/ecommerce/pedidos` | Crear pedido |
| GET | `/api/ecommerce/pedidos/{id}` | Estado del pedido |
| POST | `/api/ecommerce/cupones/validar` | Validar cupón |
