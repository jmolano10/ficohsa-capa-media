<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/obtenerRemesadoraNI/xsd/ObtenerRemesadora_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ObtenerRemesadora";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesa/xq/consultaInfoRemesadoraNIIn/";

declare function xf:consultaInfoRemesadoraNIIn($remitterId as xs:string,
    $userName as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_ID_CONVENIO>{ $remitterId }</ns0:PV_ID_CONVENIO>
            <ns0:PV_USUARIO_SERVICIO>{ $userName }</ns0:PV_USUARIO_SERVICIO>
        </ns0:InputParameters>
};

declare variable $remitterId as xs:string external;
declare variable $userName as xs:string external;

xf:consultaInfoRemesadoraNIIn($remitterId,
    $userName)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/MDW/obtenerRemesadoraNI/xsd/ObtenerRemesadora_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MDW/obtenerRemesadoraNI/xsd/ObtenerRemesadora_sp"/>
    </con:dependency>
</con:xqueryEntry>