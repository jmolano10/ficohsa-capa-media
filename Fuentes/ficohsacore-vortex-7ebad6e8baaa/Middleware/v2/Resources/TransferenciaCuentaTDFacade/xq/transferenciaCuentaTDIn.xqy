xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoSwitchFacadeRequest" element="ns1:procesaMensajeGenericoSwitchFacadeRequest" location="../../ProcesaMensajeGenericoSwitch/xsd/procesaMensajeGenericoSwitchFacadeTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:transferenciaCuentaTD" location="../../TransferenciaCuentaTD/xsd/transferenciaCuentaTDTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoSwitchFacadeTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciaCuentaTDTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentaTDFacade/xq/TransferenciaCuentaTDIn/";

(: Conversión moneda ISO para Lempiras y Dolares :)
declare function getISOCurrency($currency as xs:string)
	as xs:string {
		if($currency = '340') then(
			'HNL'
		) else if($currency = '840') then(
			'USD'
		)else ($currency)
};

declare function xf:TransferenciaCuentaTDIn($procesaMensajeGenericoSwitchFacadeRequest as element(ns1:procesaMensajeGenericoSwitchFacadeRequest))
    as element(ns0:transferenciaCuentaTD) {
        <ns0:transferenciaCuentaTD>
            <CARD_NUMBER>{ data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/PrimaryAccountNumber_002) }</CARD_NUMBER>
            {
            	let $CurrencyCodeTransaction_049 := fn:string($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/CurrencyCodeTransaction_049/text())
            	let $CurrencyCodeSettlement_050 := fn:string($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/CurrencyCodeSettlement_050/text())
            	return 
    				if($CurrencyCodeTransaction_049 = '340') then(
    					<AMOUNT>{ xs:decimal(data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/AmountTransaction_004)) div 100 }</AMOUNT>,
    					<CURRENCY>{ getISOCurrency($CurrencyCodeTransaction_049) }</CURRENCY>
    				)else (
	    				<AMOUNT>{ xs:decimal(data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/AmountSettlement_005)) div 100 }</AMOUNT>,
	    				<CURRENCY>{ getISOCurrency($CurrencyCodeSettlement_050) }</CURRENCY>
    			)
    		}
            <PROCESSING_CODE>{ data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/ProcessingCode_003) }</PROCESSING_CODE>
            <TERMINAL_REFERENCE>{ data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/SystemTraceAuditNumber_011) }</TERMINAL_REFERENCE>
            <RETRIEVAL_REF_NO>{ data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/RetrievalReferenceNumber_037) }</RETRIEVAL_REF_NO>
        	{
            	for $TransactionDescription_104 in $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/TransactionDescription_104
            	return
                	<ADDITIONAL_DATA>{ data($TransactionDescription_104) }</ADDITIONAL_DATA>
        	}
        </ns0:transferenciaCuentaTD>
};

declare variable $procesaMensajeGenericoSwitchFacadeRequest as element(ns1:procesaMensajeGenericoSwitchFacadeRequest) external;

xf:TransferenciaCuentaTDIn($procesaMensajeGenericoSwitchFacadeRequest)