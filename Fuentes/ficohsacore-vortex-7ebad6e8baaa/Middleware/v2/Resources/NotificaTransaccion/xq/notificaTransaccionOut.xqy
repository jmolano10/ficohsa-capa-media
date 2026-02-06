xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/Alertas/notificaTxn/xsd/notificaTxn_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:notificaTransaccionResponse" location="../xsd/notificaTransaccionTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/notificaTxn";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/notificaTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaTransaccion/xq/notificaTransaccionOut/";

declare function xf:notificaTransaccionOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:notificaTransaccionResponse) {
        <ns1:notificaTransaccionResponse>
            {
                for $PV_NOTIFICATION_REFERENCE in $outputParameters/ns0:PV_NOTIFICATION_REFERENCE
                return
                    <NOTIFICATION_REFERENCE>{ data($PV_NOTIFICATION_REFERENCE) }</NOTIFICATION_REFERENCE>
            }
        </ns1:notificaTransaccionResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:notificaTransaccionOut($outputParameters)