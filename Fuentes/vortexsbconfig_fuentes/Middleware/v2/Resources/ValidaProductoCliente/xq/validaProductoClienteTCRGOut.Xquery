<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/MasterData/conConsultaCliente/xsd/conConsultaCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:validaProductoClienteResponse" location="../xsd/validaProductoClienteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoClienteTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conConsultaCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoClienteGT/xq/validaProductoClienteTCRGOut/";

declare function xf:validaProductoClienteTCRGOut($outputParameters as element(ns1:OutputParameters),
	$customerId as xs:string,
	$country as xs:string,
	$productType as xs:string)
    as element(ns0:validaProductoClienteResponse) {
	    <ns0:validaProductoClienteResponse>
		    {
		        let $row := $outputParameters/ns1:RowSet/ns1:Row
		        for $noTarjetaCredito in $row//ns1:Column[fn:upper-case(@name)='CUSTOMER_ID']
		        return
		        	if($customerId = $noTarjetaCredito) then(
		                <PRODUCT_NAME>{ data($row/ns1:Column[fn:upper-case(@name)='CARDHOLDER_NAME']) }</PRODUCT_NAME>,
		                <CURRENCY>
		                	{
		                		if($country = 'GT01' and $productType = 'TRC') then(
		                			'GTQ'
		                		)else('USD')
		                	}
		                </CURRENCY>
		            ) else()
		    }
		</ns0:validaProductoClienteResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $customerId as xs:string external;
declare variable $country as xs:string external;
declare variable $productType as xs:string external;

xf:validaProductoClienteTCRGOut($outputParameters,
	$customerId,
	$country,
	$productType)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/MasterData/conConsultaCliente/xsd/conConsultaCliente_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MasterData/conConsultaCliente/xsd/conConsultaCliente_sp"/>
    </con:dependency>
    <con:dependency location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ValidaProductoCliente/xsd/validaProductoClienteTypes"/>
    </con:dependency>
</con:xqueryEntry>