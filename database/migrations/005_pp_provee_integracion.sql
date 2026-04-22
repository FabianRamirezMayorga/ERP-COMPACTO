-- ==========================================================
-- ERP-COMPACTO - Tabla Proveedor de Integración
-- Fuente funcional: t_pp_provee_integracion
-- ==========================================================

\c erp_compacto;

CREATE TABLE IF NOT EXISTS t_pp_provee_integracion (
    f_id_cia SMALLINT NOT NULL,
    f_id BIGINT GENERATED ALWAYS AS IDENTITY,
    f_descripcion VARCHAR(60) NOT NULL,
    f_xml_estructura TEXT NOT NULL,
    f_ind_tipo SMALLINT NOT NULL DEFAULT 0,
    f_ind_clase SMALLINT NOT NULL DEFAULT 0,
    CONSTRAINT pk_t_pp_provee_integracion PRIMARY KEY (f_id_cia, f_id),
    CONSTRAINT uq_t_pp_provee_integracion_f_id UNIQUE (f_id),
    CONSTRAINT chk_t_pp_provee_integracion_f_ind_tipo_nonneg CHECK (f_ind_tipo >= 0),
    CONSTRAINT chk_t_pp_provee_integracion_f_ind_clase_nonneg CHECK (f_ind_clase >= 0),
    CONSTRAINT chk_t_pp_provee_integracion_f_descripcion_no_vacia CHECK (btrim(f_descripcion) <> ''),
    CONSTRAINT chk_t_pp_provee_integracion_f_xml_estructura_no_vacia CHECK (btrim(f_xml_estructura) <> '')
);

CREATE OR REPLACE FUNCTION fn_bloquear_edicion_ids_t_pp_provee_integracion()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.f_id_cia <> OLD.f_id_cia THEN
        RAISE EXCEPTION 'f_id_cia no se puede editar en t_pp_provee_integracion';
    END IF;

    IF NEW.f_id <> OLD.f_id THEN
        RAISE EXCEPTION 'f_id no se puede editar en t_pp_provee_integracion';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS tr_bloquear_edicion_ids_t_pp_provee_integracion ON t_pp_provee_integracion;

CREATE TRIGGER tr_bloquear_edicion_ids_t_pp_provee_integracion
BEFORE UPDATE ON t_pp_provee_integracion
FOR EACH ROW
EXECUTE FUNCTION fn_bloquear_edicion_ids_t_pp_provee_integracion();

CREATE INDEX IF NOT EXISTS ix_t_pp_provee_integracion_cia_tipo_clase
    ON t_pp_provee_integracion (f_id_cia, f_ind_tipo, f_ind_clase);

SELECT 'Tabla t_pp_provee_integracion creada exitosamente.' AS mensaje;
