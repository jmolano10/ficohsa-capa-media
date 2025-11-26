(:: pragma bea:global-element-parameter parameter="$consultadebancoslocalesResponse1" element="ns0:ConsultadebancoslocalesResponse" location="../Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaBancosLocales/consultaBancosLocalesHeaderOut/";

declare function xf:consultaBancosLocalesHeaderOut($consultadebancoslocalesResponse1 as element(ns0:ConsultadebancoslocalesResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $consultadebancoslocalesResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $messageId in $consultadebancoslocalesResponse1/Status/messageId
                return
                    <messageId>{ data($messageId) }</messageId>
            }
            {
                for $successIndicator in $consultadebancoslocalesResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $application in $consultadebancoslocalesResponse1/Status/application
                return
                    <application>{ data($application) }</application>
            }
            {
                for $messages in $consultadebancoslocalesResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadebancoslocalesResponse1 as element(ns0:ConsultadebancoslocalesResponse) external;

xf:consultaBancosLocalesHeaderOut($consultadebancoslocalesResponse1)