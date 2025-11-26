(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../xsds/AplicaTCT24/ORA_BANK_T24_P_APLICA_TC.xsd" ::)
(:: pragma bea:global-element-return element="ns0:reversarPagoResponse" location="../../wsdls/Alcance.wsdl" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/T24_P_APLICA_TC/";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/TarjetaCreditoT24/ReversarPagoOut/";

declare function xf:ReversarPagoOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:reversarPagoResponse) {
        <ns0:reversarPagoResponse>
            <ns0:reversarPagoResult>
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
            </ns0:reversarPagoResult>
        </ns0:reversarPagoResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:ReversarPagoOut($outputParameters)