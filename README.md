# ERP-COMPACTO

![.NET 9](https://img.shields.io/badge/.NET-9.0-purple) ![Angular 18](https://img.shields.io/badge/Angular-18-red) ![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-blue) ![License](https://img.shields.io/badge/license-MIT-green)

## Introducción

**ERP-COMPACTO** es un sistema de planificación de recursos empresariales (ERP) modular, diseñado para PyMEs y empresas en crecimiento. Construido sobre una arquitectura moderna de microservicios con **.NET 9**, **Angular 18** y **PostgreSQL**, ofrece módulos de POS, Comercio y Seguridad.

## Stack Tecnológico

| Capa | Tecnología | Versión |
|---|---|---|
| Backend | .NET / ASP.NET Core | 9.0 |
| Frontend | Angular | 18 |
| Base de Datos | PostgreSQL | 16 |
| Contenedores | Docker / Docker Compose | Latest |
| ORM | Entity Framework Core | 9.0 |
| Autenticación | JWT + ASP.NET Identity | — |

## Estructura del Proyecto

```
ERP-COMPACTO/
├── src/
│   ├── modules/
│   │   ├── pos/                  # Módulo Punto de Venta
│   │   ├── commerce/             # Módulo Comercio
│   │   └── security/             # Módulo Seguridad
│   ├── shared/                   # Código compartido
│   └── frontend/                 # Angular 18 App
├── infrastructure/
│   ├── docker-compose.yml
│   └── nginx/
├── database/
│   ├── migrations/
│   └── seeds/
├── docs/
├── tests/
├── scripts/
├── .gitignore
└── README.md
```

## Documentación técnica

- Tabla de módulos en base de datos: `docs/database_modulos.md`
- Tabla de proveedor de integración: `docs/database_pp_provee_integracion.md`
  - Uso transversal: repositorio de configuración/cadenas de conexión para APIs de integración consumidas por todos los módulos.
- Tabla de plataformas de pago: `docs/database_pp_plataformas_pago.md`
  - Uso transversal: catálogo y configuración de pasarelas/plataformas (Mercado Pago, RappiPay, Nequi, etc.) para todos los módulos.

## Módulos

### 🛒 Módulo POS (Punto de Venta)
Gestión de ventas en mostrador, caja, recibos y cierre de caja diario.

### 🏪 Módulo Comercio
Administración de inventario, proveedores, compras y catálogo de productos.

### 🔐 Módulo Seguridad
Control de usuarios, roles, permisos y auditoría de accesos.

## Prerrequisitos

- [.NET 9 SDK](https://dotnet.microsoft.com/download/dotnet/9.0)
- [Node.js 20+](https://nodejs.org/) y Angular CLI 18
- [PostgreSQL 16](https://www.postgresql.org/download/) o [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Git](https://git-scm.com/)

## Ejecución Local

### 1. Clonar el repositorio
```bash
git clone https://github.com/FabianRamirezMayorga/ERP-COMPACTO.git
cd ERP-COMPACTO
```

### 2. Levantar la base de datos con Docker
```bash
docker-compose -f infrastructure/docker-compose.yml up -d
```

### 3. Configurar variables de entorno
```bash
cp .env.example .env
# Editar .env con tus credenciales locales
```

### 4. Ejecutar migraciones
```bash
cd database
psql -U postgres -f migrations/001_initial_schema.sql
psql -U postgres -f migrations/003_configuracion_schema.sql
psql -U postgres -f migrations/004_modulos.sql
psql -U postgres -f migrations/005_pp_provee_integracion.sql
psql -U postgres -f migrations/006_pp_plataformas_pago.sql
```

### 5. Iniciar el backend
```bash
cd src/modules/security
dotnet run
```

### 6. Iniciar el frontend
```bash
cd src/frontend
npm install
ng serve
```

Abre tu navegador en `http://localhost:4200`

## Estrategia de Ramas (Gitflow)

```
main          → Producción estable
develop       → Integración continua
feature/*     → Nuevas funcionalidades
release/*     → Preparación de versiones
hotfix/*      → Correcciones urgentes en producción
```

```bash
# Inicializar Gitflow
git checkout -b develop
git push origin develop

# Nueva funcionalidad
git checkout -b feature/modulo-pos develop
```

## Convención de Commits

Este proyecto sigue [Conventional Commits](https://www.conventionalcommits.org/):

| Tipo | Uso |
|---|---|
| `feat:` | Nueva funcionalidad |
| `fix:` | Corrección de bug |
| `docs:` | Cambios en documentación |
| `refactor:` | Refactorización sin cambio funcional |
| `test:` | Agregar o modificar tests |
| `chore:` | Tareas de mantenimiento |
| `ci:` | Cambios en CI/CD |

**Ejemplo:**
```bash
git commit -m "feat(pos): agregar módulo de cierre de caja diario"
git commit -m "fix(security): corregir validación de tokens JWT"
```

## Licencia

MIT © 2026 FabianRamirezMayorga
