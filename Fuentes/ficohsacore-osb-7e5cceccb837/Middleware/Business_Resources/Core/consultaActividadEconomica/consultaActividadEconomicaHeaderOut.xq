(:: pragma bea:global-element-parameter parameter="$consultadeactividadeconomicaResponse1" element="ns0:ConsultadeactividadeconomicaResponse" location="../Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaActividadEconomica/consultaActividadEconomicaHeaderOut/";

declare function xf:consultaActividadEconomicaHeaderOut($consultadeactividadeconomicaResponse1 as element(ns0:ConsultadeactividadeconomicaResponse))
    as element(ns1:ResponseHeader) {
        let $Status := $consultadeactividadeconomicaResponse1/Status
        return
            <ns1:ResponseHeader>
                {
                    for $transactionId in $Status/transactionId
                    return
                        <transactionId>{ data($transactionId) }</transactionId>
                }
                {
                    for $messageId in $Status/messageId
                    return
                        <messageId>{ data($messageId) }</messageId>
                }
                {
                    for $successIndicator in $Status/successIndicator
                    return
                        <successIndicator>{ data($successIndicator) }</successIndicator>
                }
                {
                    for $application in $Status/application
                    return
                        <application>{ data($application) }</application>
                }
                {
                    for $messages in $Status/messages
                    return
                        <messages>{ data($messages) }</messages>
                }
            </ns1:ResponseHeader>
};

declare variable $consultadeactividadeconomicaResponse1 as element(ns0:ConsultadeactividadeconomicaResponse) external;

xf:consultaActividadEconomicaHeaderOut($consultadeactividadeconomicaResponse1)