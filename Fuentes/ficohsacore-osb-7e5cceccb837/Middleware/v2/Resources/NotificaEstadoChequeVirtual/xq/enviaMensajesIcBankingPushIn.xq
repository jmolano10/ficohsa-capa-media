(:: pragma bea:global-element-parameter parameter="$notificaEstadoChequeVirtual" element="ns0:notificaEstadoChequeVirtual" location="../xsd/notificaEstadoChequeVirtualTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:enviaMensajesIcBanking" location="../../../BusinessServices/OSB/EnviaMensajesIcBanking/xsd/XMLSchema_-314778739.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/notificaEstadoChequeVirtualTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/enviaMensajesIcBankingTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaEstadoChequeVirtual/xq/enviaMensajesIcBankingPushIn/";

declare function xf:enviaMensajesIcBankingPushIn($notificaEstadoChequeVirtual as element(ns0:notificaEstadoChequeVirtual),
    $PV_ASUNTO as xs:string,
    $PV_CUERPOINBOX as xs:string)
    as element(ns1:enviaMensajesIcBanking) {
    

        <ns1:enviaMensajesIcBanking>
            <TITLE>{ $PV_ASUNTO }</TITLE>
            <BODY>{ $PV_CUERPOINBOX }</BODY>
            <CHANNEL>{ 2 }</CHANNEL>
            <IB_USER>{ data($notificaEstadoChequeVirtual/USER_CODE) }</IB_USER>
        </ns1:enviaMensajesIcBanking>
};

declare variable $notificaEstadoChequeVirtual as element(ns0:notificaEstadoChequeVirtual) external;
declare variable $PV_ASUNTO as xs:string external;
declare variable $PV_CUERPOINBOX as xs:string external;

xf:enviaMensajesIcBankingPushIn($notificaEstadoChequeVirtual,
    $PV_ASUNTO,
    $PV_CUERPOINBOX)
