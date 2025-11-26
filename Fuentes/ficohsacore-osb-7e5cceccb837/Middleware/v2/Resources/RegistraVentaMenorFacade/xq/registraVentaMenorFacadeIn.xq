xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:registraVentaMenor" location="../../RegistraVentaMenor/xsd/registraVentaMenorTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraVentaMenorFacade/xq/registraVentaMenoFacadeIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registraVentaMenorTypes";

declare function xf:registraVentaMenoFacadeIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:registraVentaMenor) {
        <ns1:registraVentaMenor>
        {
        	let $messageListFM := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
        	return(
	            <LEGAL_ID>{ $messageListFM[4] }</LEGAL_ID>,
	            <CUSTOMER_ID>{ $messageListFM[5] }</CUSTOMER_ID>,
            	<FOREIGN_AMOUNT>{ $messageListFM[3] }</FOREIGN_AMOUNT>,
	            <LOCAL_AMOUNT>{ $messageListFM[8] }</LOCAL_AMOUNT>,
	            <DESTINATION_CURRENCY>{ $messageListFM[2] }</DESTINATION_CURRENCY>,
	            <EXCHANGE_RATE>{ $messageListFM[7] }</EXCHANGE_RATE>,
	            <TRANSACTION_DATE>{ $messageListFM[6] }</TRANSACTION_DATE>,
	            <TRANSACTION_ID>{ $messageListFM[11] }</TRANSACTION_ID>,
	            <PRODUCT_NUMBER>{ $messageListFM[12] }</PRODUCT_NUMBER>,
	            <USER_ID>{ $messageListFM[9] }</USER_ID>,
	            <BRANCH>{ $messageListFM[10] }</BRANCH>
            )
        }
        </ns1:registraVentaMenor>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:registraVentaMenoFacadeIn($procesaMensajeGenericoT24)