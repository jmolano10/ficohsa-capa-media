(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:reversionDeal" location="../../ReversionDeal/xsd/reversionDealTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reversionDealTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversionDealFacade/xq/reversionDealFacadeIn/";

declare function xf:reversionDealFacadeIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:reversionDeal) {
        <ns1:reversionDeal>
	        {
		        let $messageListFM := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
		        	return(
		            	<CONTRACT_ID>{ $messageListFM[1] }</CONTRACT_ID>,
		            	<COUNTRY>{ data($messageListFM[2]) }</COUNTRY>
		            )
	        }
        </ns1:reversionDeal>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:reversionDealFacadeIn($procesaMensajeGenericoT24)
