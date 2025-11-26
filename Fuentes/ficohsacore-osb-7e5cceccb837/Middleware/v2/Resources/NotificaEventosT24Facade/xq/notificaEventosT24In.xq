(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:notificaEventosT24" location="../../NotificaEventosT24/xsd/notificaEventosT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/notificaEventosT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaEventosT24/xq/notificaEventosT24In/";

declare function xf:notificaEventosT24In($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:notificaEventosT24) {
        <ns1:notificaEventosT24>
            <MESSAGE>{ data($procesaMensajeGenericoT24/MESSAGE) }</MESSAGE>
        </ns1:notificaEventosT24>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:notificaEventosT24In($procesaMensajeGenericoT24)