(:: pragma bea:global-element-parameter parameter="$actualizarregistroerrorhandlingResponse" element="ns0:ActualizarregistroerrorhandlingResponse" location="../Resources/XMLSchema_1080088451.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/errorHandling/ActualizarRegistroErrorHandling/actualizarRegistroErrorHandlingHeaderOut/";

declare function xf:actualizarRegistroErrorHandlingHeaderOut($actualizarregistroerrorhandlingResponse as element(ns0:ActualizarregistroerrorhandlingResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $actualizarregistroerrorhandlingResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $actualizarregistroerrorhandlingResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $actualizarregistroerrorhandlingResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $result :=
                    for $DATETIME in $actualizarregistroerrorhandlingResponse/FICOHERRORHANDLEType/gDATETIME/DATETIME
                    return
                        <valueDate>{ concat("20",$DATETIME) }</valueDate>
                return
                    $result[1]
            }
        </ns1:ResponseHeader>
};

declare variable $actualizarregistroerrorhandlingResponse as element(ns0:ActualizarregistroerrorhandlingResponse) external;

xf:actualizarRegistroErrorHandlingHeaderOut($actualizarregistroerrorhandlingResponse)