(:: pragma bea:global-element-parameter parameter="$actualizaciondetasadecambioResponse" element="ns0:ActualizaciondetasadecambioResponse" location="../Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/actualizacionTasaCambio/actualizacionTasaCambioHeaderOut/";

declare function xf:actualizacionTasaCambioHeaderOut($actualizaciondetasadecambioResponse as element(ns0:ActualizaciondetasadecambioResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $actualizaciondetasadecambioResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $actualizaciondetasadecambioResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $actualizaciondetasadecambioResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $result :=
                    for $DATETIME in $actualizaciondetasadecambioResponse/CURRENCYType/gDATETIME/DATETIME
                    return
                        <valueDate>{ concat("20", $DATETIME) }</valueDate>
                return
                    $result[1]
            }
        </ns1:ResponseHeader>
};

declare variable $actualizaciondetasadecambioResponse as element(ns0:ActualizaciondetasadecambioResponse) external;

xf:actualizacionTasaCambioHeaderOut($actualizaciondetasadecambioResponse)