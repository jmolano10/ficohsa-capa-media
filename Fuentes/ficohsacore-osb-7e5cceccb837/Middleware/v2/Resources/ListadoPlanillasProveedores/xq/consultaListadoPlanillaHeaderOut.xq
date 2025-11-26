(:: pragma bea:global-element-parameter parameter="$consultaListadoGrupoPlanillaResponse" element="ns1:ConsultaListadoGrupoPlanillaResponse" location="../../../../Business_Resources/listadoPlanillasProveedores/Resources/XMLSchema_596884079.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ListadoPlanillasProveedores/xq/consultaListadoPlanillaHeaderOut/";

declare function xf:consultaListadoPlanillaHeaderOut($consultaListadoGrupoPlanillaResponse as element(ns1:ConsultaListadoGrupoPlanillaResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $transactionId in $consultaListadoGrupoPlanillaResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $messageId in $consultaListadoGrupoPlanillaResponse/Status/messageId
                return
                    <messageId>{ data($messageId) }</messageId>
            }
            {
                for $successIndicator in $consultaListadoGrupoPlanillaResponse/Status/successIndicator
                return
                	if (fn:count($consultaListadoGrupoPlanillaResponse/WSPAYROLLGROUPType[1]/ZERORECORDS) = 0) then (
                    	<successIndicator>{ data($successIndicator) }</successIndicator>
                    ) else (
                    	<successIndicator>NO RECORDS</successIndicator>
                    )
            }
            {
                for $application in $consultaListadoGrupoPlanillaResponse/Status/application
                return
                    <application>{ data($application) }</application>
            }
            {
                for $messages in $consultaListadoGrupoPlanillaResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }

        </ns0:ResponseHeader>
};

declare variable $consultaListadoGrupoPlanillaResponse as element(ns1:ConsultaListadoGrupoPlanillaResponse) external;

xf:consultaListadoPlanillaHeaderOut($consultaListadoGrupoPlanillaResponse)
