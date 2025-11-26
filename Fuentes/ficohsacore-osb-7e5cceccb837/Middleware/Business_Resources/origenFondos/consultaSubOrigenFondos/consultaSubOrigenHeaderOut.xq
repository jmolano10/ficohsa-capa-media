(:: pragma bea:global-element-parameter parameter="$consultasuborigendefondosResponse1" element="ns0:ConsultasuborigendefondosResponse" location="../resources/XMLSchema_-253522267.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/origenFondos/consultaSubOrigenFondos/consultaSubOrigenHeaderOut/";

declare function xf:consultaSubOrigenHeaderOut($consultasuborigendefondosResponse1 as element(ns0:ConsultasuborigendefondosResponse))
    as element(ns1:ResponseHeader) {
        let $Status := $consultasuborigendefondosResponse1/Status
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

declare variable $consultasuborigendefondosResponse1 as element(ns0:ConsultasuborigendefondosResponse) external;

xf:consultaSubOrigenHeaderOut($consultasuborigendefondosResponse1)