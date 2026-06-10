<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../ABKPA/consultaCertificadoDeposito/xsd/consultaCertificadoDeposito_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCertificadoDeposito";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosPA/xq/consultaCertificadoDepositoIn/";

declare function xf:consultaCertificadoDepositoIn($ID as xs:string)
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:DEPOSIT_NUMBER>{ $ID }&lt;/ns0:DEPOSIT_NUMBER>
        &lt;/ns0:InputParameters>
};

declare variable $ID as xs:string external;

xf:consultaCertificadoDepositoIn($ID)</con:xquery>
    <con:dependency location="../../../ABKPA/consultaCertificadoDeposito/xsd/consultaCertificadoDeposito_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKPA/consultaCertificadoDeposito/xsd/consultaCertificadoDeposito_sp"/>
    </con:dependency>
</con:xqueryEntry>