<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/obtenerSecuencia/xsd/obtenerSecuencia_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerSecuencia";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Generales/xq/obtenerSecuenciaIn/";

declare function xf:obtenerSecuenciaIn($seed as xs:string,
    $sequenceType as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_TIPO_SECUENCIA>{ $sequenceType }</ns0:PV_TIPO_SECUENCIA>
            <ns0:PV_SEMILLA>{ $seed }</ns0:PV_SEMILLA>
        </ns0:InputParameters>
};

declare variable $seed as xs:string external;
declare variable $sequenceType as xs:string external;

xf:obtenerSecuenciaIn($seed,
    $sequenceType)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/obtenerSecuencia/xsd/obtenerSecuencia_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/obtenerSecuencia/xsd/obtenerSecuencia_sp"/>
    </con:dependency>
</con:xqueryEntry>