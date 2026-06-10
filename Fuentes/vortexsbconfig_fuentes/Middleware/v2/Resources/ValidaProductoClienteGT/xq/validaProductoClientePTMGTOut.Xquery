<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABKGT/consultaPasivosCliente/xsd/consultaPasivosCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:validaProductoClienteResponse" location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoClienteTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaPasivosCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoClienteGT/xq/validaProductoClientePTMGTOut/";

declare function xf:validaProductoClientePTMGTOut($ProductName as xs:string,
    $OpeningDate as xs:string,
    $outputParameters as element(ns1:OutputParameters))
    as element(ns0:validaProductoClienteResponse) {
<ns0:validaProductoClienteResponse>
	{
		for $LiabilityNumber at $i in $outputParameters/ns1:LIABILITY_NUMBER/ns1:LIABILITY_NUMBER_ITEM
		return 
			if ($ProductName = $LiabilityNumber) then (
				<PRODUCT_NAME>{ data($outputParameters/ns1:LIABILITY_CUST_NAME/ns1:LIABILITY_CUST_NAME_ITEM[$i]) }</PRODUCT_NAME>,
				<CURRENCY>{data($outputParameters/ns1:LIABILITY_CURRENCY_1/ns1:LIABILITY_NUMBER_ITEM[$i]) }</CURRENCY>,
				<OPENING_DATE>{ $OpeningDate }</OPENING_DATE>        
			
			) else ("")    
	}
</ns0:validaProductoClienteResponse>
};

declare variable $ProductName as xs:string external;
declare variable $OpeningDate as xs:string external;
declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:validaProductoClientePTMGTOut($ProductName,
    $OpeningDate,
    $outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ABKGT/consultaPasivosCliente/xsd/consultaPasivosCliente_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKGT/consultaPasivosCliente/xsd/consultaPasivosCliente_sp"/>
    </con:dependency>
    <con:dependency location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ValidaProductoCliente/xsd/validaProductoClienteTypes"/>
    </con:dependency>
</con:xqueryEntry>