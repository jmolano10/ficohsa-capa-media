<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$obtenerDatosContrato1" element="ns1:obtenerDatosContrato" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/DEI/obtenerDatosContrato/xsd/ObtenerDatosContrato_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ObtenerDatosContrato";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ObtenerDatosContrato/xq/ObtenerDatosContratoIn/";

declare function xf:ObtenerDatosContratoIn($obtenerDatosContrato1 as element(ns1:obtenerDatosContrato))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_RTN>{ data($obtenerDatosContrato1/RTN) }</ns0:PV_RTN>
            <ns0:PV_NUMEROCONTRATO>{ data($obtenerDatosContrato1/CONTRACT_NUMBER) }</ns0:PV_NUMEROCONTRATO>
        </ns0:InputParameters>
};

declare variable $obtenerDatosContrato1 as element(ns1:obtenerDatosContrato) external;

xf:ObtenerDatosContratoIn($obtenerDatosContrato1)]]></con:xquery>
    <con:dependency location="../../TributosDEI/xsd/tributosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/TributosDEI/xsd/tributosTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/DEI/obtenerDatosContrato/xsd/ObtenerDatosContrato_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/DEI/obtenerDatosContrato/xsd/ObtenerDatosContrato_sp"/>
    </con:dependency>
</con:xqueryEntry>