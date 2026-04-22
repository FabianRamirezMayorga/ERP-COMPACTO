-- =============================================
-- ERP-COMPACTO - Schema eCommerce
-- =============================================

\c erp_compacto;

-- Tienda virtual
CREATE TABLE tiendas (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    dominio VARCHAR(200) UNIQUE,
    descripcion TEXT,
    logo_url TEXT,
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Catálogo online (extiende productos del módulo Comercio)
CREATE TABLE productos_ecommerce (
    id SERIAL PRIMARY KEY,
    producto_id INT REFERENCES productos(id) ON DELETE CASCADE,
    tienda_id INT REFERENCES tiendas(id),
    titulo_seo VARCHAR(200),
    descripcion_larga TEXT,
    imagen_principal TEXT,
    imagenes_adicionales JSONB,
    publicado BOOLEAN DEFAULT FALSE,
    destacado BOOLEAN DEFAULT FALSE,
    orden_display INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Carrito de compras
CREATE TABLE carritos (
    id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES clientes(id),
    session_token VARCHAR(200),
    estado VARCHAR(20) DEFAULT 'activo',
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE carrito_items (
    id SERIAL PRIMARY KEY,
    carrito_id INT REFERENCES carritos(id) ON DELETE CASCADE,
    producto_id INT REFERENCES productos(id),
    cantidad INT NOT NULL DEFAULT 1,
    precio_unitario DECIMAL(12,2) NOT NULL,
    added_at TIMESTAMP DEFAULT NOW()
);

-- Pedidos online
CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    numero_pedido VARCHAR(50) NOT NULL UNIQUE,
    cliente_id INT REFERENCES clientes(id),
    tienda_id INT REFERENCES tiendas(id),
    subtotal DECIMAL(12,2) NOT NULL DEFAULT 0,
    descuento DECIMAL(12,2) DEFAULT 0,
    costo_envio DECIMAL(12,2) DEFAULT 0,
    impuesto DECIMAL(12,2) DEFAULT 0,
    total DECIMAL(12,2) NOT NULL DEFAULT 0,
    estado VARCHAR(30) DEFAULT 'pendiente',
    metodo_pago VARCHAR(50),
    direccion_envio JSONB,
    notas TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE detalle_pedidos (
    id SERIAL PRIMARY KEY,
    pedido_id INT REFERENCES pedidos(id) ON DELETE CASCADE,
    producto_id INT REFERENCES productos(id),
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(12,2) NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL
);

-- Cupones de descuento
CREATE TABLE cupones (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL UNIQUE,
    tipo VARCHAR(20) NOT NULL, -- 'porcentaje' o 'valor_fijo'
    valor DECIMAL(12,2) NOT NULL,
    minimo_compra DECIMAL(12,2) DEFAULT 0,
    usos_maximos INT DEFAULT 1,
    usos_actuales INT DEFAULT 0,
    fecha_inicio DATE,
    fecha_fin DATE,
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Reseñas
CREATE TABLE resenas (
    id SERIAL PRIMARY KEY,
    producto_id INT REFERENCES productos(id),
    cliente_id INT REFERENCES clientes(id),
    calificacion INT CHECK (calificacion BETWEEN 1 AND 5),
    comentario TEXT,
    aprobado BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW()
);

SELECT 'Módulo eCommerce creado exitosamente.' AS mensaje;
