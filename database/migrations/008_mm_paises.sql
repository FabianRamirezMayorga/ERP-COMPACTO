-- ==========================================================
-- ERP-COMPACTO - Tabla Maestra de Países
-- Fuente funcional: t_mm_paises
-- ==========================================================

\c erp_compacto;

CREATE TABLE IF NOT EXISTS t_mm_paises (
    f_id_cia SMALLINT NOT NULL,
    f_id BIGINT GENERATED ALWAYS AS IDENTITY,
    f_descripcion VARCHAR(40) NOT NULL,
    CONSTRAINT pk_t_mm_paises PRIMARY KEY (f_id_cia, f_id),
    CONSTRAINT uq_t_mm_paises_f_id UNIQUE (f_id),
    CONSTRAINT chk_t_mm_paises_descripcion_no_vacia CHECK (btrim(f_descripcion) <> '')
);

CREATE OR REPLACE FUNCTION fn_bloquear_edicion_ids_t_mm_paises()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.f_id_cia <> OLD.f_id_cia THEN
        RAISE EXCEPTION 'f_id_cia no se puede editar en t_mm_paises';
    END IF;

    IF NEW.f_id <> OLD.f_id THEN
        RAISE EXCEPTION 'f_id no se puede editar en t_mm_paises';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS tr_bloquear_edicion_ids_t_mm_paises ON t_mm_paises;

CREATE TRIGGER tr_bloquear_edicion_ids_t_mm_paises
BEFORE UPDATE ON t_mm_paises
FOR EACH ROW
EXECUTE FUNCTION fn_bloquear_edicion_ids_t_mm_paises();

CREATE INDEX IF NOT EXISTS ix_t_mm_paises_descripcion
    ON t_mm_paises (f_descripcion);

SELECT 'Tabla t_mm_paises creada exitosamente.' AS mensaje;
