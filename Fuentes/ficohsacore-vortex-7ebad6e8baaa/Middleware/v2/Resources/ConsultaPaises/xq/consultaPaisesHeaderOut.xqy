xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadepaisesResponse1" element="ns0:ConsultadepaisesResponse" location="../../../../Business_Resources/direcciones/Resources/XMLSchema_1123420404.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPaises/xq/consultaPaisesHeaderOut/";

declare function xf:consultaPaisesHeaderOut($consultadepaisesResponse1 as element(ns0:ConsultadepaisesResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $consultadepaisesResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $messageId in $consultadepaisesResponse1/Status/messageId
                return
                    <messageId>{ data($messageId) }</messageId>
            }
            {
                for $successIndicator in $consultadepaisesResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $application in $consultadepaisesResponse1/Status/application
                return
                    <application>{ data($application) }</application>
            }
            {
                for $messages in $consultadepaisesResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadepaisesResponse1 as element(ns0:ConsultadepaisesResponse) external;

xf:consultaPaisesHeaderOut($consultadepaisesResponse1)