<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ABKPA/consultaDetallesCuenta/xsd/consultaDetallesCuenta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validaProductoClienteResponse" location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validaProductoClienteTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetallesCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoClientePA/xq/validaProductoClienteCTAPAOut/";

declare function xf:validaProductoClienteCTAPAOut($customerID as xs:string,
    $outputParameters as element(ns0:OutputParameters))
    as element(ns1:validaProductoClienteResponse) {
        <ns1:validaProductoClienteResponse>
        {
        	if (data($outputParameters/ns0:CUSTOMER_ID) = $customerID)then(
	            <PRODUCT_NAME>{ data($outputParameters/ns0:ACCOUNT_NAME) }</PRODUCT_NAME>,
	            <CURRENCY>{ data($outputParameters/ns0:CURRENCY) }</CURRENCY>,
	            <OPENING_DATE>{ data($outputParameters/ns0:OPENING_DATE) }</OPENING_DATE>
            )else()
        }
        </ns1:validaProductoClienteResponse>
};

declare variable $customerID as xs:string external;
declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:validaProductoClienteCTAPAOut($customerID,
    $outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ABKPA/consultaDetallesCuenta/xsd/consultaDetallesCuenta_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKPA/consultaDetallesCuenta/xsd/consultaDetallesCuenta_sp"/>
    </con:dependency>
    <con:dependency location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ValidaProductoCliente/xsd/validaProductoClienteTypes"/>
    </con:dependency>
</con:xqueryEntry>