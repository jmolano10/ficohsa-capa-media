<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDetalleBloqueosTD1" element="ns1:consultaDetalleBloqueosTD" location="../../../../Business_Resources/tarjetasDebito/ConsultaDetalleBloqueosTD/consultaDetalleBloqueosTDTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/consultaDetalleBloqueosTD/xsd/consultaDetalleBloqueosTD_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetalleBloqueosTD";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleBloqueosTDTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaDetalleBloqueosTD/xq/consultaDetalleBloqueosTDIn/";

declare function xf:consultaDetalleBloqueosTDIn($consultaDetalleBloqueosTD1 as element(ns1:consultaDetalleBloqueosTD))
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:ACCOUNT_NUMBER>{ data($consultaDetalleBloqueosTD1/ACCOUNT_NUMBER) }&lt;/ns0:ACCOUNT_NUMBER>
        &lt;/ns0:InputParameters>
};

declare variable $consultaDetalleBloqueosTD1 as element(ns1:consultaDetalleBloqueosTD) external;

xf:consultaDetalleBloqueosTDIn($consultaDetalleBloqueosTD1)</con:xquery>
    <con:dependency location="../../../../Business_Resources/tarjetasDebito/ConsultaDetalleBloqueosTD/consultaDetalleBloqueosTDTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/tarjetasDebito/ConsultaDetalleBloqueosTD/consultaDetalleBloqueosTDTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKGT/consultaDetalleBloqueosTD/xsd/consultaDetalleBloqueosTD_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKGT/consultaDetalleBloqueosTD/xsd/consultaDetalleBloqueosTD_sp"/>
    </con:dependency>
</con:xqueryEntry>