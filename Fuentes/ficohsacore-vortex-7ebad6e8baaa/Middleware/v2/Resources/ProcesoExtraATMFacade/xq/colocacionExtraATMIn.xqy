xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoSwitchFacadeRequest" element="ns0:procesaMensajeGenericoSwitchFacadeRequest" location="../../ProcesaMensajeGenericoSwitch/xsd/procesaMensajeGenericoSwitchFacadeTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:colocacionExtraATMRequest" location="../../ColocacionExtraATM/xsd/colocacionExtraATMTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/colocacionExtraATMTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoSwitchFacadeTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesoExtraATMFacade/xq/colocacionExtraATMIn/";

declare function xf:colocacionExtraATMIn($procesaMensajeGenericoSwitchFacadeRequest as element(ns0:procesaMensajeGenericoSwitchFacadeRequest))
    as element(ns1:colocacionExtraATMRequest) {
        <ns1:colocacionExtraATMRequest>
            <DEBIT_CARD>{ data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/PrimaryAccountNumber_002) }</DEBIT_CARD>
            <ATM_ID>{ data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/CardAcceptorTerminalIdentification_041) }</ATM_ID>
            <ATM_NAME>{ data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/CardAcceptorNameLocation_043) }</ATM_NAME>
            <TRACE_ID>{ data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/SystemTraceAuditNumber_011) }</TRACE_ID>
        </ns1:colocacionExtraATMRequest>
};

declare variable $procesaMensajeGenericoSwitchFacadeRequest as element(ns0:procesaMensajeGenericoSwitchFacadeRequest) external;

xf:colocacionExtraATMIn($procesaMensajeGenericoSwitchFacadeRequest)