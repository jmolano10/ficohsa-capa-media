xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$bloqueodepasivosResponse" element="ns0:BloqueodepasivosResponse" location="../../../../Business_Resources/bloqueoCertificadoDeposito/Resources/XMLSchema_524093592.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/BloqueoCertificadoDeposito/xsd/bloqueoCertificadoDepositoHeaderOut/";

declare function xf:bloqueoCertificadoDepositoHeaderOut($bloqueodepasivosResponse as element(ns0:BloqueodepasivosResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $bloqueodepasivosResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $messageId in $bloqueodepasivosResponse/Status/messageId
                return
                    <messageId>{ data($messageId) }</messageId>
            }
            {
                for $successIndicator in $bloqueodepasivosResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $application in $bloqueodepasivosResponse/Status/application
                return
                    <application>{ data($application) }</application>
            }
            {
                for $messages in $bloqueodepasivosResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $result :=
                    for $DATETIME in $bloqueodepasivosResponse/ACLOCKEDEVENTSType/gDATETIME/DATETIME
                    return
                        <valueDate>{ concat('20', $DATETIME) }</valueDate>
                return
                    $result[1]
            }
        </ns1:ResponseHeader>
};

declare variable $bloqueodepasivosResponse as element(ns0:BloqueodepasivosResponse) external;

xf:bloqueoCertificadoDepositoHeaderOut($bloqueodepasivosResponse)