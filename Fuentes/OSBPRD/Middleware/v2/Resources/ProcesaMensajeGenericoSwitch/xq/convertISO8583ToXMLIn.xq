(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoSwitchRequest" element="ns1:procesaMensajeGenericoSwitchRequest" location="../xsd/procesaMensajeGenericoSwitchTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:convertISO8583ToXMLRequest" location="../../../BusinessServices/Switch/iso8583ConverterMultiple/wsdl/iso8583ConverterMultiple.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/schema/iso8583ConverterMultipleTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoSwitchTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoSwitch/xq/convertISO8583ToXMLIn/";

declare function xf:convertISO8583ToXMLIn($procesaMensajeGenericoSwitchRequest as element(ns1:procesaMensajeGenericoSwitchRequest))
    as element(ns0:convertISO8583ToXMLRequest) {
        <ns0:convertISO8583ToXMLRequest>
            <messageList>
                <messageItem>
                    <message>{ data($procesaMensajeGenericoSwitchRequest/MESSAGE) }</message>
                </messageItem>
            </messageList>
        </ns0:convertISO8583ToXMLRequest>
};

declare variable $procesaMensajeGenericoSwitchRequest as element(ns1:procesaMensajeGenericoSwitchRequest) external;

xf:convertISO8583ToXMLIn($procesaMensajeGenericoSwitchRequest)