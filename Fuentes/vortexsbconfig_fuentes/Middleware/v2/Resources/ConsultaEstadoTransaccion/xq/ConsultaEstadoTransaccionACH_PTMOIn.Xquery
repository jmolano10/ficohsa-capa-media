<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaEstadoTransaccion" element="ns1:consultaEstadoTransaccion" location="../../OperacionesACH/xsd/operacionesACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/OperacionesACH/ConsultaEstadoTransaccionPrestamo/xsd/ConsultaEstadoTransaccionPrestamo_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesACHTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaEstadoTransaccionPrestamo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoTransaccion/xq/ConsultaEstadoTransaccionACH_PTMOIn/";

declare function xf:ConsultaEstadoTransaccionACH_PTMOIn($consultaEstadoTransaccion as element(ns1:consultaEstadoTransaccion))
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:GV_ACH_TICKET>{ data($consultaEstadoTransaccion/TICKET/text()) }&lt;/ns0:GV_ACH_TICKET>
        &lt;/ns0:InputParameters>
};

declare variable $consultaEstadoTransaccion as element(ns1:consultaEstadoTransaccion) external;

xf:ConsultaEstadoTransaccionACH_PTMOIn($consultaEstadoTransaccion)</con:xquery>
    <con:dependency location="../../OperacionesACH/xsd/operacionesACHTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/OperacionesACH/xsd/operacionesACHTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/OperacionesACH/ConsultaEstadoTransaccionPrestamo/xsd/ConsultaEstadoTransaccionPrestamo_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/OperacionesACH/ConsultaEstadoTransaccionPrestamo/xsd/ConsultaEstadoTransaccionPrestamo_sp"/>
    </con:dependency>
</con:xqueryEntry>