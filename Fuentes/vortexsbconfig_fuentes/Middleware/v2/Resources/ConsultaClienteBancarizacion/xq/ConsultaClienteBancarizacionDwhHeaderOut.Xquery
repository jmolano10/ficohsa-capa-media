<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/DataWarehouse/consultaClienteBancarizacionDwh/xsd/consultaClienteBancarizacionDwh_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaClienteBancarizacionDwh";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaClienteBancarizacion/xq/ConsultaClienteBancarizacionDwhOut/";

declare function xf:ConsultaClienteBancarizacionDwhOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        &lt;ns0:ResponseHeader>
            {
                for $Msj in $outputParameters1/ns1:Msj
                return
                    &lt;successIndicator>{ data($Msj) }&lt;/successIndicator>
            }
        &lt;/ns0:ResponseHeader>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:ConsultaClienteBancarizacionDwhOut($outputParameters1)</con:xquery>
    <con:dependency location="../../../BusinessServices/DataWarehouse/consultaClienteBancarizacionDwh/xsd/consultaClienteBancarizacionDwh_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/DataWarehouse/consultaClienteBancarizacionDwh/xsd/consultaClienteBancarizacionDwh_sp"/>
    </con:dependency>
    <con:dependency location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>