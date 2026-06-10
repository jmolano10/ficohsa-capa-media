<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABKGT/consultaDetallesCuenta/xsd/consultaDetallesCuenta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:validaProductoClienteResponse" location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoClienteTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaDetallesCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoClienteGT/xq/validaProductoClienteCTAGTOut/";

declare function xf:validaProductoClienteCTAGTOut($CustomerID as xs:string,
    $outputParameters as element(ns1:OutputParameters))
    as element(ns0:validaProductoClienteResponse) {
        <ns0:validaProductoClienteResponse>
        {
			if ($CustomerID = data($outputParameters/ns1:CUSTOMER_ID)) then (
	            <PRODUCT_NAME>{ data($outputParameters/ns1:ACCOUNT_NUMBER) }</PRODUCT_NAME>,
	            <CURRENCY>{ data($outputParameters/ns1:CURRENCY) }</CURRENCY>,
	            <OPENING_DATE>{ data($outputParameters/ns1:OPENING_DATE) }</OPENING_DATE>
	         
	         ) else ("") 
		}
        </ns0:validaProductoClienteResponse>
};

declare variable $CustomerID as xs:string external;
declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:validaProductoClienteCTAGTOut($CustomerID,
    $outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ABKGT/consultaDetallesCuenta/xsd/consultaDetallesCuenta_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKGT/consultaDetallesCuenta/xsd/consultaDetallesCuenta_sp"/>
    </con:dependency>
    <con:dependency location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ValidaProductoCliente/xsd/validaProductoClienteTypes"/>
    </con:dependency>
</con:xqueryEntry>