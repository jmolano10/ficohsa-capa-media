<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/DataWarehouse/consultaClienteBancarizacionDwh/xsd/consultaClienteBancarizacionDwh_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaClienteBancarizacionDwh";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaClienteBancarizacion/xq/body/";

declare function xf:body($body as element(*))
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:Archivo_XML>{ $body }&lt;/ns0:Archivo_XML>
        &lt;/ns0:InputParameters>
};

declare variable $body as element(*) external;

xf:body($body)</con:xquery>
    <con:dependency location="../../../BusinessServices/DataWarehouse/consultaClienteBancarizacionDwh/xsd/consultaClienteBancarizacionDwh_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/DataWarehouse/consultaClienteBancarizacionDwh/xsd/consultaClienteBancarizacionDwh_sp"/>
    </con:dependency>
</con:xqueryEntry>