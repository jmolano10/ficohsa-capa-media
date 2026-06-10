<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/Cobis/RetiroSinTD/ConsultaCuentaActiva/xsd/ConsultaCuentaActiva_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaCuentaActiva";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroCuponTD/xq/consultaCuentaCobisIn/";

declare function xf:consultaCuentaCobisIn($cuenta as xs:string,
    $moneda as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:i_DEBIT_ACCOUNT>{ $cuenta }</ns0:i_DEBIT_ACCOUNT>
            <ns0:i_CURRENCY>{ $moneda }</ns0:i_CURRENCY>
        </ns0:InputParameters>
};

declare variable $cuenta as xs:string external;
declare variable $moneda as xs:string external;

xf:consultaCuentaCobisIn($cuenta,
    $moneda)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/Cobis/RetiroSinTD/ConsultaCuentaActiva/xsd/ConsultaCuentaActiva_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/Cobis/RetiroSinTD/ConsultaCuentaActiva/xsd/ConsultaCuentaActiva_sp"/>
    </con:dependency>
</con:xqueryEntry>