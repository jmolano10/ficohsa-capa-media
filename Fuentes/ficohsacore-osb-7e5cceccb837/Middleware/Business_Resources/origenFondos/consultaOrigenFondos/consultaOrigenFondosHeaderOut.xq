(:: pragma bea:global-element-parameter parameter="$consultadeorigendefondosResponse1" element="ns0:ConsultadeorigendefondosResponse" location="../resources/XMLSchema_-253522267.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/origenFondos/consultaOrigenFondos/consultaOrigenFondosHeaderOut/";

declare function xf:consultaOrigenFondosHeaderOut($consultadeorigendefondosResponse1 as element(ns0:ConsultadeorigendefondosResponse))
    as element(ns1:ResponseHeader) {
        let $Status := $consultadeorigendefondosResponse1/Status
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

declare variable $consultadeorigendefondosResponse1 as element(ns0:ConsultadeorigendefondosResponse) external;

xf:consultaOrigenFondosHeaderOut($consultadeorigendefondosResponse1)