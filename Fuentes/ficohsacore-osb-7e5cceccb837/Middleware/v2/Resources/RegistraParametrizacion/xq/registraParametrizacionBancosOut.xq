(:: pragma bea:global-element-parameter parameter="$registraParametrizacionBancosResponse" element="ns1:RegistraParametrizacionBancosResponse" location="../../../BusinessServices/T24/RegistraParametrizacion/xsd/registraParametrizacion.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraParametrizacion/xq/registraParametrizacionOut/";

declare function xf:registraParametrizacionOut($registraParametrizacionBancosResponse as element(ns1:RegistraParametrizacionBancosResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $transactionId in $registraParametrizacionBancosResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $messageId in $registraParametrizacionBancosResponse/Status/messageId
                return
                    <messageId>{ data($messageId) }</messageId>
            }
            {
                for $successIndicator in $registraParametrizacionBancosResponse/Status/successIndicator
                return
                    <successIndicator>{ data(fn:upper-case($successIndicator)) }</successIndicator>
            }
            {
                for $application in $registraParametrizacionBancosResponse/Status/application
                return
                    <application>{ data($application) }</application>
            }
            {
                for $messages in $registraParametrizacionBancosResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $registraParametrizacionBancosResponse as element(ns1:RegistraParametrizacionBancosResponse) external;

xf:registraParametrizacionOut($registraParametrizacionBancosResponse)
