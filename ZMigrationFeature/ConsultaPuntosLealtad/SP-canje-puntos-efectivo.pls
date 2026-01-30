CREATE OR REPLACE PROCEDURE PROXYNICARAGUA."PL_P_CANJE_PUNTOS_EFECTIVO" (
    --
    Pn_Logo                   IN NUMBER,
    Pv_CodigoComercio         IN VARCHAR2,
    Pv_GrupoComercio          IN VARCHAR2,
    Pv_CodigoTerminal         IN VARCHAR2,
    Pn_TipoConversion         IN NUMBER,
    Pn_ValorEntrada           IN NUMBER,
    --
    Pn_ValorSalida           OUT NUMBER,
    Pn_FactorCanje           OUT NUMBER,
    Pv_CodigoMensaje         OUT VARCHAR2,
    Pv_DescripcionMensaje    OUT VARCHAR2
    --
) AS
    --
    Ln_ValorEntradaPuntos       NUMBER;
    Ln_FactorCanje              NUMBER (10, 4);
    Lv_Estado                   VARCHAR2(1) := 'A';
    Ld_FechaActual              DATE := TRUNC(SYSDATE);
    --
BEGIN
    --
    Ln_ValorEntradaPuntos := TRUNC(Pn_ValorEntrada);
    --
    IF Pn_TipoConversion IN (1, 2) THEN
        --
        BEGIN
            --
            SELECT FACTOR_CANJE
              INTO Ln_FactorCanje
              FROM (
                    --
                    SELECT A.FACTOR_CANJE
                      FROM PROXYNICARAGUA.PL_CANJE_PUNTOS_EFECTIVO A, PROXYNICARAGUA.PL_DATOS_COMPLEMENTARIOS B
                     WHERE A.LOGO = Pn_Logo
                       AND A.ESTADO = Lv_Estado
                       AND A.CODIGO_COMPLEMENTO = B.CODIGO
                       AND Ld_FechaActual BETWEEN A.FECHA_INICIO AND A.FECHA_FIN
                       AND ( ( A.CODIGO_COMPLEMENTO = 4 AND A.VALOR_COMPLEMENTO IS NULL )
                           OR ( A.CODIGO_COMPLEMENTO = 3 AND A.VALOR_COMPLEMENTO = Pv_GrupoComercio )
                           OR ( A.CODIGO_COMPLEMENTO = 2 AND A.VALOR_COMPLEMENTO = Pv_CodigoComercio )
                           OR ( A.CODIGO_COMPLEMENTO = 1 AND A.VALOR_COMPLEMENTO = Pv_CodigoTerminal )
                        )
                      ORDER BY B.PRIORIDAD DESC, A.FECHA_INICIO DESC
                    --
                )
             WHERE ROWNUM = 1;
            --
            --> Tipo Conversión 1 = Conversión de puntos a efectivo
            IF Pn_TipoConversion = 1 THEN
                --
                Pn_ValorSalida := ROUND( (Ln_ValorEntradaPuntos * Ln_FactorCanje), 2 );
                Pn_FactorCanje := Ln_FactorCanje;
                --
            --> Tipo Conversión 2 = Conversión de efectivo a puntos */
            ELSE
                --
                Pn_ValorSalida := ROUND( (Ln_ValorEntradaPuntos / Ln_FactorCanje), 0 );
                Pn_FactorCanje := Ln_FactorCanje;
                --
            END IF;
                --
                Pv_CodigoMensaje := 'SUCCESS';
                --
        EXCEPTION
            --
            WHEN NO_DATA_FOUND THEN
                --
                Pv_CodigoMensaje := 'ERROR';
                Pv_DescripcionMensaje := 'No existe factor de canje disponible.';
                RETURN;
                --
        END;
        --
    ELSE
        --
        Pv_CodigoMensaje := 'ERROR';
        Pv_DescripcionMensaje := 'Tipo de conversión inválida.';
        RETURN;
        --
    END IF;
    --
EXCEPTION
    --
    WHEN OTHERS THEN
        --
        Pv_CodigoMensaje := 'ERROR';
        Pv_DescripcionMensaje := 'Error obteniendo factor de canje. ' || SQLERRM;
        --
END PL_P_CANJE_PUNTOS_EFECTIVO;
 