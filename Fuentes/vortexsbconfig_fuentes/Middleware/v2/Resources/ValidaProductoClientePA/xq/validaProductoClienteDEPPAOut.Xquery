<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABKPA/consultaListaDepositos/xsd/consultaListaDepositosCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:validaProductoClienteResponse" location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaDepositosCliente";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoClientePA/xq/validaProductoClienteDEPPAOut/";

declare function xf:validaProductoClienteDEPPAOut($outputParameters as element(ns1:OutputParameters),
    $productNumber as xs:string)
    as element(ns0:validaProductoClienteResponse) {
        <ns0:validaProductoClienteResponse>
        	{
	        	 for $assetNumber at $i in $outputParameters/ns1:ASSET_NUMBER/ns1:ASSET_NUMBER_ITEM/text()
	        	 	return 
		        	if ($assetNumber = $productNumber)then(
		        		<PRODUCT_NAME>{ data($outputParameters/ns1:ASSET_NAME/ns1:ASSET_NAME_ITEM[$i]) }</PRODUCT_NAME>,
		        		<CURRENCY>{ data($outputParameters/ns1:ASSET_CURRENCY/ns1:ASSET_NUMBER_ITEM[$i]) }</CURRENCY>
		        	)else()
        	}
        </ns0:validaProductoClienteResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $productNumber as xs:string external;

xf:validaProductoClienteDEPPAOut($outputParameters,
    $productNumber)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ABKPA/consultaListaDepositos/xsd/consultaListaDepositosCliente_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKPA/consultaListaDepositos/xsd/consultaListaDepositosCliente_sp"/>
    </con:dependency>
    <con:dependency location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ValidaProductoCliente/xsd/validaProductoClienteTypes"/>
    </con:dependency>
</con:xqueryEntry>