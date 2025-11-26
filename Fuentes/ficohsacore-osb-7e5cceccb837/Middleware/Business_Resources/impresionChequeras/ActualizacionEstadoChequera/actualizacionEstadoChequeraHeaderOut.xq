(:: pragma bea:global-element-parameter parameter="$actualizaciondeestadodechequeraResponse" element="ns0:ActualizaciondeestadodechequeraResponse" location="../Resources/XMLSchema_1756805255.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/impresionChequeras/ActualizacionEstadoChequera/actualizacionEstadoChequeraHeaderOut/";

declare function xf:actualizacionEstadoChequeraHeaderOut($actualizaciondeestadodechequeraResponse as element(ns0:ActualizaciondeestadodechequeraResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $actualizaciondeestadodechequeraResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $actualizaciondeestadodechequeraResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $actualizaciondeestadodechequeraResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $DATETIME := $actualizaciondeestadodechequeraResponse/FICOHCHECKBOOKREQUESTType/gDATETIME/DATETIME[1]/text()
                	return
	                    if ( exists($DATETIME) ) then ( 
	                    	<valueDate>{ concat("20",$DATETIME) }</valueDate>
	                    ) else ()
            }            
        </ns1:ResponseHeader>
};

declare variable $actualizaciondeestadodechequeraResponse as element(ns0:ActualizaciondeestadodechequeraResponse) external;

xf:actualizacionEstadoChequeraHeaderOut($actualizaciondeestadodechequeraResponse)