xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoEnviadoSwitch" element="ns1:procesaMensajeGenericoEnviadoSwitch" location="../../ProcesaMensajeGenericoEnviadoSwitch/xsd/procesaMensajeGenericoEnviadoSwitchTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:convertXMLToISO8583Request" location="../../../BusinessServices/Switch/iso8583ConverterMultiple/wsdl/iso8583ConverterMultiple.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/schema/iso8583ConverterMultipleTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoEnviadoSwitchTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoEnviadoSwitchRG/xq/convertXMLToISO8583In/";

declare function xf:convertXMLToISO8583In($procesaMensajeGenericoEnviadoSwitch as element(ns1:procesaMensajeGenericoEnviadoSwitch),
    $messageConfiguration as xs:string)
    as element(ns0:convertXMLToISO8583Request) {
        <ns0:convertXMLToISO8583Request>
            <iso8583>
                {
                    for $MESSAGE_DATA_ITEM in $procesaMensajeGenericoEnviadoSwitch/MESSAGE_DATA/MESSAGE_DATA_ITEM
                    return
                        <iso8583Item>
                            <messageConfiguration>{ $messageConfiguration }</messageConfiguration>
                            {
                                let $HEADER_MESSAGE_DETAILS := $MESSAGE_DATA_ITEM/HEADER_MESSAGE_DETAILS
                                return
                                    <headerMessageDetails>
                                        {
                                            for $ITEM in $HEADER_MESSAGE_DETAILS/ITEM
                                            return
                                                <item>
                                                    <key>{ data($ITEM/KEY) }</key>
                                                    <value>{ data($ITEM/VALUE) }</value>
                                                </item>
                                        }
                                    </headerMessageDetails>
                            }
                            {
                                let $BODY_MESSAGE_DETAILS := $MESSAGE_DATA_ITEM/BODY_MESSAGE_DETAILS
                                return
                                    <bodyMessageDetails>
                                        {
                                            for $ITEM in $BODY_MESSAGE_DETAILS/ITEM
                                            return
                                                <item>
                                                    <key>{ data($ITEM/KEY) }</key>
                                                    <value>{ data($ITEM/VALUE) }</value>
                                                </item>
                                        }
                                    </bodyMessageDetails>
                            }
                        </iso8583Item>
                }
            </iso8583>
        </ns0:convertXMLToISO8583Request>
};

declare variable $procesaMensajeGenericoEnviadoSwitch as element(ns1:procesaMensajeGenericoEnviadoSwitch) external;
declare variable $messageConfiguration as xs:string external;

xf:convertXMLToISO8583In($procesaMensajeGenericoEnviadoSwitch,
    $messageConfiguration)