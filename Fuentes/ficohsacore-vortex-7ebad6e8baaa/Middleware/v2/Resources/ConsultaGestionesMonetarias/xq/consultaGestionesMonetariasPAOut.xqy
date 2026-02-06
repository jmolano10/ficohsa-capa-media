xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/IntefazSalesforce/GestionesMonetarias/xsd/consultaGestionesMonetarias_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaGestionesMonetariasResponse" location="../xsd/consultaGestionesMonetariasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaGestionesMonetariasTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaGestionesMonetarias";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaGestionesMonetarias/xq/consultaGestionesMonetariasPAOut/";

declare function xf:consultaGestionesMonetariasPAOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaGestionesMonetariasResponse) {
        <ns0:consultaGestionesMonetariasResponse>
            {
                for $PT_CAMPOS_RESULTADO_ITEM in $outputParameters/ns1:PT_CAMPOS_RESULTADO/ns1:PT_CAMPOS_RESULTADO_ITEM
                return
                    <GestionesMonetariasResponseRecord>
                        <NUMUSU>{ data($PT_CAMPOS_RESULTADO_ITEM/ns1:NUMUSU) }</NUMUSU>
                        <DETALLE>{ data($PT_CAMPOS_RESULTADO_ITEM/ns1:DETALLE) }</DETALLE>
                        <IMP_M_LOCAL>{ data($PT_CAMPOS_RESULTADO_ITEM/ns1:IMP_M_LOCAL) }</IMP_M_LOCAL>
                        <IMP_M_USD>{ data($PT_CAMPOS_RESULTADO_ITEM/ns1:IMP_M_USD) }</IMP_M_USD>
                        <FECHA_ORIGEN>{ data($PT_CAMPOS_RESULTADO_ITEM/ns1:FECHA_ORIGEN) }</FECHA_ORIGEN>
                        <FECHA_LIQ>{ data($PT_CAMPOS_RESULTADO_ITEM/ns1:FECHA_LIQ) }</FECHA_LIQ>
                        <FECHA_VENCIMIENTO>{ data($PT_CAMPOS_RESULTADO_ITEM/ns1:FECHA_VENCIMIENTO) }</FECHA_VENCIMIENTO>
                        <FECHA_LIQ_PROX>{ data($PT_CAMPOS_RESULTADO_ITEM/ns1:FECHA_LIQ_PROX) }</FECHA_LIQ_PROX>
                        <FECHA_PAGO>{ data($PT_CAMPOS_RESULTADO_ITEM/ns1:FECHA_PAGO) }</FECHA_PAGO>
                        <PORCENTAJE>{ data($PT_CAMPOS_RESULTADO_ITEM/ns1:PORCENTAJE) }</PORCENTAJE>
                        <CATEGORIA>{ data($PT_CAMPOS_RESULTADO_ITEM/ns1:CATEGORIA) }</CATEGORIA>
                        <SUB_CATEGORIA>{ data($PT_CAMPOS_RESULTADO_ITEM/ns1:SUB_CATEGORIA) }</SUB_CATEGORIA>
                        <OPERACION>{ data($PT_CAMPOS_RESULTADO_ITEM/ns1:OPERACION) }</OPERACION>
                        <PAGO_MLOCAL>{ data($PT_CAMPOS_RESULTADO_ITEM/ns1:PAGO_MLOCAL) }</PAGO_MLOCAL>
                        <PAGO_USD>{ data($PT_CAMPOS_RESULTADO_ITEM/ns1:PAGO_USD) }</PAGO_USD>
                        <SALDO_ACT_MLOCAL>{ data($PT_CAMPOS_RESULTADO_ITEM/ns1:SALDO_ACT_MLOCAL) }</SALDO_ACT_MLOCAL>
                        <SALDO_ACT_USD>{ data($PT_CAMPOS_RESULTADO_ITEM/ns1:SALDO_ACT_USD) }</SALDO_ACT_USD>
                    </GestionesMonetariasResponseRecord>
            }
        </ns0:consultaGestionesMonetariasResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaGestionesMonetariasPAOut($outputParameters)