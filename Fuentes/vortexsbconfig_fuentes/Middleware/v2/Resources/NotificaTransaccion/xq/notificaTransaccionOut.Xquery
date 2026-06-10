<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/Alertas/notificaTxn/xsd/notificaTxn_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:notificaTransaccionResponse" location="../xsd/notificaTransaccionTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/notificaTxn";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/notificaTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaTransaccion/xq/notificaTransaccionOut/";

declare function xf:notificaTransaccionOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:notificaTransaccionResponse) {
        &lt;ns1:notificaTransaccionResponse>
            {
                for $PV_NOTIFICATION_REFERENCE in $outputParameters/ns0:PV_NOTIFICATION_REFERENCE
                return
                    &lt;NOTIFICATION_REFERENCE>{ data($PV_NOTIFICATION_REFERENCE) }&lt;/NOTIFICATION_REFERENCE>
            }
        &lt;/ns1:notificaTransaccionResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:notificaTransaccionOut($outputParameters)</con:xquery>
    <con:dependency location="../../../BusinessServices/Alertas/notificaTxn/xsd/notificaTxn_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/Alertas/notificaTxn/xsd/notificaTxn_sp"/>
    </con:dependency>
    <con:dependency location="../xsd/notificaTransaccionTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/NotificaTransaccion/xsd/notificaTransaccionTypes"/>
    </con:dependency>
</con:xqueryEntry>