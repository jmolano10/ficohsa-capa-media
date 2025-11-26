(:: pragma bea:global-element-parameter parameter="$registroderechazodechequeResponse1" element="ns0:RegistroderechazodechequeResponse" location="../resources/XMLSchema_1569843523.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/compensacion/registroRechazoCheque/registroRechazoChequeheaderOut/";

declare function xf:registroRechazoChequeheaderOut($registroderechazodechequeResponse1 as element(ns0:RegistroderechazodechequeResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $registroderechazodechequeResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $messageId in $registroderechazodechequeResponse1/Status/messageId
                return
                    <messageId>{ data($messageId) }</messageId>
            }
            {
                for $successIndicator in $registroderechazodechequeResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $application in $registroderechazodechequeResponse1/Status/application
                return
                    <application>{ data($application) }</application>
            }
            {
                for $messages in $registroderechazodechequeResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $result :=
                    for $DATETIME in $registroderechazodechequeResponse1/FICOINWARDCLEARINGType/gDATETIME/DATETIME
                    return
                        <valueDate>{ data($DATETIME) }</valueDate>
                return
                    $result[1]
            }
        </ns1:ResponseHeader>
};

declare variable $registroderechazodechequeResponse1 as element(ns0:RegistroderechazodechequeResponse) external;

xf:registroRechazoChequeheaderOut($registroderechazodechequeResponse1)