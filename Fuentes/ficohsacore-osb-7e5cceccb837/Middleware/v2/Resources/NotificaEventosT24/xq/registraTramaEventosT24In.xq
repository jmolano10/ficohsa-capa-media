(:: pragma bea:global-element-parameter parameter="$notificaEventosT24" element="ns0:notificaEventosT24" location="../xsd/notificaEventosT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/PWS/registraTramaEventoT24/xsd/registraTramaEventoT24_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/notificaEventosT24Types";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraTramaEventoT24_db";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaEventosT24/xq/registraTramaEventosT24In/";

declare function xf:registraTramaEventosT24In($notificaEventosT24 as element(ns0:notificaEventosT24))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:P_TRAMAS>{ data($notificaEventosT24/MESSAGE) }</ns1:P_TRAMAS>
        </ns1:InputParameters>
};

declare variable $notificaEventosT24 as element(ns0:notificaEventosT24) external;

xf:registraTramaEventosT24In($notificaEventosT24)