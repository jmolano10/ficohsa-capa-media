(:: pragma bea:global-element-parameter parameter="$obtenerRemesa" element="ns1:obtenerRemesa" location="../xsd/obtenerRemesaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/INTFC/sincronizacionRemesasT24/xsd/sincronizacionRemesasT24_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/sincronizacionRemesasT24";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/obtenerRemesaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ObtenerRemesa/xq/obtenerRemesaHNIn/";

declare function xf:obtenerRemesaHNIn($obtenerRemesa as element(ns1:obtenerRemesa))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_REMITTANCE_CODE>{ data($obtenerRemesa/REMITTANCE_CODE) }</ns0:PV_REMITTANCE_CODE>
        </ns0:InputParameters>
};

declare variable $obtenerRemesa as element(ns1:obtenerRemesa) external;

xf:obtenerRemesaHNIn($obtenerRemesa)