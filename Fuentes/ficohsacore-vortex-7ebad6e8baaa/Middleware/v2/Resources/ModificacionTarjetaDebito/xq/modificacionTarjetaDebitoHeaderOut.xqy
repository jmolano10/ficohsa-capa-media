xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$modificacionTarjetaDebitoResponse" element="ns1:ModificacionTarjetaDebitoResponse" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/IntegrationFramework/modificacionTarjetaDebitoHeaderOut/";

declare function xf:modificacionTarjetaDebitoHeaderOut($modificacionTarjetaDebitoResponse as element(ns1:ModificacionTarjetaDebitoResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $transactionId in $modificacionTarjetaDebitoResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $messageId in $modificacionTarjetaDebitoResponse/Status/messageId
                return
                    <messageId>{ data($messageId) }</messageId>
            }
            {
                for $successIndicator in $modificacionTarjetaDebitoResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $modificacionTarjetaDebitoResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $modificacionTarjetaDebitoResponse as element(ns1:ModificacionTarjetaDebitoResponse) external;

xf:modificacionTarjetaDebitoHeaderOut($modificacionTarjetaDebitoResponse)