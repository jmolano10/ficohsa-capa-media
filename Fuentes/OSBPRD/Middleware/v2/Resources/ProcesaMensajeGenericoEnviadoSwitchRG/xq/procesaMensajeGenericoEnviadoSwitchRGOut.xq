(:: pragma bea:global-element-parameter parameter="$convertISO8583ToXMLResponse" element="ns0:convertISO8583ToXMLResponse" location="../../../BusinessServices/Switch/iso8583ConverterMultiple/wsdl/iso8583ConverterMultiple.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:procesaMensajeGenericoEnviadoSwitchResponse" location="../../ProcesaMensajeGenericoEnviadoSwitch/xsd/procesaMensajeGenericoEnviadoSwitchTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/schema/iso8583ConverterMultipleTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoEnviadoSwitchTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoEnviadoSwitchRG/xq/procesaMensajeGenericoEnviadoSwitchRGOut/";

declare function xf:procesaMensajeGenericoEnviadoSwitchRGOut($convertISO8583ToXMLResponse as element(ns0:convertISO8583ToXMLResponse))
    as element(ns1:procesaMensajeGenericoEnviadoSwitchResponse) {
        <ns1:procesaMensajeGenericoEnviadoSwitchResponse>
            {
                <MESSAGE_DATA>
                    {
                        for $iso8583Item in $convertISO8583ToXMLResponse/iso8583/iso8583Item
                        return
                            <MESSAGE_DATA_ITEM>
                                {
                                    let $headerMessageDetails := $iso8583Item/headerMessageDetails
                                    return
                                        <HEADER_MESSAGE_DETAILS>
                                            {
                                                for $item in $headerMessageDetails/item
                                                return
                                                    <ITEM>
                                                        <KEY>{ data($item/key) }</KEY>
                                                        <VALUE>{ data($item/value) }</VALUE>
                                                    </ITEM>
                                            }
                                        </HEADER_MESSAGE_DETAILS>
                                }
                                {
                                    let $bodyMessageDetails := $iso8583Item/bodyMessageDetails
                                    return
                                        <BODY_MESSAGE_DETAILS>
                                            {
                                                for $item in $bodyMessageDetails/item
                                                return
                                                    <ITEM>
                                                        <KEY>{ data($item/key) }</KEY>
                                                        <VALUE>{ data($item/value) }</VALUE>
                                                    </ITEM>
                                            }
                                        </BODY_MESSAGE_DETAILS>
                                }
                            </MESSAGE_DATA_ITEM>
                    }
                </MESSAGE_DATA>
            }
        </ns1:procesaMensajeGenericoEnviadoSwitchResponse>
};

declare variable $convertISO8583ToXMLResponse as element(ns0:convertISO8583ToXMLResponse) external;

xf:procesaMensajeGenericoEnviadoSwitchRGOut($convertISO8583ToXMLResponse)