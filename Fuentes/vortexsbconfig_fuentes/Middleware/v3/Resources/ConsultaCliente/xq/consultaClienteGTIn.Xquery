<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/consultaCliente/xsd/consultaCliente_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCliente";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/abanksGT/consultaCliente/xq/consultaClienteIn2/";

declare function xf:consultaClienteIn2($tipoBusqueda as xs:string, $idCliente as xs:string)
    as element(ns0:InputParameters) {
    if ($tipoBusqueda = "CUSTOMER_ID") then (
        <ns0:InputParameters>
            <ns0:PV_CUSTOMER_ID>{ $idCliente }</ns0:PV_CUSTOMER_ID>
        </ns0:InputParameters>
    ) else (
        <ns0:InputParameters>
            <ns0:PV_LEGAL_ID>{ $idCliente }</ns0:PV_LEGAL_ID>
        </ns0:InputParameters>    
    )
	
};

declare variable $idCliente as xs:string external;
declare variable $tipoBusqueda as xs:string external;

xf:consultaClienteIn2($tipoBusqueda, $idCliente)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ABKGT/consultaCliente/xsd/consultaCliente_sp.xsd">
        <con:schema ref="Middleware/v3/BusinessServices/ABKGT/consultaCliente/xsd/consultaCliente_sp"/>
    </con:dependency>
</con:xqueryEntry>