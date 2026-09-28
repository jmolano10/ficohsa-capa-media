(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/consultaTasaCambio/xsd/consultaTasaCambio_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTasaCambio";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaPasivosCliente/xq/consultaTasaCambioTCIn/";

declare function xf:consultaTasaCambioTCIn()
as element(ns0:InputParameters) {
    <ns0:InputParameters>
        <ns0:FROM_CURRENCY>PAB</ns0:FROM_CURRENCY>
        <ns0:TO_CURRENCY>USD</ns0:TO_CURRENCY>
    </ns0:InputParameters>
};


xf:consultaTasaCambioTCIn()