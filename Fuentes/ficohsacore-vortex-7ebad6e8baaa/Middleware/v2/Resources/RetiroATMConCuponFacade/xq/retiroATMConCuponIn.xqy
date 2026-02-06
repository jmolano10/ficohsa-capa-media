xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoSwitchFacadeRequest" element="ns0:procesaMensajeGenericoSwitchFacadeRequest" location="../../ProcesaMensajeGenericoSwitch/xsd/procesaMensajeGenericoSwitchFacadeTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:retiroATMConCupon" location="../../RetiroATMConCupon/xsd/retiroATMConCuponTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoSwitchFacadeTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroATMConCuponTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroATMConCuponFacade/xq/retiroATMConCuponIn/";

declare function xf:retiroATMConCuponIn($procesaMensajeGenericoSwitchFacadeRequest as element(ns0:procesaMensajeGenericoSwitchFacadeRequest))
    as element(ns1:retiroATMConCupon) {
        <ns1:retiroATMConCupon>
            <AMOUNT>{ (xs:decimal(data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/AmountTransaction_004)) div 100) }</AMOUNT>
            {
                for $AdditionalDataPrivate_048 in $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/AdditionalDataPrivate_048
                return
                    <COUPON_ID>{ data($AdditionalDataPrivate_048) }</COUPON_ID>
            }
            <TERMINAL_ID>{ fn-bea:trim(data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/CardAcceptorTerminalIdentification_041)) }</TERMINAL_ID>
            <CHANNEL>ATM</CHANNEL>
            {
                for $CurrencyCodeTransaction_049 in data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/CurrencyCodeTransaction_049)
                return
                    <CURRENCY>
                    { 
                    	if($CurrencyCodeTransaction_049 = '340') then(
                    		'HNL'
                    	) else if($CurrencyCodeTransaction_049 = '840') then(
                    		'USD'
                    	)else ('')
                    }
                    </CURRENCY>
            }
            {
                for $SystemTraceAuditNumber_011 in $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/SystemTraceAuditNumber_011
                return
                    <TERMINAL_REFERENCE>{ data($SystemTraceAuditNumber_011) }</TERMINAL_REFERENCE>
            }
            <RETRIEVAL_REF_NUMBER>{ data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/RetrievalReferenceNumber_037) }</RETRIEVAL_REF_NUMBER>
        </ns1:retiroATMConCupon>
};

declare variable $procesaMensajeGenericoSwitchFacadeRequest as element(ns0:procesaMensajeGenericoSwitchFacadeRequest) external;

xf:retiroATMConCuponIn($procesaMensajeGenericoSwitchFacadeRequest)