(:: pragma bea:schema-type-parameter parameter="$group" type="ns1:GROUP" location="../../../../Resources/ConsultaSituacionFinanciera/xsd/sjConsultaSituacionFinancieraInterno.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../ABK/consultaSituacionFinanciera/xsd/consultaSituacionFinanciera_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSituacionFinancieraInternoHN/xq/sjConsultaSituacionFinancieraAbanksHNIn/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaSituacionFinanciera";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSituacionFinancieraInterno";

declare function xf:sjConsultaSituacionFinancieraAbanksHNIn($group as element())
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PT_CODIGO_CLIENTE>
	            {
	            	for $customer in $group/CUSTOMERS/CUSTOMER
	            	return
	                	<ns0:PT_CODIGO_CLIENTE_ITEM>{ data($customer/ID) }</ns0:PT_CODIGO_CLIENTE_ITEM>                
	            }            
            </ns0:PT_CODIGO_CLIENTE>
            <ns0:PT_TIPO_PRODUCTO_CLI>
	            {
	                for $customer in $group/CUSTOMERS/CUSTOMER
	                return
	                    <ns0:PT_TIPO_PRODUCTO_CLI_ITEM>{ data($customer/PRODUCT_TYPE) }</ns0:PT_TIPO_PRODUCTO_CLI_ITEM>                
	            }            
            </ns0:PT_TIPO_PRODUCTO_CLI>
            <ns0:PT_NUMERO_PRODUCTO>
	            {
	                for $product in  $group/PRODUCTS/PRODUCT
	                return
	                    <ns0:PT_TIPO_PRODUCTO_CLI_ITEM>{ data($product/ID) }</ns0:PT_TIPO_PRODUCTO_CLI_ITEM>                
	            }            
            </ns0:PT_NUMERO_PRODUCTO>    
            <ns0:PT_TIPO_PRODUCTO>
	            {
	                for $product in  $group/PRODUCTS/PRODUCT
	                return
	                    <ns0:PT_TIPO_PRODUCTO_ITEM>{ data($product/TYPE) }</ns0:PT_TIPO_PRODUCTO_ITEM>                
	            }            
            </ns0:PT_TIPO_PRODUCTO>
	       	<ns0:PV_REGION>HN01</ns0:PV_REGION>
        </ns0:InputParameters>
};

declare variable $group as element() external;
declare variable $count as xs:short external;

xf:sjConsultaSituacionFinancieraAbanksHNIn($group)