(:: pragma bea:global-element-parameter parameter="$authReversionDepositosCombinadosResponse" element="ns0:AuthReversionDepositosCombinadosResponse" location="../../xsds/ReversaTransaccion2/XMLSchema_-704599497.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionPagooPrestamoHeaderOut/";

declare function xf:ReversarTransaccionPagooPrestamoHeaderOut($authReversionDepositosCombinadosResponse as element(ns0:AuthReversionDepositosCombinadosResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $authReversionDepositosCombinadosResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $authReversionDepositosCombinadosResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $authReversionDepositosCombinadosResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $result :=
                    for $DATETIME in $authReversionDepositosCombinadosResponse/TELLERFINANCIALSERVICESType/gDATETIME/DATETIME
                    return
                        <valueDate>{ concat("20", $DATETIME) }</valueDate>
                return
                    $result[1]
            }
        </ns1:ResponseHeader>
};

declare variable $authReversionDepositosCombinadosResponse as element(ns0:AuthReversionDepositosCombinadosResponse) external;

xf:ReversarTransaccionPagooPrestamoHeaderOut($authReversionDepositosCombinadosResponse)