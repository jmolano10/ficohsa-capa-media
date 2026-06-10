<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:EvaluaCuentaAbanksTypeRequest" location="../../../BusinessServices/EvaluaCuentaAbanks/xsd/EvaluaCuentaAbanks.xsd" ::)

declare namespace ns0 = "EvaluaCuentaAbanks";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/validacionCuenta/ValidacionCuenta2.0/EvaluarCuentaAbanksIn/";

declare function xf:EvaluarCuentaAbanksIn($accountNumber as xs:string)
    as element(ns0:EvaluaCuentaAbanksTypeRequest) {
        &lt;ns0:EvaluaCuentaAbanksTypeRequest>
            &lt;ns0:ACCOUNT_ID>{ $accountNumber }&lt;/ns0:ACCOUNT_ID>
        &lt;/ns0:EvaluaCuentaAbanksTypeRequest>
};

declare variable $accountNumber as xs:string external;

xf:EvaluarCuentaAbanksIn($accountNumber)</con:xquery>
    <con:dependency location="../../../BusinessServices/EvaluaCuentaAbanks/xsd/EvaluaCuentaAbanks.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/EvaluaCuentaAbanks/xsd/EvaluaCuentaAbanks"/>
    </con:dependency>
</con:xqueryEntry>