(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/MasterData/conConsultaCliente/xsd/conConsultaCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:validaProductoCliente" location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoClienteTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conConsultaCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoClienteHN/xq/validaProductoClienteTRCHNOut/";

declare function xf:validaProductoClienteTRCHNOut($outputParameters as element(ns1:OutputParameters),
    $customerId as xs:string,
    $country as xs:string,
    $productType as xs:string)
    as element(ns0:validaProductoClienteResponse) {
    	<ns0:validaProductoClienteResponse>
    		{
        		let $Row := $outputParameters/ns1:RowSet/ns1:Row
        		for $noTarjetaCredito in $Row//ns1:Column[fn:upper-case(@name)='CUSTOMER_ID']
        		return
        			if($customerId = $noTarjetaCredito) then (
        				<PRODUCT_NAME>{ data($Row/ns1:Column[fn:upper-case(@name)='CARDHOLDER_NAME']) }</PRODUCT_NAME>,
        				<CURRENCY>
        					{
        						if($country = 'HN01' and $productType = 'TRC') then (
        							'HNL'
        						) else ('USD')
        					}
        				</CURRENCY>
        			) else ()
        	}
        </ns0:validaProductoClienteResponse>    
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $customerId as xs:string external;
declare variable $country as xs:string external;
declare variable $productType as xs:string external;

xf:validaProductoClienteTRCHNOut($outputParameters,
    $customerId,
    $country,
    $productType)