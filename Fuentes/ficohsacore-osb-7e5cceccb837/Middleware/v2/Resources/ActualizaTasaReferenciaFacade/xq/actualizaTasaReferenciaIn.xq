xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns1:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns0:actualizaTasaReferencia" location="../../ActualizaTasaReferencia/xsd/actualizaTasaReferenciaTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaTasaReferenciaFacade/xq/actualizaTasaReferenciaIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/actualizaTasaReferenciaTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";

declare function xf:actualizaTasaReferenciaIn($procesaMensajeGenericoT24 as element(ns1:procesaMensajeGenericoT24))
    as element(ns0:actualizaTasaReferencia) {
        <ns0:actualizaTasaReferencia>
        {
        	let $messageList := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
            return (
	            <COUNTRY>{ $messageList[1] }</COUNTRY>,
	            <RATE>{ $messageList[2] }</RATE>,
	            <SOURCE_CURRENCY>{ $messageList[3] }</SOURCE_CURRENCY>,
	            <TARGET_CURRENCY>{ $messageList[4] }</TARGET_CURRENCY>
            
        	)
        }
        </ns0:actualizaTasaReferencia>
};

declare variable $procesaMensajeGenericoT24 as element(ns1:procesaMensajeGenericoT24) external;

xf:actualizaTasaReferenciaIn($procesaMensajeGenericoT24)