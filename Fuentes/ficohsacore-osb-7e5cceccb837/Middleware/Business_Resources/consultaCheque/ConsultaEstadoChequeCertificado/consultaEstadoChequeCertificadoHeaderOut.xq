(:: pragma bea:global-element-parameter parameter="$consultadechqcertificadoResponse" element="ns0:ConsultadechqcertificadoResponse" location="../Resources/XMLSchema_1194496794.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCheque/ConsultaEstadoChequeCertificado/consultaEstadoChequeCertificadoHeaderOut/";

declare function xf:consultaEstadoChequeCertificadoHeaderOut($consultadechqcertificadoResponse as element(ns0:ConsultadechqcertificadoResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $consultadechqcertificadoResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $messageId in $consultadechqcertificadoResponse/Status/messageId
                return
                    <messageId>{ data($messageId) }</messageId>
            }
            {
                for $successIndicator in $consultadechqcertificadoResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $application in $consultadechqcertificadoResponse/Status/application
                return
                    <application>{ data($application) }</application>
            }
            {
                for $messages in $consultadechqcertificadoResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadechqcertificadoResponse as element(ns0:ConsultadechqcertificadoResponse) external;

xf:consultaEstadoChequeCertificadoHeaderOut($consultadechqcertificadoResponse)