-- ==========================================================
-- ERP-COMPACTO - Tabla Maestra de Compañías
-- Fuente funcional: t_mm_companias
-- ==========================================================

\c erp_compacto;

CREATE TABLE IF NOT EXISTS t_mm_companias (
    f_id SMALLINT PRIMARY KEY,
    f_razon_social VARCHAR(80) NOT NULL,
    f_nit CHAR(15) NOT NULL,
    f_ind_estado SMALLINT NOT NULL,
    f_ind_consolidadora SMALLINT NOT NULL,
    f_max_per_abiertos SMALLINT NOT NULL,
    f_ult_per_abierto INT NOT NULL,
    f_ult_per_cerrado INT NOT NULL,
    f_ult_ano_cerrado SMALLINT NOT NULL,
    f_numero_periodos SMALLINT NOT NULL DEFAULT 12,
    f_ind_dias SMALLINT NOT NULL DEFAULT 0,
    f_ind_diferido SMALLINT NOT NULL DEFAULT 0,
    f_ind_inflacion SMALLINT NOT NULL DEFAULT 0,
    f_ind_dif_cambio SMALLINT NOT NULL DEFAULT 0,
    f_ind_dist_costos SMALLINT NOT NULL,
    f_ind_depreciacion_af SMALLINT NOT NULL DEFAULT 0,
    f_ind_consecutivo_af SMALLINT NOT NULL,
    f_consecutivo_af INT NOT NULL,
    f_rowid_contacto INT NULL,
    f_id_moneda_local CHAR(3) NULL,
    f_id_moneda_conversion CHAR(3) NULL,
    f_id_plan_cuentas CHAR(3) NULL,
    f_rowid_tercero_contab INT NOT NULL DEFAULT 0,
    f_rowid_ccosto_generico INT NULL,
    f_rowid_aux_desc_ventas INT NULL,
    f_rowid_aux_desc_compras INT NULL,
    f_rowid_aux_aprovecha INT NULL,
    f_rowid_aux_dif_compras INT NULL,
    f_rowid_aux_gyp INT NULL,
    f_rowid_ccosto_desc_ventas INT NULL,
    f_rowid_ccosto_desc_compras INT NULL,
    f_rowid_ccosto_aprovecha INT NULL,
    f_rowid_ccosto_dif_compras INT NULL,
    f_rowid_fe_generico INT NULL,
    f_max_aprovecha NUMERIC(19,4) NOT NULL DEFAULT 0,
    f_max_dif_compras NUMERIC(19,4) NOT NULL DEFAULT 0,
    f_num_resol_gc VARCHAR(20) NULL,
    f_fecha_resol_gc TIMESTAMP NULL,
    f_num_resol_autorete VARCHAR(20) NULL,
    f_fecha_resol_autorete TIMESTAMP NULL,
    f_ind_cdp SMALLINT NOT NULL DEFAULT 0,
    f_id_plan_rubro_ppto CHAR(3) NULL,
    f_id_plan_rubro_ccosto CHAR(3) NULL,
    f_notas VARCHAR(255) NULL,
    f_ciiu VARCHAR(10) NOT NULL DEFAULT '',
    f_dv_nit CHAR(3) NOT NULL DEFAULT '',
    f_ind_dist_cuentas SMALLINT NOT NULL DEFAULT 0,
    f_ind_reg_fijos SMALLINT NOT NULL DEFAULT 0,
    f_ind_trans_cta_puente_af SMALLINT NOT NULL DEFAULT 0,
    f_ind_ppto_oc SMALLINT NOT NULL DEFAULT 0,
    f_id_plan_ppto_oc CHAR(3) NULL,
    f_ind_valida_periodo_oc SMALLINT NOT NULL DEFAULT 0,
    f_ind_valida_co_oc SMALLINT NOT NULL DEFAULT 0,
    f_ind_valida_un_oc SMALLINT NOT NULL DEFAULT 0,
    f_nivel_ccosto_oc SMALLINT NOT NULL DEFAULT 0,
    f_ind_fecha_periodo SMALLINT NOT NULL DEFAULT 1,
    f_path_postscript VARCHAR(255) NULL,
    f_rowid_aux_dif_compras_nd INT NULL,
    f_rowid_ccosto_dif_comp_nd INT NULL,
    f_max_dif_compras_nd NUMERIC(19,4) NOT NULL DEFAULT 0,
    f_id_moneda_rx CHAR(3) NULL,
    f_ind_contabiliza_gastos SMALLINT NOT NULL DEFAULT 0,
    f_ind_co_gastos SMALLINT NOT NULL DEFAULT 0,
    f_ind_un_gastos SMALLINT NOT NULL DEFAULT 0,
    f_ind_ccosto_gastos SMALLINT NOT NULL DEFAULT 0,
    f_per_ini_rx INT NULL,
    f_ind_calc_fecha_vcto SMALLINT NOT NULL DEFAULT 0,
    f_rowid_movto_entidad INT NULL,
    f_rowid_aux_desc_comp2 INT NULL,
    f_rowid_ccosto_desc_comp2 INT NULL,
    f_rowid_aux_ingres_comp2 INT NULL,
    f_rowid_ccosto_ingres_comp2 INT NULL,
    f_ind_amort_inst_fn SMALLINT NOT NULL DEFAULT 0,
    f_id_concepto_ppago_gastos SMALLINT NULL,
    f_id_motivo_ppago_gastos_fn CHAR(2) NULL,
    f_rowid_aux_desc_vtas2 INT NULL,
    f_rowid_ccosto_desc_vtas2 INT NULL,
    f_vlr_max_otros_ingresos NUMERIC(19,4) NOT NULL DEFAULT 0,
    f_ind_depre_salva_af_1 SMALLINT NOT NULL DEFAULT 1,
    f_ind_depre_salva_af_2 SMALLINT NOT NULL DEFAULT 1,
    f_ind_pp_anticipo SMALLINT NULL DEFAULT 0,
    f_ind_recalc_salva_af_2 SMALLINT NOT NULL DEFAULT 0,
    f_ind_ppto_of_rp SMALLINT NOT NULL DEFAULT 0,
    f_ind_dif_cambio_rx SMALLINT NOT NULL DEFAULT 0,
    f_ind_libro_defecto SMALLINT NOT NULL DEFAULT 1,
    f_ind_libro1_visible SMALLINT NOT NULL DEFAULT 1,
    f_ind_libro2_visible SMALLINT NOT NULL DEFAULT 1,
    f_ind_libro3_visible SMALLINT NOT NULL DEFAULT 1,
    f_ind_estado_pago_cxp SMALLINT NOT NULL DEFAULT 0,
    f_ind_libro_dsto_fin_pp SMALLINT NOT NULL DEFAULT 2,
    f_ind_ret_co_movto SMALLINT NOT NULL DEFAULT 0,
    f_cant_anual_uvt_pago_efe INT NOT NULL DEFAULT 0,
    f_ind_imp_co_movto_cmp SMALLINT NOT NULL DEFAULT 0,

    CONSTRAINT uq_t_mm_companias_id UNIQUE (f_id),
    CONSTRAINT chk_t_mm_companias_razon_social_no_vacia CHECK (btrim(f_razon_social) <> ''),
    CONSTRAINT chk_t_mm_companias_nit_no_vacio CHECK (btrim(f_nit) <> ''),
    CONSTRAINT chk_t_mm_companias_estado CHECK (f_ind_estado IN (0,1)),
    CONSTRAINT chk_t_mm_companias_consolidadora CHECK (f_ind_consolidadora IN (0,1)),
    CONSTRAINT chk_t_mm_companias_max_per_abiertos CHECK (f_max_per_abiertos > 0 AND f_max_per_abiertos <= 999),
    CONSTRAINT chk_t_mm_companias_ind_cdp CHECK (f_ind_cdp BETWEEN 0 AND 2),
    CONSTRAINT chk_t_mm_companias_ind_libro_defecto CHECK (f_ind_libro_defecto IN (1,2,3)),
    CONSTRAINT chk_t_mm_companias_ind_libro_dsto_fin_pp CHECK (f_ind_libro_dsto_fin_pp IN (0,2)),
    CONSTRAINT chk_t_mm_companias_ciiu_no_vacio CHECK (btrim(f_ciiu) <> ''),
    CONSTRAINT chk_t_mm_companias_dv_nit_no_vacio CHECK (btrim(f_dv_nit) <> '')
);

CREATE OR REPLACE FUNCTION fn_bloquear_edicion_id_t_mm_companias()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.f_id <> OLD.f_id THEN
        RAISE EXCEPTION 'f_id no se puede editar en t_mm_companias';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS tr_bloquear_edicion_id_t_mm_companias ON t_mm_companias;

CREATE TRIGGER tr_bloquear_edicion_id_t_mm_companias
BEFORE UPDATE ON t_mm_companias
FOR EACH ROW
EXECUTE FUNCTION fn_bloquear_edicion_id_t_mm_companias();

CREATE INDEX IF NOT EXISTS ix_t_mm_companias_rowid_movto_entidad
    ON t_mm_companias (f_rowid_movto_entidad);

SELECT 'Tabla t_mm_companias creada exitosamente.' AS mensaje;
