(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns1:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns2:RegistrarTransaccionTC" location="../../RegistrarTransaccionTC/xsd/RegistrarTransaccionTCTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/RegistrarTransaccionTCTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistrarTransaccionTCFacade24/xq/registrarTransaccionTCFacadeT24In/";

declare function xf:registrarTransaccionTCFacadeT24In($procesaMensajeGenericoT24 as element(ns1:procesaMensajeGenericoT24))
    as element(ns2:RegistrarTransaccionTC) {
        <ns2:RegistrarTransaccionTC>
        	{		
        		let $messageListFM := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
	             return(
	             
		            <CREDITCARD_NUMBER>{ $messageListFM[1] }</CREDITCARD_NUMBER>,
		            <TRANSACTION_CURRENCY>{ $messageListFM[2] }</TRANSACTION_CURRENCY>,
		            <TRANSACTION_AMOUNT>{ $messageListFM[3] }</TRANSACTION_AMOUNT>,
		            <REQUEST_TYPE>{ $messageListFM[4] }</REQUEST_TYPE>,
		            <INSTALLMENTS>{ $messageListFM[5] }</INSTALLMENTS>,
		            <MERCHANT_NUMBER>{ $messageListFM[6] }</MERCHANT_NUMBER>,
		            <MCCType>{ $messageListFM[7] }</MCCType>,
		            <REFERENCE_NUMBER>{ $messageListFM[8] }</REFERENCE_NUMBER>,
		            <EXPIRATION_DATE>{ $messageListFM[9] }</EXPIRATION_DATE>,
		            <ORG>{ $messageListFM[10] }</ORG>
            		)
            }
        </ns2:RegistrarTransaccionTC>
};

declare variable $procesaMensajeGenericoT24 as element(ns1:procesaMensajeGenericoT24) external;

xf:registrarTransaccionTCFacadeT24In($procesaMensajeGenericoT24)