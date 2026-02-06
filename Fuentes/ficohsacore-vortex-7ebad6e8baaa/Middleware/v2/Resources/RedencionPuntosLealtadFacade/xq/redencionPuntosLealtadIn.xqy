xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT241" element="ns1:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns0:redencionPuntosLealtad" location="../../ProgramaLealtad/xsd/programaLealtadTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RedencionPuntosLealtadFacade/xq/redencionPuntosLealtadIn/";

declare function xf:redencionPuntosLealtadIn($procesaMensajeGenericoT241 as element(ns1:procesaMensajeGenericoT24))
    as element(ns0:redencionPuntosLealtad) {
        <ns0:redencionPuntosLealtad>
        {
        	let $messageListFM := fn:tokenize(data($procesaMensajeGenericoT241/MESSAGE),"@FM")
        	return
        	(
        		
        		<CUSTOMER_ID_TYPE>{$messageListFM[1]}</CUSTOMER_ID_TYPE>,
            	<CUSTOMER_ID_VALUE>{$messageListFM[2]}</CUSTOMER_ID_VALUE>,
            	<REDEMPTION_TYPE>{$messageListFM[3]}</REDEMPTION_TYPE>,
            	<REDEMPTION_AMOUNT>{$messageListFM[4]}</REDEMPTION_AMOUNT>,
            	<CASH_REDEMPTION>
            		<CARD_NUMBER>{$messageListFM[5]}</CARD_NUMBER>
            		<MERCHANT_ID>{$messageListFM[6]}</MERCHANT_ID>
            		<MERCHANT_TYPE>{$messageListFM[7]}</MERCHANT_TYPE>
            		<TERMINAL_ID>{$messageListFM[8]}</TERMINAL_ID>
            	</CASH_REDEMPTION>,
                <REDEMPTION_DETAILS>
                    <REDEMPTION_METHOD>{$messageListFM[9]}</REDEMPTION_METHOD>
                    <ACCOUNT_NUMBER>{$messageListFM[10]}</ACCOUNT_NUMBER>
                    <CREDIT_CARD_NUMBER>{$messageListFM[11]}</CREDIT_CARD_NUMBER>
                </REDEMPTION_DETAILS>,
                if ($messageListFM[12]) then (<PROGRAM_ID>{$messageListFM[12]}</PROGRAM_ID>) else ()
        	)
		}
            
        </ns0:redencionPuntosLealtad>
};

declare variable $procesaMensajeGenericoT241 as element(ns1:procesaMensajeGenericoT24) external;

xf:redencionPuntosLealtadIn($procesaMensajeGenericoT241)