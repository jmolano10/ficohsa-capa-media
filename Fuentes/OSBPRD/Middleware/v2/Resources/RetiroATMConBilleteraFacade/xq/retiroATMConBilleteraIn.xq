(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoSwitchFacadeRequest" element="ns0:procesaMensajeGenericoSwitchFacadeRequest" location="../../ProcesaMensajeGenericoSwitch/xsd/procesaMensajeGenericoSwitchFacadeTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:retiroATMConBilletera" location="../../RetiroATMConBilletera/xsd/retiroATMConBilleteraTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoSwitchFacadeTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroATMConBilleteraTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroATMConBilleteraFacade/xq/retiroATMConBilleteraIn/";

declare function xf:retiroATMConBilleteraIn($procesaMensajeGenericoSwitchFacadeRequest as element(ns0:procesaMensajeGenericoSwitchFacadeRequest))
    as element(ns1:retiroATMConBilletera) {
        <ns1:retiroATMConBilletera>
            <USER>{ substring(fn-bea:trim(data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/AdditionalDataPrivate_048)), 1, 8) }</USER>
            <PASSWORD>{ substring(fn-bea:trim(data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/AdditionalDataPrivate_048)), 9, 4) }</PASSWORD>
            <AMOUNT>{ (xs:decimal(data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/AmountTransaction_004)) div 100) }</AMOUNT>
            <CHANNEL>ATM</CHANNEL>
            <TERMINAL_ID>{ fn-bea:trim(data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/CardAcceptorTerminalIdentification_041)) }</TERMINAL_ID>
            {
                for $CurrencyCodeTransaction_049 in $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/CurrencyCodeTransaction_049
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
        </ns1:retiroATMConBilletera>
};

declare variable $procesaMensajeGenericoSwitchFacadeRequest as element(ns0:procesaMensajeGenericoSwitchFacadeRequest) external;

xf:retiroATMConBilleteraIn($procesaMensajeGenericoSwitchFacadeRequest)