(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDeal" location="../../ConsultaDeal/xsd/consultaDealTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDealTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDealFacade/xq/consultaDealIn/";

declare function xf:consultaDealIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:consultaDeal) {
        <ns1:consultaDeal>
        {
        	let $messageList := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
            return (
	            <CONTRACT_ID>{ $messageList[1] }</CONTRACT_ID>,
	            <COUNTRY>{ $messageList[2] }</COUNTRY>
        	)
        }
        </ns1:consultaDeal>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:consultaDealIn($procesaMensajeGenericoT24)