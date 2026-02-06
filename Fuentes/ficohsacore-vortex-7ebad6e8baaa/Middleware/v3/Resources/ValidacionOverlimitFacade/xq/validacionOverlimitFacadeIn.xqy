xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../../../v2/Resources/ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validacionOverlimitRequest" location="../../ValidacionOverlimit/xsd/ValidacionOverlimitTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/ValidacionOverlimitTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ValidacionOverlimitFacade/xq/validacionOverlimitFacadeIn/";

declare function xf:validacionOverlimitFacadeIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:validacionOverlimitRequest) {
        <ns1:validacionOverlimitRequest>
        	{	
        		let $messageListFM := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
	             return(
	             
		            <CARD_NUMBER>{ $messageListFM[1] }</CARD_NUMBER>,
		            <CARD_BANK>{ $messageListFM[2] }</CARD_BANK>,
		            <COUNTRY_CODE>{ $messageListFM[3] }</COUNTRY_CODE>,
		            <PAYMENT_AMOUNT>{ $messageListFM[4] }</PAYMENT_AMOUNT>,
		            <PAYMENT_CURRENCY>{ $messageListFM[5] }</PAYMENT_CURRENCY>,
		            <EXCHANGE_RATE>{ 1 }</EXCHANGE_RATE>,
		           <COINS_CROSSING>{ 'NO' }</COINS_CROSSING>
            		)
            }
        </ns1:validacionOverlimitRequest>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:validacionOverlimitFacadeIn($procesaMensajeGenericoT24)