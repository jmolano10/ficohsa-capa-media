xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$registraParametrizacionBancosACCPIResponse" element="ns1:RegistraParametrizacionBancosACCPIResponse" location="../../../BusinessServices/T24/RegistraParametrizacionBancosACCPI/xsd/registraParametrizacionBancosACCPI.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraParametrizacion/xq/RegistraParametrizacionBancosACCPIOut/";

declare function xf:RegistraParametrizacionBancosACCPIOut($registraParametrizacionBancosACCPIResponse as element(ns1:RegistraParametrizacionBancosACCPIResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $transactionId in $registraParametrizacionBancosACCPIResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $messageId in $registraParametrizacionBancosACCPIResponse/Status/messageId
                return
                    <messageId>{ data($messageId) }</messageId>
            }
            {
                for $successIndicator in $registraParametrizacionBancosACCPIResponse/Status/successIndicator
                return
                    <successIndicator>{ data(fn:upper-case($successIndicator)) }</successIndicator>
            }
            {
                for $application in $registraParametrizacionBancosACCPIResponse/Status/application
                return
                    <application>{ data($application) }</application>
            }
            {
                for $messages in $registraParametrizacionBancosACCPIResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $registraParametrizacionBancosACCPIResponse as element(ns1:RegistraParametrizacionBancosACCPIResponse) external;

xf:RegistraParametrizacionBancosACCPIOut($registraParametrizacionBancosACCPIResponse)