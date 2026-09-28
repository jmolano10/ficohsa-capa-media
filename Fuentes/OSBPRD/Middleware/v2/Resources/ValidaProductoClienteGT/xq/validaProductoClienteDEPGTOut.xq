(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABKGT/consultaListaDepositos/xsd/consultaListaDepositosCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:validaProductoClienteResponse" location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoClienteTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaDepositosCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoClienteGT/xq/validaProductoClienteDEPGTOut/";

declare function xf:validaProductoClienteDEPGTOut($ProductNumber as xs:string,
    $outputParameters as element(ns1:OutputParameters))
    as element(ns0:validaProductoClienteResponse) {
<ns0:validaProductoClienteResponse>
    {
        for $AssetNameItem at $i in data($outputParameters/ns1:ASSET_NUMBER/ns1:ASSET_NUMBER_ITEM)
        return 
            if ($ProductNumber = $AssetNameItem) then (
				<PRODUCT_NAME>{ data($outputParameters/ns1:ASSET_NAME/ns1:ASSET_NAME_ITEM[$i]) }</PRODUCT_NAME>,
                <CURRENCY>{data($outputParameters/ns1:ASSET_CURRENCY/ns1:ASSET_NUMBER_ITEM[$i]) }</CURRENCY>
                   
            ) else ("")    
    }
</ns0:validaProductoClienteResponse>
};

declare variable $ProductNumber as xs:string external;
declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:validaProductoClienteDEPGTOut($ProductNumber,
    $outputParameters)