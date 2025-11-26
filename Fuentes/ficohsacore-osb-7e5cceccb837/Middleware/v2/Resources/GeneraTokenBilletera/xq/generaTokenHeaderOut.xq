(:: pragma bea:global-element-parameter parameter="$HeaderResponse" element="ns1:response" location="../../../BusinessServices/TENGO/PagoMasivoBilletera/xsd/Services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://main/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraTokenBilletera/xq/generaTokenHeaderOut/";

declare function xf:generaTokenHeaderOut($HeaderResponse as element(ns1:response))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $messageID in $HeaderResponse/messageID
                return
                    <messageId>{ data($messageID) }</messageId>
            }
            {
                for $successIndicator in $HeaderResponse/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $HeaderResponse/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $HeaderResponse as element(ns1:response) external;

xf:generaTokenHeaderOut($HeaderResponse)
