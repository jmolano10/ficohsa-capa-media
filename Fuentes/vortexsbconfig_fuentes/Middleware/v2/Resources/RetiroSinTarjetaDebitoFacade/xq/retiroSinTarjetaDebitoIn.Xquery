<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoSwitchFacadeRequest" element="ns0:procesaMensajeGenericoSwitchFacadeRequest" location="../../ProcesaMensajeGenericoSwitch/xsd/procesaMensajeGenericoSwitchFacadeTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:retiroCuponTD" location="../../RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroSinTarjetaDebitoTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoSwitchFacadeTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroSinTarjetaDebitoFacade/xq/retiroSinTarjetaDebitoIn/";

declare function xf:retiroSinTarjetaDebitoIn($procesaMensajeGenericoSwitchFacadeRequest as element(ns0:procesaMensajeGenericoSwitchFacadeRequest))
    as element(ns1:retiroCuponTD) {
        <ns1:retiroCuponTD>
            <OPERATION>
            {
                if (data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/MTI) = '0200') then
                    ('EXCHANGE')
                else 
                    'REVERSE'
            }
			</OPERATION>
            <TICKET_NUMBER>{ normalize-space(data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/AdditionalDataPrivate_048)) }</TICKET_NUMBER>
            <TICKET_AMOUNT>{ xs:integer(data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/AmountTransaction_004)) div 100 }</TICKET_AMOUNT>
            <TICKET_CURRENCY>{ data(xf:obtenerXMLMonedas()/CcyNtry[CcyNbr=data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/CurrencyCodeTransaction_049)]/Ccy) }</TICKET_CURRENCY>
            <WITHDRAWAL_POINT_INFORMATION>
                <TYPE>ATM</TYPE>
                <NAME>{ data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/CardAcceptorNameLocation_043) }</NAME>
                <TERMINAL_ID>{ data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/CardAcceptorTerminalIdentification_041) }</TERMINAL_ID>
                {
                    for $SystemTraceAuditNumber_011 in $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/SystemTraceAuditNumber_011
                    return
                        <TRACE>{ data($SystemTraceAuditNumber_011) }</TRACE>
                }
            </WITHDRAWAL_POINT_INFORMATION>
        </ns1:retiroCuponTD>
};
declare function xf:obtenerXMLMonedas()
    as element(*) {
		<ISO_4217 Pblshd="2017-09-22">
		   <CcyNtry>
		      <Ccy>GTQ</Ccy>
		      <CcyNbr>320</CcyNbr>
		   </CcyNtry>
		   <CcyNtry>
		      <Ccy>HNL</Ccy>
		      <CcyNbr>340</CcyNbr>
		   </CcyNtry>
		   <CcyNtry>
		      <Ccy>NIO</Ccy>
		      <CcyNbr>558</CcyNbr>
		   </CcyNtry>
		   <CcyNtry>
		      <Ccy>USD</Ccy>
		      <CcyNbr>840</CcyNbr>
		   </CcyNtry>  
		</ISO_4217>
};

declare variable $procesaMensajeGenericoSwitchFacadeRequest as element(ns0:procesaMensajeGenericoSwitchFacadeRequest) external;

xf:retiroSinTarjetaDebitoIn($procesaMensajeGenericoSwitchFacadeRequest)]]></con:xquery>
    <con:dependency location="../../ProcesaMensajeGenericoSwitch/xsd/procesaMensajeGenericoSwitchFacadeTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ProcesaMensajeGenericoSwitch/xsd/procesaMensajeGenericoSwitchFacadeTypes"/>
    </con:dependency>
    <con:dependency location="../../RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes"/>
    </con:dependency>
</con:xqueryEntry>