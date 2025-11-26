(:: pragma bea:global-element-parameter parameter="$modificaciondedeudorResponse" element="ns0:ModificaciondedeudorResponse" location="../Resources/XMLSchema_-2146193603.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/deudoresRecaudos/modificacionDeudor/modificacionDeudorHeaderOut/";

declare function xf:modificacionDeudorHeaderOut($modificaciondedeudorResponse as element(ns0:ModificaciondedeudorResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $modificaciondedeudorResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $modificaciondedeudorResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $modificaciondedeudorResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $result :=
                    for $DATETIME in $modificaciondedeudorResponse/LATAMAGDEBTORAFFILIATIONType/gDATETIME/DATETIME
                    return
                        <valueDate>{ concat("20", $DATETIME) }</valueDate>
                return
                    $result[1]
            }
        </ns1:ResponseHeader>
};

declare variable $modificaciondedeudorResponse as element(ns0:ModificaciondedeudorResponse) external;

xf:modificacionDeudorHeaderOut($modificaciondedeudorResponse)