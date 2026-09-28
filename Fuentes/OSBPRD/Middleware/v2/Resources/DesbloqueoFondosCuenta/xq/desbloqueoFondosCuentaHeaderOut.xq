(:: pragma bea:global-element-parameter parameter="$desbloqueodefondosdepasivosResponse" element="ns1:DesbloqueodefondosdepasivosResponse" location="../../../../Business_Resources/bloqueoPasivos/Resoruces/XMLSchema_524093592.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/DesbloqueoFondosCuenta/xq/desbloqueoFondosCuentaHeaderOut1/";

declare function xf:desbloqueoFondosCuentaHeaderOut1($desbloqueodefondosdepasivosResponse as element(ns1:DesbloqueodefondosdepasivosResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $transactionId in $desbloqueodefondosdepasivosResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $desbloqueodefondosdepasivosResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $desbloqueodefondosdepasivosResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $desbloqueodefondosdepasivosResponse as element(ns1:DesbloqueodefondosdepasivosResponse) external;

xf:desbloqueoFondosCuentaHeaderOut1($desbloqueodefondosdepasivosResponse)