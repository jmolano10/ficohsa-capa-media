(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns1:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaPuntosLealtad" location="../../ProgramaLealtad/xsd/programaLealtadTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPuntosLealtadFacade/xq/consultaPuntosLealtadIn/";

declare function xf:consultaPuntosLealtadIn($procesaMensajeGenericoT24 as element(ns1:procesaMensajeGenericoT24))
    as element(ns0:consultaPuntosLealtad) {
        <ns0:consultaPuntosLealtad>
        	{
	        	let $messageListFM := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
	             return(
		            <CUSTOMER_ID_TYPE>{ $messageListFM[1] }</CUSTOMER_ID_TYPE>,
		            <CUSTOMER_ID_VALUE>{ $messageListFM[2] }</CUSTOMER_ID_VALUE>,
		            <RETURN_CASH_EQUIVALENT>{ $messageListFM[3] }</RETURN_CASH_EQUIVALENT>,
		            <CASH_REDEMPTION>
	                    <CARD_NUMBER>{ $messageListFM[4] }</CARD_NUMBER>
	                    <MERCHANT_ID>{ $messageListFM[5] }</MERCHANT_ID>
	                    <MERCHANT_TYPE>{ $messageListFM[6] }</MERCHANT_TYPE>
	                    <TERMINAL_ID>{ $messageListFM[7] }</TERMINAL_ID>
                	</CASH_REDEMPTION>,
                	if ($messageListFM[9])then (<PROGRAM_ID>{ $messageListFM[9] }</PROGRAM_ID>)else ()
		           		)
	           }
	   </ns0:consultaPuntosLealtad>
};

declare variable $procesaMensajeGenericoT24 as element(ns1:procesaMensajeGenericoT24) external;

xf:consultaPuntosLealtadIn($procesaMensajeGenericoT24)