<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma  parameter="$request" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/actualizaCliente/xsd/actualizaCliente_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitaActualizacionDatosClienteRG/xq/actualizaClienteIn/";

declare function xf:actualizaClienteIn($request as element(*))
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:PN_ACTUALIZADATOS>{ fn-bea:serialize($request) }&lt;/ns0:PN_ACTUALIZADATOS>
        &lt;/ns0:InputParameters>
};

declare variable $request as element(*) external;

xf:actualizaClienteIn($request)</con:xquery>
    <con:dependency location="../../../BusinessServices/ABKGT/actualizaCliente/xsd/actualizaCliente_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKGT/actualizaCliente/xsd/actualizaCliente_sp"/>
    </con:dependency>
</con:xqueryEntry>