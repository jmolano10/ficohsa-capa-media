(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../xsds/AplicaTCT24/ORA_BANK_T24_P_APLICA_TC.xsd" ::)
(:: pragma bea:global-element-return element="ns0:registrarPagoResponse" location="../../wsdls/Alcance.wsdl" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/T24_P_APLICA_TC/";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/TarjetaCreditoT24/RegistrarPagoOut/";

declare function xf:RegistrarPagoOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:registrarPagoResponse) {
        <ns0:registrarPagoResponse>
            <ns0:registrarPagoResult>
                {
                    for $PV_CODIGOMENSAJE in $outputParameters/ns1:PV_CODIGOMENSAJE
                    return
                        <ns0:estatusConfirmacion>{ data($PV_CODIGOMENSAJE) }</ns0:estatusConfirmacion>
                }
                {
                    for $PV_DESCRIPCIONMENSAJE in $outputParameters/ns1:PV_DESCRIPCIONMENSAJE
                    return
                        <ns0:mensajeConfirmacion>{ data($PV_DESCRIPCIONMENSAJE) }</ns0:mensajeConfirmacion>
                }
            </ns0:registrarPagoResult>
        </ns0:registrarPagoResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:RegistrarPagoOut($outputParameters)