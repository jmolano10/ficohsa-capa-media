xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT241" element="ns0:procesaMensajeGenericoT24" location="../../../../v2/Resources/ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validacionOverlimitRequest" location="../../ValidacionOverlimit/xsd/ValidacionOverlimitTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ValidacionOverlimitFacade/xq/validacionOverlimitT24In/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/ValidacionOverlimitTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";

declare function xf:validacionOverlimitT24In($procesaMensajeGenericoT241 as element(ns0:procesaMensajeGenericoT24),
    $crucemoneda as xs:string)
    as element(ns1:validacionOverlimitRequest) {
        <ns1:validacionOverlimitRequest>
        	{	
        		let $messageListFM := fn:tokenize(data($procesaMensajeGenericoT241/MESSAGE),"@FM")
	             return(
	             
		            <CARD_NUMBER>{ $messageListFM[1] }</CARD_NUMBER>,
		            <CARD_BANK>{ $messageListFM[2] }</CARD_BANK>,
		            <COUNTRY_CODE>{ $messageListFM[3] }</COUNTRY_CODE>,
		            if (fn:string($messageListFM[4]) != '') then (
		            <PAYMENT_AMOUNT>{ $messageListFM[4] }</PAYMENT_AMOUNT>
		            )else (
		            <PAYMENT_AMOUNT>{ $messageListFM[5] }</PAYMENT_AMOUNT>
		            ),
		            <PAYMENT_CURRENCY>{ $messageListFM[6] }</PAYMENT_CURRENCY>,
		            <EXCHANGE_RATE>{ $messageListFM[7] }</EXCHANGE_RATE>,
		            <COINS_CROSSING>{ $crucemoneda }</COINS_CROSSING>
            		)
            }
        </ns1:validacionOverlimitRequest>
};

declare variable $procesaMensajeGenericoT241 as element(ns0:procesaMensajeGenericoT24) external;
declare variable $crucemoneda as xs:string external;

xf:validacionOverlimitT24In($procesaMensajeGenericoT241,
    $crucemoneda)