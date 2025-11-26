(:: pragma bea:global-element-parameter parameter="$afiliaciondedeudoresResponse" element="ns0:AfiliaciondedeudoresResponse" location="../Resources/XMLSchema_-2146193603.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/deudoresRecaudos/afiliacionDeudores/afiliacionDeudoresHeaderOut/";

declare function xf:afiliacionDeudoresHeaderOut($afiliaciondedeudoresResponse as element(ns0:AfiliaciondedeudoresResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $afiliaciondedeudoresResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $afiliaciondedeudoresResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $afiliaciondedeudoresResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $result :=
                    for $DATETIME in $afiliaciondedeudoresResponse/LATAMAGDEBTORAFFILIATIONType/gDATETIME/DATETIME
                    return
	                    if(exists($DATETIME/text())) then(
	                    <valueDate>{ concat("20",data($DATETIME)) }</valueDate>
	                    )
	                    else(<valueDate></valueDate>)
                return
                    $result[1]
            }
        </ns1:ResponseHeader>
};

declare variable $afiliaciondedeudoresResponse as element(ns0:AfiliaciondedeudoresResponse) external;

xf:afiliacionDeudoresHeaderOut($afiliaciondedeudoresResponse)