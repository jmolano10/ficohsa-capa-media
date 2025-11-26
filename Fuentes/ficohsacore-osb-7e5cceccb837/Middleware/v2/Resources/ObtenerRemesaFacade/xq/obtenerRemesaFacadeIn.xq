(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:obtenerRemesa" location="../../ObtenerRemesa/xsd/obtenerRemesaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/obtenerRemesaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ObtenerRemesaFacade/xq/obtenerRemesaFacadeIn/";

declare function xf:obtenerRemesaFacadeIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:obtenerRemesa) {
        <ns1:obtenerRemesa>
	    	<REMITTANCE_CODE>{ data($procesaMensajeGenericoT24/MESSAGE) }</REMITTANCE_CODE>
        </ns1:obtenerRemesa>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:obtenerRemesaFacadeIn($procesaMensajeGenericoT24)