<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/consultaMapeoCuentaT24Citi/xsd/consultaMapeoCuentaT24Citi_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMapeoCuentaT24Citi";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidacionCuenta/xq/consultaMapeoCuentaT24CitiIn/";

declare function xf:consultaMapeoCuentaT24CitiIn($accountNumber as xs:string)
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:NUMERO_CUENTA_P>{ $accountNumber }&lt;/ns0:NUMERO_CUENTA_P>
        &lt;/ns0:InputParameters>
};

declare variable $accountNumber as xs:string external;

xf:consultaMapeoCuentaT24CitiIn($accountNumber)</con:xquery>
    <con:dependency location="../../../BusinessServices/consultaMapeoCuentaT24Citi/xsd/consultaMapeoCuentaT24Citi_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/consultaMapeoCuentaT24Citi/xsd/consultaMapeoCuentaT24Citi_sp"/>
    </con:dependency>
</con:xqueryEntry>