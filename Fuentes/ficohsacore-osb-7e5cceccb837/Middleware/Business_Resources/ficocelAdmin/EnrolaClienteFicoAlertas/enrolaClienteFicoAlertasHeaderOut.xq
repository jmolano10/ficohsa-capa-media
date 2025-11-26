(:: pragma bea:global-element-parameter parameter="$registrarclienteenbusinesseventResponse" element="ns0:RegistrarclienteenbusinesseventResponse" location="../Resources/XMLSchema_1876963756.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ficocelAdmin/EnrolaClienteFicoAlertas/enrolaClienteFicoAlertasHeaderOut/";

declare function xf:enrolaClienteFicoAlertasHeaderOut($registrarclienteenbusinesseventResponse as element(ns0:RegistrarclienteenbusinesseventResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $registrarclienteenbusinesseventResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $registrarclienteenbusinesseventResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $registrarclienteenbusinesseventResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $result :=
                    for $DATETIME in $registrarclienteenbusinesseventResponse/DECUSTOMERPREFERENCESType/gDATETIME/DATETIME
                    return
                        <valueDate>{ concat("20",$DATETIME) }</valueDate>
                return
                    $result[1]
            }
        </ns1:ResponseHeader>
};

declare variable $registrarclienteenbusinesseventResponse as element(ns0:RegistrarclienteenbusinesseventResponse) external;

xf:enrolaClienteFicoAlertasHeaderOut($registrarclienteenbusinesseventResponse)