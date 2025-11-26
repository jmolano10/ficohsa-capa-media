(:: pragma bea:global-element-parameter parameter="$consultarSaldos" element="ns0:consultarSaldos" location="../../wsdls/Alcance.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../xsds/ConsultarSaldoTCAbanks/ORA_BANK_OSB_CON_RESCUENTATC.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_CON_RESCUENTATC/";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/TarjetaCreditoT24/ConsultarSaldosIn/";

declare function xf:ConsultarSaldosIn($consultarSaldos as element(ns0:consultarSaldos))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:GN_NOTARJETA>{ data($consultarSaldos/ns0:noTarjetaCredito) }</ns1:GN_NOTARJETA>
        </ns1:InputParameters>
};

declare variable $consultarSaldos as element(ns0:consultarSaldos) external;

xf:ConsultarSaldosIn($consultarSaldos)