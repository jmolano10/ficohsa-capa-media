xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$cancelarLoteFacturas" element="ns0:cancelarLoteFacturas" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABK/cancelarLoteFacturas/xsd/cancelarLoteFacturas_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/cobranzasElectronicasTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/cancelarLoteFacturas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarLoteFacturas/xq/cancelarLoteFacturasIn/";

declare function xf:cancelarLoteFacturasIn($cancelarLoteFacturas as element(ns0:cancelarLoteFacturas))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGOCLIENTE>{ data($cancelarLoteFacturas/CUSTOMER_ID) }</ns1:PV_CODIGOCLIENTE>
            <ns1:PV_NUMEROCONTRATO>{ data($cancelarLoteFacturas/CONTRACT_ID) }</ns1:PV_NUMEROCONTRATO>
            <ns1:PV_NROLOTE>{ data($cancelarLoteFacturas/BANK_BATCH_ID) }</ns1:PV_NROLOTE>
        </ns1:InputParameters>
};

declare variable $cancelarLoteFacturas as element(ns0:cancelarLoteFacturas) external;

xf:cancelarLoteFacturasIn($cancelarLoteFacturas)