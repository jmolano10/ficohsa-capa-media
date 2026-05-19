PROCEDURE HTH_P_CONSULTA_CONVENIOS(
        --
        Pt_IdServicio                   IN TVARCHAR10,
        Pv_CodigoPais                   IN VARCHAR2,
        --
        Pt_InfoConvenios               OUT T_INFO_CONVENIOS,
        Pv_CodigoMensaje               OUT VARCHAR2,
        Pv_DescripcionMensaje          OUT VARCHAR2
        --
    ) IS
        --
        Lt_Descripcion              PROXYABANKSHN.BE_TYPES.TVARCHAR70;
        Lt_IdServicio               PROXYABANKSHN.BE_TYPES.TVARCHAR10;
        Lt_NumeroContrato           PROXYABANKSHN.BE_TYPES.TVARCHAR40;
        Lt_InfoConvenios            T_INFO_CONVENIOS_ITEM;
        Lv_CodigoMensaje            VARCHAR2(5);
        Lv_DescripcionMensaje       VARCHAR2(300);
        Ln_Cantidad                 NUMBER;
        --
    BEGIN
        --
        Ln_Cantidad := Pt_IdServicio.COUNT();
        --
        FOR i IN 1 .. Ln_Cantidad LOOP
        --> SQL TO PL
            Lt_IdServicio (i) := Pt_IdServicio(i);
        --
        END LOOP;
        --
        IF Pv_CodigoPais = 'HN01' THEN
            --
            proxyabankshn.BNKEL_P_CONSULTA_CONVENIO (
                --
                Lt_IdServicio,
                Lt_NumeroContrato,
                Lt_Descripcion,
                Lv_CodigoMensaje,
                Lv_DescripcionMensaje
                --
            );
            --
            IF Lv_CodigoMensaje = '00000' THEN
                --
                Pt_InfoConvenios  := SERVICIO.T_INFO_CONVENIOS();
                Pt_InfoConvenios.EXTEND(Ln_Cantidad);
                --
                FOR i IN 1 .. Ln_Cantidad LOOP
                --
                    Lt_InfoConvenios := SERVICIO.T_INFO_CONVENIOS_ITEM(
                        --
                        Lt_IdServicio(i),
                        NVL(Lt_NumeroContrato(i), ''),
                        NVL(Lt_Descripcion(i), '')
                        --
                    );
                    --
                    Pt_InfoConvenios(i) := Lt_InfoConvenios;
                --
                END LOOP;
                --
                Pv_CodigoMensaje  := 'SUCCESS';
                RETURN;
                --
            ELSE
                --
                Pv_CodigoMensaje      := 'ERROR';
                Pv_DescripcionMensaje := Lv_DescripcionMensaje;
                RETURN;
                --
            END IF;
            --
        ELSE
            --
            Pv_CodigoMensaje      := 'ERROR';
            Pv_DescripcionMensaje := 'La consulta de convenios no esta habilitada para el codigo pais ' || Pv_CodigoPais || '.';
            RETURN;
            --
        END IF;
        --
    EXCEPTION
        --
        WHEN OTHERS THEN
            --
            Pv_CodigoMensaje      := 'ERROR';
            Pv_DescripcionMensaje := 'Error consultando los convenios. ' || SQLERRM;
            --
    END HTH_P_CONSULTA_CONVENIOS;