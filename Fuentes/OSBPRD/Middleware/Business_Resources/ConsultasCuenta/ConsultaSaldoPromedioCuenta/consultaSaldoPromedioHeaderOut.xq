(:: pragma bea:global-element-parameter parameter="$consultasaldopromcuentaResponse1" element="ns0:ConsultasaldopromcuentaResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaSaldoPromedioCuenta/responseHeadera/";

declare function xf:responseHeadera($consultasaldopromcuentaResponse1 as element(ns0:ConsultasaldopromcuentaResponse))
    as element(ns1:ResponseHeader) {
        let $Status := $consultasaldopromcuentaResponse1/Status
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

declare variable $consultasaldopromcuentaResponse1 as element(ns0:ConsultasaldopromcuentaResponse) external;

xf:responseHeadera($consultasaldopromcuentaResponse1)