(:: pragma bea:global-element-parameter parameter="$consultadeactividadeconomicaResponse1" element="ns0:ConsultadeactividadeconomicaResponse" location="../Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaActividadEconomica/consultaActividadEconomicaHeaderOutZero/";

declare function xf:consultaActividadEconomicaHeaderOutZero($consultadeactividadeconomicaResponse1 as element(ns0:ConsultadeactividadeconomicaResponse))
    as element(ns1:ResponseHeader) {
        let $ConsultadeactividadeconomicaResponse := $consultadeactividadeconomicaResponse1
        return
            <ns1:ResponseHeader>
                {
                    for $transactionId in $ConsultadeactividadeconomicaResponse/Status/transactionId
                    return
                        <transactionId>{ data($transactionId) }</transactionId>
                }
                {
                    for $messageId in $ConsultadeactividadeconomicaResponse/Status/messageId
                    return
                        <messageId>{ data($messageId) }</messageId>
                }
                <successIndicator>NO RECORDS</successIndicator>
                {
                    for $application in $ConsultadeactividadeconomicaResponse/Status/application
                    return
                        <application>{ data($application) }</application>
                }
                {
                    for $ZERORECORDS in $ConsultadeactividadeconomicaResponse/WSECONACTIVITYLISTType[1]/ZERORECORDS
                    return
                        <messages>{ data($ZERORECORDS) }</messages>
                }
            </ns1:ResponseHeader>
};

declare variable $consultadeactividadeconomicaResponse1 as element(ns0:ConsultadeactividadeconomicaResponse) external;

xf:consultaActividadEconomicaHeaderOutZero($consultadeactividadeconomicaResponse1)