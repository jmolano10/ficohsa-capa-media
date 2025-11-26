(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoSwitchFacadeRequest" element="ns0:procesaMensajeGenericoSwitchFacadeRequest" location="../../ProcesaMensajeGenericoSwitch/xsd/procesaMensajeGenericoSwitchFacadeTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:notificaTransaccion" location="../../NotificaTransaccion/xsd/notificaTransaccionTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoSwitchFacadeTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/notificaTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaTransaccionFacade/xq/notificaTransaccionFacadeIn/";

declare function getISOCurrency($currency as xs:string)
	as xs:string {
		if($currency = '340') then(
			'HNL'
		) else if($currency = '840') then(
			'USD'
		)else if($currency = '320') then(
			'GTQ'
		)else if($currency = '558') then(
			'NIO'
		)else ($currency)
};

declare function xf:notificaTransaccionFacadeIn($procesaMensajeGenericoSwitchFacadeRequest as element(ns0:procesaMensajeGenericoSwitchFacadeRequest))
    as element(ns1:notificaTransaccion) {
        <ns1:notificaTransaccion>
        	{
                for $RetrievalReferenceNumber_037 in $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/RetrievalReferenceNumber_037
                return
                    <TRANSACTION_REFERENCE>{ data($RetrievalReferenceNumber_037) }</TRANSACTION_REFERENCE>
            }
            {
            	for $MTI in $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/MTI
            	return
            	<TRANSACTION_CODE>{ concat(substring(data($MTI), 1, 2), '00') }</TRANSACTION_CODE>
            }
            {
                for $ProcessingCode_003 in $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/ProcessingCode_003
                return
                	<TRANSACTION_TYPE_CODE>{ data($ProcessingCode_003) }</TRANSACTION_TYPE_CODE>
            }
            {
                for $ResponseCode_039 in $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/ResponseCode_039
                return
                    <TRANSACTION_ERROR_CODE>{ data($ResponseCode_039) }</TRANSACTION_ERROR_CODE>
            }
            {
            	let $PrimaryAccountNumber_002 := $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/PrimaryAccountNumber_002 
            	return
					<BIN>{ fn:substring(fn:string(data($PrimaryAccountNumber_002/text())), 1, 8) }</BIN>            
            }
            {
                for $PrimaryAccountNumber_002 in $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/PrimaryAccountNumber_002
                return
                    <CARD_NUMBER>{ data($PrimaryAccountNumber_002) }</CARD_NUMBER>
            }
            {
                for $AccountIdentification1_102 in $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/AccountIdentification1_102
                return
                    <ACCOUNT_NUMBER>{ data($AccountIdentification1_102) }</ACCOUNT_NUMBER>
            }
            {
                for $CardAcceptorTerminalIdentification_041 in $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/CardAcceptorTerminalIdentification_041
                return
                    <TERMINAL_ID>{ data($CardAcceptorTerminalIdentification_041) }</TERMINAL_ID>
            }
            {
                for $CurrencyCodeTransaction_049 in $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/CurrencyCodeTransaction_049
                return
                    <TRANSACTION_CURRENCY>{ getISOCurrency(data($CurrencyCodeTransaction_049)) }</TRANSACTION_CURRENCY>
            }
            <TRANSACTION_AMOUNT>{ xs:decimal(data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/AmountCardholderBilling_006)) div 100 }</TRANSACTION_AMOUNT>
            <TRANSACTION_ORIGINAL_AMOUNT>{ xs:decimal(data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/AmountTransaction_004)) div 100 }</TRANSACTION_ORIGINAL_AMOUNT>
            <TRANSACTION_ORIGINAL_DATE>{ fn-bea:date-to-string-with-format("yyyy-MM-dd", fn-bea:date-from-string-with-format("yyyyMMdd", concat(fn-bea:date-to-string-with-format("yyyy", current-date()), data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/DateLocalTransaction_013)))) }</TRANSACTION_ORIGINAL_DATE>
            {
                for $CardAcceptorNameLocation_043 in $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/CardAcceptorNameLocation_043
                return
                    <TRANSACTION_SOURCE_COUNTRY>
                    { 
                    	fn-bea:trim(substring(data($CardAcceptorNameLocation_043), 39, 2)) 
                    }
                    </TRANSACTION_SOURCE_COUNTRY>
            }
            {
                for $CardAcceptorNameLocation_043 in $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/CardAcceptorNameLocation_043
                return
                    <TRANSACTION_SOURCE_CITY>
                    { 
                    	fn-bea:trim(substring(data($CardAcceptorNameLocation_043), 23, 13)) 
                    }
                    </TRANSACTION_SOURCE_CITY>
            }
            {
                for $CardAcceptorNameLocation_043 in $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/CardAcceptorNameLocation_043
                return
                    <TRANSACTION_MERCHANT>
                    { 
                    	fn-bea:trim(substring(data($CardAcceptorNameLocation_043), 1, 22)) 
                    }
                    </TRANSACTION_MERCHANT>
            }
            {
                for $MerchantType_018 in $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/MerchantType_018
                return
                    <TRANSACTION_MERCHANT_CODE>{ data($MerchantType_018) }</TRANSACTION_MERCHANT_CODE>
            }
            {
                for $ResponseCode_039 in $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/ResponseCode_039
                return
                    <TRANSACTION_STATUS>{ data($ResponseCode_039) }</TRANSACTION_STATUS>
            }
            {
                for $AuthorizationIdentificationResponse_038 in $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/AuthorizationIdentificationResponse_038
                return
                    <TRANSACTION_AUTH_CODE>{ data($AuthorizationIdentificationResponse_038) }</TRANSACTION_AUTH_CODE>
            }
            {
                for $ResponseCode_039 in $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/ResponseCode_039
                return
                    <TRANSACTION_RSP_CODE>{ data($ResponseCode_039) }</TRANSACTION_RSP_CODE>
            }
            {
                for $SystemTraceAuditNumber_011 in $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/SystemTraceAuditNumber_011
                return
                    <TRANSACTION_TRACE>{ data($SystemTraceAuditNumber_011) }</TRANSACTION_TRACE>
            }
        </ns1:notificaTransaccion>
};

declare variable $procesaMensajeGenericoSwitchFacadeRequest as element(ns0:procesaMensajeGenericoSwitchFacadeRequest) external;

xf:notificaTransaccionFacadeIn($procesaMensajeGenericoSwitchFacadeRequest)