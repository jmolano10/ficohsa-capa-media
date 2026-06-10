<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ProcesosHN/conInfoLealtad/xsd/conInfoLealtad_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conInfoLealtad";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversionPuntosLealtad/xq/conInfoLealtadIn/";

declare function xf:conInfoLealtadIn($country as xs:string,
    $cardNumber as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:NumeroTarjeta>{ $cardNumber }</ns0:NumeroTarjeta>
            <ns0:Pais>{ $country }</ns0:Pais>
        </ns0:InputParameters>
};

declare variable $country as xs:string external;
declare variable $cardNumber as xs:string external;

xf:conInfoLealtadIn($country,
    $cardNumber)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ProcesosHN/conInfoLealtad/xsd/conInfoLealtad_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ProcesosHN/conInfoLealtad/xsd/conInfoLealtad_sp"/>
    </con:dependency>
</con:xqueryEntry>