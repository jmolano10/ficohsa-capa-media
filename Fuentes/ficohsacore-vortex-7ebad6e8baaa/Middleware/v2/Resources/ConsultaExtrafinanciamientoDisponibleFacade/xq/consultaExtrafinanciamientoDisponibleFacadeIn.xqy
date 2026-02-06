xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaExtrafinanciamientoDisponible" location="../../ConsultaExtrafinanciamientoDisponible/xsd/consultaExtrafinanciamientoDisponibleTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaExtrafinanciamientoDisponibleFacade/xq/consultaExtrafinanciamientoDisponibleFacadeIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaExtrafinanciamientoDisponibleTypes";

declare function xf:consultaExtrafinanciamientoDisponibleFacadeIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:consultaExtrafinanciamientoDisponible) {
        <ns1:consultaExtrafinanciamientoDisponible> {
        	let $messageList := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
        	return (
        		<SEARCH_VALUE>{ $messageList[1] }</SEARCH_VALUE>,
        		<SEARCH_CRITERIA>{ $messageList[2] }</SEARCH_CRITERIA>
        	)
        }
        </ns1:consultaExtrafinanciamientoDisponible>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:consultaExtrafinanciamientoDisponibleFacadeIn($procesaMensajeGenericoT24)