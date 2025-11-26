(:: pragma bea:global-element-parameter parameter="$bloqueodepasivosResponse1" element="ns0:BloqueodepasivosResponse" location="../Resources/XMLSchema_524093592.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/bloqueoCertificadoDeposito/bloqueoCertificadoDepositoHeaderOut/";

declare function xf:bloqueoCertificadoDepositoHeaderOut($bloqueodepasivosResponse1 as element(ns0:BloqueodepasivosResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $bloqueodepasivosResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $messageId in $bloqueodepasivosResponse1/Status/messageId
                return
                    <messageId>{ data($messageId) }</messageId>
            }
            {
                for $successIndicator in $bloqueodepasivosResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $application in $bloqueodepasivosResponse1/Status/application
                return
                    <application>{ data($application) }</application>
            }
            {
                for $messages in $bloqueodepasivosResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $result :=
                    for $DATETIME in $bloqueodepasivosResponse1/ACLOCKEDEVENTSType/gDATETIME/DATETIME
                    return
                        <valueDate>{ concat('20', $DATETIME)}</valueDate>
                return
                    $result[1]    
            }        
        </ns1:ResponseHeader>
};

declare variable $bloqueodepasivosResponse1 as element(ns0:BloqueodepasivosResponse) external;

xf:bloqueoCertificadoDepositoHeaderOut($bloqueodepasivosResponse1)