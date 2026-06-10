<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:NotificaEstadoRemesaCreditoCuenta" location="../../NotificaEstadoRemesaCreditoCuenta/xsd/notificaEstadoRemesaCreditoCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/notificaEstadoRemesaCreditoCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesaCreditoCuenta/xq/notificaRemesaCreditoCuentaIn/";

declare function xf:notificaRemesaCreditoCuentaIn($Legalid as xs:string)
    as element(ns0:NotificaEstadoRemesaCreditoCuenta) {
        &lt;ns0:NotificaEstadoRemesaCreditoCuenta>
            &lt;LEGALID>{ $Legalid }&lt;/LEGALID>
        &lt;/ns0:NotificaEstadoRemesaCreditoCuenta>
};

declare variable $Legalid as xs:string external;

xf:notificaRemesaCreditoCuentaIn($Legalid)</con:xquery>
    <con:dependency location="../../NotificaEstadoRemesaCreditoCuenta/xsd/notificaEstadoRemesaCreditoCuentaTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/NotificaEstadoRemesaCreditoCuenta/xsd/notificaEstadoRemesaCreditoCuentaTypes"/>
    </con:dependency>
</con:xqueryEntry>