<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../v2/BusinessServices/ABKGT/transaccionBancaSat/xsd/TRANSACCION_BANCASAT_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/TRANSACCION_BANCASAT";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/PagoBancaSat/xq/pagoBancaSatTransaccion/";

declare function xf:pagoBancaSatTransaccion($cuentaDebito as xs:string)
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:PN_NUMERO_CUENTA>{ data($cuentaDebito) }&lt;/ns0:PN_NUMERO_CUENTA>
        &lt;/ns0:InputParameters>
};

declare variable $cuentaDebito as xs:string external;

xf:pagoBancaSatTransaccion($cuentaDebito)</con:xquery>
    <con:dependency location="../../../v2/BusinessServices/ABKGT/transaccionBancaSat/xsd/TRANSACCION_BANCASAT_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKGT/transaccionBancaSat/xsd/TRANSACCION_BANCASAT_sp"/>
    </con:dependency>
</con:xqueryEntry>