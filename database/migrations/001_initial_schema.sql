-- =============================================
-- ERP-COMPACTO - Schema Inicial
-- =============================================

CREATE DATABASE erp_compacto;

\c erp_compacto;

-- MÓDULO SEGURIDAD
CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT,
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    rol_id INT REFERENCES roles(id),
    activo BOOLEAN DEFAULT TRUE,
    ultimo_acceso TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE permisos (
    id SERIAL PRIMARY KEY,
    modulo VARCHAR(50) NOT NULL,
    accion VARCHAR(50) NOT NULL,
    descripcion TEXT
);

CREATE TABLE roles_permisos (
    rol_id INT REFERENCES roles(id),
    permiso_id INT REFERENCES permisos(id),
    PRIMARY KEY (rol_id, permiso_id)
);

-- MÓDULO COMERCIO
CREATE TABLE categorias (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL UNIQUE,
    nombre VARCHAR(200) NOT NULL,
    descripcion TEXT,
    precio_compra DECIMAL(12,2) NOT NULL DEFAULT 0,
    precio_venta DECIMAL(12,2) NOT NULL DEFAULT 0,
    stock INT NOT NULL DEFAULT 0,
    stock_minimo INT DEFAULT 5,
    categoria_id INT REFERENCES categorias(id),
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE proveedores (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    nit VARCHAR(50) UNIQUE,
    telefono VARCHAR(20),
    email VARCHAR(150),
    direccion TEXT,
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- MÓDULO POS
CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    identificacion VARCHAR(50) UNIQUE,
    telefono VARCHAR(20),
    email VARCHAR(150),
    direccion TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE ventas (
    id SERIAL PRIMARY KEY,
    numero_factura VARCHAR(50) NOT NULL UNIQUE,
    cliente_id INT REFERENCES clientes(id),
    usuario_id INT REFERENCES usuarios(id),
    subtotal DECIMAL(12,2) NOT NULL DEFAULT 0,
    descuento DECIMAL(12,2) DEFAULT 0,
    impuesto DECIMAL(12,2) DEFAULT 0,
    total DECIMAL(12,2) NOT NULL DEFAULT 0,
    estado VARCHAR(20) DEFAULT 'completada',
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE detalle_ventas (
    id SERIAL PRIMARY KEY,
    venta_id INT REFERENCES ventas(id) ON DELETE CASCADE,
    producto_id INT REFERENCES productos(id),
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(12,2) NOT NULL,
    descuento DECIMAL(12,2) DEFAULT 0,
    subtotal DECIMAL(12,2) NOT NULL
);

-- Seeds iniciales
INSERT INTO roles (nombre, descripcion) VALUES
    ('Administrador', 'Acceso total al sistema'),
    ('Cajero', 'Acceso al módulo POS'),
    ('Vendedor', 'Acceso a comercio y POS');

INSERT INTO categorias (nombre) VALUES
    ('General'),
    ('Electrónica'),
    ('Alimentos'),
    ('Servicios');

SELECT 'ERP-COMPACTO schema creado exitosamente.' AS mensaje;
