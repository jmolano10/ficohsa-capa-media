(:: pragma bea:global-element-parameter parameter="$registraralertaaclientebeventsResponse" element="ns0:RegistraralertaaclientebeventsResponse" location="../Resources/XMLSchema_1876963756.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ficocelAdmin/EnrolaAlertaClienteFicoAlertas/enrolaAlertaClienteFicoAlertasHeaderOut/";

declare function xf:enrolaAlertaClienteFicoAlertasHeaderOut($registraralertaaclientebeventsResponse as element(ns0:RegistraralertaaclientebeventsResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $registraralertaaclientebeventsResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $registraralertaaclientebeventsResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $registraralertaaclientebeventsResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $result :=
                    for $DATETIME in $registraralertaaclientebeventsResponse/EBALERTREQUESTType/gDATETIME/DATETIME
                    return
                        <valueDate>{ concat("20",$DATETIME) }</valueDate>
                return
                    $result[1]
            }
        </ns1:ResponseHeader>
};

declare variable $registraralertaaclientebeventsResponse as element(ns0:RegistraralertaaclientebeventsResponse) external;

xf:enrolaAlertaClienteFicoAlertasHeaderOut($registraralertaaclientebeventsResponse)