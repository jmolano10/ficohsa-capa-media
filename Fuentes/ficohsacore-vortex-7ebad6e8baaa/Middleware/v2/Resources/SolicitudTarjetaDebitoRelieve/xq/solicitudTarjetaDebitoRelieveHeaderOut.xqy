xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$solicituddeTDconRelieveResponse" element="ns1:SolicituddeTDconRelieveResponse" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitudTarjetaDebitoRelieve/xq/solicitudTarjetaDebitoRelieveHeaderOut/";

declare function xf:solicitudTarjetaDebitoRelieveHeaderOut($solicituddeTDconRelieveResponse as element(ns1:SolicituddeTDconRelieveResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $transactionId in $solicituddeTDconRelieveResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $messageId in $solicituddeTDconRelieveResponse/Status/messageId
                return
                    <messageId>{ data($messageId) }</messageId>
            }
            {
                for $successIndicator in $solicituddeTDconRelieveResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $solicituddeTDconRelieveResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $solicituddeTDconRelieveResponse as element(ns1:SolicituddeTDconRelieveResponse) external;

xf:solicitudTarjetaDebitoRelieveHeaderOut($solicituddeTDconRelieveResponse)