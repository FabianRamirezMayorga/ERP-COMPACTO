-- =============================================
-- ERP-COMPACTO - Schema Configuración General
-- =============================================

\c erp_compacto;

-- Tipos de Documento
CREATE TABLE tipos_documento (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(10) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    aplica_persona_natural BOOLEAN DEFAULT TRUE,
    aplica_persona_juridica BOOLEAN DEFAULT FALSE,
    requiere_digito_verificacion BOOLEAN DEFAULT FALSE,
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Resoluciones DIAN
CREATE TABLE resoluciones_dian (
    id SERIAL PRIMARY KEY,
    numero_resolucion VARCHAR(50) NOT NULL UNIQUE,
    fecha_resolucion DATE NOT NULL,
    fecha_vigencia_inicio DATE NOT NULL,
    fecha_vigencia_fin DATE NOT NULL,
    prefijo VARCHAR(10),
    rango_inicio BIGINT NOT NULL,
    rango_fin BIGINT NOT NULL,
    consecutivo_actual BIGINT NOT NULL DEFAULT 0,
    tipo_documento VARCHAR(30) NOT NULL, -- 'FACTURA_VENTA', 'NOTA_CREDITO', 'NOTA_DEBITO'
    ambiente VARCHAR(20) DEFAULT 'produccion', -- 'produccion' o 'pruebas'
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    CONSTRAINT chk_rango CHECK (rango_fin >= rango_inicio),
    CONSTRAINT chk_consecutivo CHECK (consecutivo_actual <= rango_fin)
);

-- Datos de la Empresa
CREATE TABLE empresa (
    id SERIAL PRIMARY KEY,
    razon_social VARCHAR(200) NOT NULL,
    nombre_comercial VARCHAR(200),
    nit VARCHAR(20) NOT NULL UNIQUE,
    digito_verificacion CHAR(1),
    tipo_persona VARCHAR(20) DEFAULT 'juridica',
    regimen_fiscal VARCHAR(50),
    responsabilidades_fiscales JSONB,
    direccion TEXT,
    ciudad VARCHAR(100),
    departamento VARCHAR(100),
    pais VARCHAR(50) DEFAULT 'Colombia',
    telefono VARCHAR(20),
    email VARCHAR(150),
    sitio_web VARCHAR(200),
    logo_url TEXT,
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Impuestos
CREATE TABLE impuestos (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(10) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    porcentaje DECIMAL(5,2) NOT NULL,
    tipo VARCHAR(20) NOT NULL, -- 'IVA', 'INC', 'ICO', 'EXENTO'
    aplica_por_defecto BOOLEAN DEFAULT FALSE,
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Parámetros del sistema
CREATE TABLE parametros_sistema (
    id SERIAL PRIMARY KEY,
    clave VARCHAR(100) NOT NULL UNIQUE,
    valor TEXT NOT NULL,
    tipo_dato VARCHAR(20) DEFAULT 'string', -- 'string', 'number', 'boolean', 'json'
    descripcion TEXT,
    modulo VARCHAR(50),
    editable BOOLEAN DEFAULT TRUE,
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Departamentos y Ciudades Colombia
CREATE TABLE departamentos (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(5) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE ciudades (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(10) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    departamento_id INT REFERENCES departamentos(id)
);

-- Alertas de vencimiento resoluciones
CREATE OR REPLACE VIEW v_resoluciones_por_vencer AS
SELECT
    id,
    numero_resolucion,
    prefijo,
    fecha_vigencia_fin,
    rango_fin - consecutivo_actual AS consecutivos_disponibles,
    CASE
        WHEN fecha_vigencia_fin < CURRENT_DATE THEN 'VENCIDA'
        WHEN fecha_vigencia_fin <= CURRENT_DATE + INTERVAL '30 days' THEN 'POR VENCER'
        WHEN (rango_fin - consecutivo_actual) < 100 THEN 'CONSECUTIVOS BAJOS'
        ELSE 'VIGENTE'
    END AS estado_alerta
FROM resoluciones_dian
WHERE activo = TRUE;

-- Seeds: Tipos de documento Colombia
INSERT INTO tipos_documento (codigo, nombre, aplica_persona_natural, aplica_persona_juridica, requiere_digito_verificacion) VALUES
    ('CC',  'Cédula de Ciudadanía',     TRUE,  FALSE, FALSE),
    ('NIT', 'NIT',                       FALSE, TRUE,  TRUE),
    ('CE',  'Cédula de Extranjería',     TRUE,  FALSE, FALSE),
    ('PA',  'Pasaporte',                 TRUE,  FALSE, FALSE),
    ('RC',  'Registro Civil',            TRUE,  FALSE, FALSE),
    ('TI',  'Tarjeta de Identidad',      TRUE,  FALSE, FALSE),
    ('NUIP','NUIP',                       TRUE,  FALSE, FALSE),
    ('PEP', 'Permiso Especial de Permanencia', TRUE, FALSE, FALSE);

-- Seeds: Impuestos Colombia
INSERT INTO impuestos (codigo, nombre, porcentaje, tipo, aplica_por_defecto) VALUES
    ('IVA0',  'IVA 0%',          0.00,  'IVA',    FALSE),
    ('IVA5',  'IVA 5%',          5.00,  'IVA',    FALSE),
    ('IVA19', 'IVA 19%',        19.00,  'IVA',    TRUE),
    ('INC8',  'INC 8%',          8.00,  'INC',    FALSE),
    ('EXENTO','Exento de IVA',   0.00,  'EXENTO', FALSE);

-- Seeds: Parámetros base
INSERT INTO parametros_sistema (clave, valor, tipo_dato, descripcion, modulo) VALUES
    ('MONEDA_DEFAULT',        'COP',          'string',  'Moneda por defecto',                'GENERAL'),
    ('DECIMALES_PRECIO',      '2',            'number',  'Decimales en precios',              'GENERAL'),
    ('FACTURA_ELECTRONICA',   'false',        'boolean', 'Habilitar facturación electrónica', 'DIAN'),
    ('DIAN_AMBIENTE',         'pruebas',      'string',  'Ambiente DIAN: pruebas/produccion', 'DIAN'),
    ('ALERTAS_VENCIMIENTO_DIAS','30',         'number',  'Días de anticipación para alertas', 'DIAN'),
    ('LOGO_EMPRESA',          '',             'string',  'URL del logo de la empresa',        'EMPRESA');

SELECT 'Módulo Configuración General creado exitosamente.' AS mensaje;
