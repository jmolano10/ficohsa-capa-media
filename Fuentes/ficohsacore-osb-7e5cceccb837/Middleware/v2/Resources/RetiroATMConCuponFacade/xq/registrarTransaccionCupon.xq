(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoSwitchFacadeRequest1" element="ns0:procesaMensajeGenericoSwitchFacadeRequest" location="../../ProcesaMensajeGenericoSwitch/xsd/procesaMensajeGenericoSwitchFacadeTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/TENGO/RegistrarCuponATM/xsd/registraTrxCuponTengoATM_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraTrxCuponTengoATM";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoSwitchFacadeTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroATMConCuponFacade/xq/registrarTransaccionCupon/";

declare function xf:registrarTransaccionCupon($procesaMensajeGenericoSwitchFacadeRequest1 as element(ns0:procesaMensajeGenericoSwitchFacadeRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
                    <ns1:PV_RETRIEVAL_REF>{ data($procesaMensajeGenericoSwitchFacadeRequest1/ISO8583/ISO8583_XML_CONTENT/RetrievalReferenceNumber_037) }</ns1:PV_RETRIEVAL_REF>
                    <ns1:PV_TERMINAR_REFERENCE>{ data($procesaMensajeGenericoSwitchFacadeRequest1/ISO8583/ISO8583_XML_CONTENT/SystemTraceAuditNumber_011) }</ns1:PV_TERMINAR_REFERENCE>
                    <ns1:PV_TERMINAL_ID>{ data($procesaMensajeGenericoSwitchFacadeRequest1/ISO8583/ISO8583_XML_CONTENT/CardAcceptorTerminalIdentification_041) }</ns1:PV_TERMINAL_ID>
                    <ns1:PV_CUPON_ID>{ data($procesaMensajeGenericoSwitchFacadeRequest1/ISO8583/ISO8583_XML_CONTENT/AdditionalDataPrivate_048) }</ns1:PV_CUPON_ID>
                    <ns1:PV_AMOUNT>{ data($procesaMensajeGenericoSwitchFacadeRequest1/ISO8583/ISO8583_XML_CONTENT/AmountTransaction_004) }</ns1:PV_AMOUNT>
                    <ns1:PV_CURRENCY>{ data($procesaMensajeGenericoSwitchFacadeRequest1/ISO8583/ISO8583_XML_CONTENT/CurrencyCodeTransaction_049) }</ns1:PV_CURRENCY>
        </ns1:InputParameters>
};

declare variable $procesaMensajeGenericoSwitchFacadeRequest1 as element(ns0:procesaMensajeGenericoSwitchFacadeRequest) external;

xf:registrarTransaccionCupon($procesaMensajeGenericoSwitchFacadeRequest1)
