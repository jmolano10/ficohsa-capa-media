<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:desbloqueoFondosCuenta" location="../../DesbloqueoFondosCuenta/xsd/desbloqueoFondosCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/desbloqueoFondosCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarFinanciamiento/xq/desbloqueoFondosCuentasIn/";

declare function xf:desbloqueoFondosCuentasIn($id as xs:string)
    as element(ns0:desbloqueoFondosCuenta) {
        &lt;ns0:desbloqueoFondosCuenta>
            &lt;LOCK_ID>{ $id }&lt;/LOCK_ID>
        &lt;/ns0:desbloqueoFondosCuenta>
};

declare variable $id as xs:string external;

xf:desbloqueoFondosCuentasIn($id)</con:xquery>
    <con:dependency location="../../DesbloqueoFondosCuenta/xsd/desbloqueoFondosCuentaTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/DesbloqueoFondosCuenta/xsd/desbloqueoFondosCuentaTypes"/>
    </con:dependency>
</con:xqueryEntry>