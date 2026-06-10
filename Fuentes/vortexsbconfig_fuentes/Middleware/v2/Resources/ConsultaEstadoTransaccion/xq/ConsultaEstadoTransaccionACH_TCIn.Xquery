<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/OperacionesACH/ConsultaEstadoTransaccionTC/xsd/ConsultaEstadoTransaccionACH_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoTransaccion/xq/ConsultaEstadoTransaccionACH_TCIn/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaEstadoTransaccionACH";

declare function xf:ConsultaEstadoTransaccionACH_TCIn()
as element(ns0:InputParameters) {
    &lt;ns0:InputParameters/>
};


xf:ConsultaEstadoTransaccionACH_TCIn()</con:xquery>
    <con:dependency location="../../../BusinessServices/OperacionesACH/ConsultaEstadoTransaccionTC/xsd/ConsultaEstadoTransaccionACH_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/OperacionesACH/ConsultaEstadoTransaccionTC/xsd/ConsultaEstadoTransaccionACH_sp"/>
    </con:dependency>
</con:xqueryEntry>