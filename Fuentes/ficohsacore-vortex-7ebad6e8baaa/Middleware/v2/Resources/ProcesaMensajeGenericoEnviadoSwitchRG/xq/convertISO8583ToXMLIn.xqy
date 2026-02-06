xquery version "2004-draft";
(:: pragma  parameter="$anyType1" type="xs:anyType" ::)
(:: pragma bea:global-element-return element="ns1:convertISO8583ToXMLRequest" location="../../../BusinessServices/Switch/iso8583ConverterMultiple/wsdl/iso8583ConverterMultiple.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjActualizaDatosTDSwitch";
declare namespace ns1 = "http://www.ficohsa.com.hn/schema/iso8583ConverterMultipleTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoEnviadoSwitchRG/xq/convertISO8583ToXMLIn/";

declare function xf:convertISO8583ToXMLIn($anyType as element(*),  $messageConfiguration as xs:string)
    as element(ns1:convertISO8583ToXMLRequest) {
        <ns1:convertISO8583ToXMLRequest>
        {
                <messageList>
                    {
                        for $MESAGE_ITEM in $anyType/messageList/messageItem[fn:upper-case(status) = "SUCCESS"]
                        return
                            <messageItem>
                            	<messageConfiguration>{ $messageConfiguration }</messageConfiguration>
                            	<message>{ fn:substring-before(data($MESAGE_ITEM/message), '|') }</message>
                            </messageItem>
                    }
                </messageList>
            }
        </ns1:convertISO8583ToXMLRequest>
};

declare  variable $anyType as element(*) external;
declare variable $messageConfiguration as xs:string external;

xf:convertISO8583ToXMLIn($anyType,  $messageConfiguration)