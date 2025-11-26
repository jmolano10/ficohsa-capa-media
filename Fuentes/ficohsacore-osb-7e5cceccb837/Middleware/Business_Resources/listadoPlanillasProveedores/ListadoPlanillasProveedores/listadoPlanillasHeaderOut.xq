(:: pragma bea:global-element-parameter parameter="$consultadeplanillasResponse1" element="ns0:ConsultadeplanillasResponse" location="../Resources/XMLSchema_596884079.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/listadoPlanillasProveedores/ListadoPlanillasProveedores/listadoPlanillasHeaderOut/";

declare function xf:listadoPlanillasHeaderOut($consultadeplanillasResponse1 as element(ns0:ConsultadeplanillasResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $consultadeplanillasResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $messageId in $consultadeplanillasResponse1/Status/messageId
                return
                    <messageId>{ data($messageId) }</messageId>
            }
            {
                for $successIndicator in $consultadeplanillasResponse1/Status/successIndicator
                return
                	if (fn:count($consultadeplanillasResponse1/LATAMAGPAYROLLGRPLISTType) > 0) then (
                    	<successIndicator>{ data($successIndicator) }</successIndicator>
                    ) else (
                    	<successIndicator>NO RECORDS</successIndicator>
                    )
            }
            {
                for $application in $consultadeplanillasResponse1/Status/application
                return
                    <application>{ data($application) }</application>
            }
            {
                for $messages in $consultadeplanillasResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadeplanillasResponse1 as element(ns0:ConsultadeplanillasResponse) external;

xf:listadoPlanillasHeaderOut($consultadeplanillasResponse1)