<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/consultaMaestraSaldoCuenta/xsd/consultaMaestraSaldoCuenta_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMaestraSaldoCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMaestraSaldoCuentas/xq/consultaMaestraSaldoCuentaGTIn/";

declare function xf:consultaMaestraSaldoCuentaGTIn($accNumber as xs:string)
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:PV_ACCOUNT_NUMBER>{ $accNumber }&lt;/ns0:PV_ACCOUNT_NUMBER>
        &lt;/ns0:InputParameters>
};

declare variable $accNumber as xs:string external;

xf:consultaMaestraSaldoCuentaGTIn($accNumber)</con:xquery>
    <con:dependency location="../../../BusinessServices/ABKGT/consultaMaestraSaldoCuenta/xsd/consultaMaestraSaldoCuenta_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKGT/consultaMaestraSaldoCuenta/xsd/consultaMaestraSaldoCuenta_sp"/>
    </con:dependency>
</con:xqueryEntry>