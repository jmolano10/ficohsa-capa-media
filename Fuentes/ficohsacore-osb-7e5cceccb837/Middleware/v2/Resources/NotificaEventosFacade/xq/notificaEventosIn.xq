(:: pragma bea:global-element-parameter parameter="$notificaEventosFacade" element="ns1:notificaEventosFacade" location="../xsd/notificaEventosFacadeTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:notificaEventosT24" location="../../NotificaEventosT24/xsd/notificaEventosT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/notificaEventosT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/notificaEventosFacadeTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaEventosFacade/xq/notificaEventosIn/";

declare function xf:notificaEventosIn($notificaEventosFacade as element(ns1:notificaEventosFacade))
    as element(ns0:notificaEventosT24) {
        <ns0:notificaEventosT24>
            <MESSAGE>{ data($notificaEventosFacade/MESSAGE) }</MESSAGE>
        </ns0:notificaEventosT24>
};

declare variable $notificaEventosFacade as element(ns1:notificaEventosFacade) external;

xf:notificaEventosIn($notificaEventosFacade)