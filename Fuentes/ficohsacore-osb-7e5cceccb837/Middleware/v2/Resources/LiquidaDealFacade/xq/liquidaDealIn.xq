xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:liquidaDeal" location="../../LiquidaDeal/xsd/liquidaDealTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/LiquidaDeal/xq/liquidaDealFacadeIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/liquidaDealTypes";

declare function xf:liquidaDealFacadeIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:liquidaDeal) {
        <ns1:liquidaDeal>
       	{
        	let $messageList := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
            return (
	            <CONTRACT_ID>{ $messageList[1] }</CONTRACT_ID>,
	            <COUNTRY>{ $messageList[2] }</COUNTRY>
            )
        }
        </ns1:liquidaDeal>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:liquidaDealFacadeIn($procesaMensajeGenericoT24)