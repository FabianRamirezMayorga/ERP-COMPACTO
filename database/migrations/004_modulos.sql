-- =============================================
-- ERP-COMPACTO - Tabla de Módulos
-- =============================================

\c erp_compacto;

CREATE TABLE IF NOT EXISTS t_modulos (
    f_id_cia SMALLINT NOT NULL,
    f_id BIGINT GENERATED ALWAYS AS IDENTITY,
    f_descripcion VARCHAR(40) NOT NULL,
    f_posicion SMALLINT NOT NULL,
    f_orden SMALLINT NOT NULL,
    CONSTRAINT pk_t_modulos PRIMARY KEY (f_id_cia, f_id),
    CONSTRAINT uq_t_modulos_id UNIQUE (f_id)
);

CREATE OR REPLACE FUNCTION fn_bloquear_edicion_ids_t_modulos()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.f_id_cia <> OLD.f_id_cia THEN
        RAISE EXCEPTION 'f_id_cia no se puede editar en t_modulos';
    END IF;

    IF NEW.f_id <> OLD.f_id THEN
        RAISE EXCEPTION 'f_id no se puede editar en t_modulos';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS tr_bloquear_edicion_ids_t_modulos ON t_modulos;

CREATE TRIGGER tr_bloquear_edicion_ids_t_modulos
BEFORE UPDATE ON t_modulos
FOR EACH ROW
EXECUTE FUNCTION fn_bloquear_edicion_ids_t_modulos();

SELECT 'Tabla t_modulos creada exitosamente.' AS mensaje;
