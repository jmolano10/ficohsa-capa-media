CREATE OR REPLACE PROCEDURE PROXYABANKSHN."HTH_P_CONS_CAMPOS_CBR_X_SERV" (
    --
    Pv_IdServicio               IN VARCHAR2,
    Pv_Operacion                IN VARCHAR2,
    --
    Pt_CamposPorServicio       OUT T_CBR_CAMPOS_X_SERVICIO,
    Pv_CodigoMensaje           OUT VARCHAR2,
    Pv_DescripcionMensaje      OUT VARCHAR2
    --
) IS
--
    Lt_CamposPorServicioItems   T_CBR_CAMPOS_X_SERVICIO_ITEMS;
    Lt_CamposPorServicio        T_CBR_CAMPOS_X_SERVICIO;
    Ln_Cantidad                 NUMBER := 0;
    --
    CURSOR C_CAMPOS_X_SERVICIO IS
        SELECT c.CAMPO_ORIGEN, c.POS_DESTINO
          FROM HTH_CAMPOS_CBR_X_SERV c
         WHERE c.SERVICIO  = Pv_IdServicio
           AND c.OPERACION = Pv_Operacion;
--
BEGIN
    --
    Lt_CamposPorServicio := T_CBR_CAMPOS_X_SERVICIO();
    --
    FOR CAMPOS IN C_CAMPOS_X_SERVICIO LOOP
        --
        Lt_CamposPorServicio.EXTEND (1);
        --
        Lt_CamposPorServicioItems := T_CBR_CAMPOS_X_SERVICIO_ITEMS(
            --
            CAMPOS.CAMPO_ORIGEN,
            CAMPOS.POS_DESTINO
            --
        );
        Ln_Cantidad := Ln_Cantidad + 1;
        Lt_CamposPorServicio(Ln_Cantidad) := Lt_CamposPorServicioItems;
        --
    END LOOP;
    --
    IF Ln_Cantidad > 0 THEN
        --
        Pt_CamposPorServicio := Lt_CamposPorServicio;
        --
    END IF;
    --
    Pv_CodigoMensaje      := 'SUCCESS';
    --
EXCEPTION
    --
    WHEN OTHERS THEN
        --
        Pv_CodigoMensaje := 'ERROR';
        Pv_DescripcionMensaje := 'Error al consultar los campos de parametrización de información adicional. ' || SQLERRM;
        --
END HTH_P_CONS_CAMPOS_CBR_X_SERV;
 