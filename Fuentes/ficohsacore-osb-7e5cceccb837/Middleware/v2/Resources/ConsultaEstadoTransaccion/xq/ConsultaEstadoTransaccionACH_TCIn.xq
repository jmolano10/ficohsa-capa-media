xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/OperacionesACH/ConsultaEstadoTransaccionTC/xsd/ConsultaEstadoTransaccionACH_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoTransaccion/xq/ConsultaEstadoTransaccionACH_TCIn/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaEstadoTransaccionACH";

declare function xf:ConsultaEstadoTransaccionACH_TCIn()
as element(ns0:InputParameters) {
    <ns0:InputParameters/>
};


xf:ConsultaEstadoTransaccionACH_TCIn()
