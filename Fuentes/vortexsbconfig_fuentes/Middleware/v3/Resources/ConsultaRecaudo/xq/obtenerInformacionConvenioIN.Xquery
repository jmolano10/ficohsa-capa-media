<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/obtenerInformacionConvenio/xsd/ObtenerInfomacionConvenio_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ObtenerInfomacionConvenio";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudo/xq/ObtenerInformacionConvenio/";

declare function xf:ObtenerInformacionConvenio($codContrato as xs:string,
    $codPais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_PAIS>{ $codPais }</ns0:PV_PAIS>
            <ns0:PV_CONTRATO>{ $codContrato }</ns0:PV_CONTRATO>
        </ns0:InputParameters>
};

declare variable $codContrato as xs:string external;
declare variable $codPais as xs:string external;

xf:ObtenerInformacionConvenio($codContrato,
    $codPais)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/MDW/obtenerInformacionConvenio/xsd/ObtenerInfomacionConvenio_sp.xsd">
        <con:schema ref="Middleware/v3/BusinessServices/MDW/obtenerInformacionConvenio/xsd/ObtenerInfomacionConvenio_sp"/>
    </con:dependency>
</con:xqueryEntry>