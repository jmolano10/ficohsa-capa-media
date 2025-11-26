(:: pragma bea:global-element-parameter parameter="$registrodeRTEResponse" element="ns0:RegistrodeRTEResponse" location="../../xsds/RegistroRTE/XMLSchema_-102414330.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RegistrarRTE/RegistrarRTEHeaderOut/";

declare function xf:RegistrarRTEHeaderOut($registrodeRTEResponse as element(ns0:RegistrodeRTEResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $registrodeRTEResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $registrodeRTEResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $registrodeRTEResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $registrodeRTEResponse as element(ns0:RegistrodeRTEResponse) external;

xf:RegistrarRTEHeaderOut($registrodeRTEResponse)