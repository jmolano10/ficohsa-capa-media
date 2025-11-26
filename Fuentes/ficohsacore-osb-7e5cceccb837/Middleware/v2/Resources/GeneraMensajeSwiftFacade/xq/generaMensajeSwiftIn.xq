(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:generaMensajeSwiftRequest" location="../../GeneraMensajeSwift/xsd/generaMensajeSwiftTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generaMensajeSwiftTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraMensajeSwiftFacade/xq/generaMensajeSwiftIn/";

declare function xf:generaMensajeSwiftIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:generaMensajeSwiftRequest) {
        <ns1:generaMensajeSwiftRequest>
        	{
        		let $message := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
        		return (
		            <TRANSFER_TYPE>{ $message[1] }</TRANSFER_TYPE>,
		            <MESSAGE_TYPE>{ $message[2] }</MESSAGE_TYPE>,
		            <TRANSACTION_ID>{ $message[3] }</TRANSACTION_ID>,
		            <TRANSACTION_AMOUT>{ $message[4] }</TRANSACTION_AMOUT>,
		            <TRANSACTION_CURRENCY>{ $message[5] }</TRANSACTION_CURRENCY>,
		            <TRANSACTION_DATE>{ $message[6] }</TRANSACTION_DATE>,
		            <ORDERING_BANK_CODE>{ $message[7] }</ORDERING_BANK_CODE>,
		            <CUSTOMER_ID>{ $message[8] }</CUSTOMER_ID>,
		            <CUSTOMER_LEGAL_ID>{ $message[9] }</CUSTOMER_LEGAL_ID>,
		            <CUSTOMER_NAME>{ $message[10] }</CUSTOMER_NAME>,
		            <CUSTOMER_TYPE>{ $message[11] }</CUSTOMER_TYPE>,
		            <CUSTOMER_DATE_OF_BIRTH>{ $message[12] }</CUSTOMER_DATE_OF_BIRTH>,
		            <CUSTOMER_ADDRESS>{ $message[13] }</CUSTOMER_ADDRESS>,
		            <CUSTOMER_COUNTRY_CODE>{ $message[14] }</CUSTOMER_COUNTRY_CODE>,
		            <CUSTOMER_COUNTRY_NAME>{ $message[15] }</CUSTOMER_COUNTRY_NAME>,
                    <CUSTOMER_COUNTRY_DESTINY>{ $message[16] }</CUSTOMER_COUNTRY_DESTINY>,
		            <CUSTOMER_CITY_NAME>{ $message[17] }</CUSTOMER_CITY_NAME>,
		            <DEBIT_ACCOUNT>{ $message[18] }</DEBIT_ACCOUNT>,
		            <ACCOUNT_TYPE>{ $message[19] }</ACCOUNT_TYPE>,
		            <BENEFICIARY_BANK_CODE>{ $message[20] }</BENEFICIARY_BANK_CODE>,
		            <BENEFICIARY_NAME>{ $message[21] }</BENEFICIARY_NAME>,
		            <BENEFICIARY_LEGAL_ID>{$message[22]}</BENEFICIARY_LEGAL_ID>,
		            <BENEFICIARY_ACCOUNT>{ $message[23] }</BENEFICIARY_ACCOUNT>,
		            <BENEFICIARY_ACCOUNT_TYPE>{ $message[24] }</BENEFICIARY_ACCOUNT_TYPE>,
		            <BENEFICIARY_ADDRESS>{$message[25] }</BENEFICIARY_ADDRESS>,
		            <BENEFICIARY_INFO>{ $message[26] }</BENEFICIARY_INFO>,
		            <OPERATION_TYPE>{ $message[27] }</OPERATION_TYPE>,
		            <TRANSACTION_CHARGES>{ $message[28] }</TRANSACTION_CHARGES>,
		            <UNIQUE_REFERENCE>{ $message[29] }</UNIQUE_REFERENCE>
	            )
            }
            
        </ns1:generaMensajeSwiftRequest>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:generaMensajeSwiftIn($procesaMensajeGenericoT24)
