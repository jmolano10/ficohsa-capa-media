(:: pragma bea:global-element-parameter parameter="$autorizaeliminardeudorResponse" element="ns0:AutorizaeliminardeudorResponse" location="../Resources/XMLSchema_-2146193603.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/deudoresRecaudos/eliminarDeudores/eliminarDeudorHeaderOut/";

declare function xf:eliminarDeudorHeaderOut($autorizaeliminardeudorResponse as element(ns0:AutorizaeliminardeudorResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $autorizaeliminardeudorResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $autorizaeliminardeudorResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $autorizaeliminardeudorResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $DATETIME in $autorizaeliminardeudorResponse/LATAMAGDEBTORAFFILIATIONType/gDATETIME/DATETIME
                    return
                    	if ( exists($DATETIME/text()) ) then (
                        	<valueDate>{ concat("20",$DATETIME) }</valueDate>
                        ) else ()
            }
        </ns1:ResponseHeader>
};

declare variable $autorizaeliminardeudorResponse as element(ns0:AutorizaeliminardeudorResponse) external;

xf:eliminarDeudorHeaderOut($autorizaeliminardeudorResponse)