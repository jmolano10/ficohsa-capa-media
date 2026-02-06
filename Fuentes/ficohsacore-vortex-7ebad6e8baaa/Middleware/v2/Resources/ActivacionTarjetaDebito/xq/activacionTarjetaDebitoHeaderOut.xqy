xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$activaciondeTarjetadeDebitoResponse" element="ns1:ActivaciondeTarjetadeDebitoResponse" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActivacionTarjetaDebito/xq/activacionTarjetaDebitoHeaderOut/";

declare function xf:activacionTarjetaDebitoHeaderOut($activaciondeTarjetadeDebitoResponse as element(ns1:ActivaciondeTarjetadeDebitoResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $transactionId in $activaciondeTarjetadeDebitoResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $messageId in $activaciondeTarjetadeDebitoResponse/Status/messageId
                return
                    <messageId>{ data($messageId) }</messageId>
            }
            {
                for $successIndicator in $activaciondeTarjetadeDebitoResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $application in $activaciondeTarjetadeDebitoResponse/Status/application
                return
                    <application>{ data($application) }</application>
            }
            {
                for $messages in $activaciondeTarjetadeDebitoResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $activaciondeTarjetadeDebitoResponse as element(ns1:ActivaciondeTarjetadeDebitoResponse) external;

xf:activacionTarjetaDebitoHeaderOut($activaciondeTarjetadeDebitoResponse)