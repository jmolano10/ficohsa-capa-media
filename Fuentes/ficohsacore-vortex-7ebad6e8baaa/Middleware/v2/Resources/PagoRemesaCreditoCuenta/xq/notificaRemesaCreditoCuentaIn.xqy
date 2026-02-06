xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:NotificaEstadoRemesaCreditoCuenta" location="../../NotificaEstadoRemesaCreditoCuenta/xsd/notificaEstadoRemesaCreditoCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/notificaEstadoRemesaCreditoCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesaCreditoCuenta/xq/notificaRemesaCreditoCuentaIn/";

declare function xf:notificaRemesaCreditoCuentaIn($Legalid as xs:string)
    as element(ns0:NotificaEstadoRemesaCreditoCuenta) {
        <ns0:NotificaEstadoRemesaCreditoCuenta>
            <LEGALID>{ $Legalid }</LEGALID>
        </ns0:NotificaEstadoRemesaCreditoCuenta>
};

declare variable $Legalid as xs:string external;

xf:notificaRemesaCreditoCuentaIn($Legalid)