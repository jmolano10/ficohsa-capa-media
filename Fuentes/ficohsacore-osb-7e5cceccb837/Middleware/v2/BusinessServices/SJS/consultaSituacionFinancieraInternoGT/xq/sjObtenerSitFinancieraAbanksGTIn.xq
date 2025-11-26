(:: pragma bea:schema-type-parameter parameter="$group" type="ns0:GROUP" location="../../../../Resources/ConsultaSituacionFinanciera/xsd/sjConsultaSituacionFinancieraInterno.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../ABKGT/obtenerSitFinanciera/xsd/obtenerSitFinanciera_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSituacionFinancieraInternoGT/xq/sjObtenerSitFinancieraAbanksGTIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSituacionFinancieraInterno";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerSitFinanciera";

declare function xf:sjObtenerSitFinancieraAbanksGTIn($group as element())
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
			<ns1:PT_CODIGO_CLIENTE>
	        	{
	                for $customer in $group/CUSTOMERS/CUSTOMER
	    			return
	                    <ns1:PT_CODIGO_CLIENTE_ITEM>{ data($customer/ID) }</ns1:PT_CODIGO_CLIENTE_ITEM>
	        	} 
            </ns1:PT_CODIGO_CLIENTE>
			<ns1:PT_TIPO_PRODUCTO_CLI>
				{
				   	for $customer in $group/CUSTOMERS/CUSTOMER
					return
				    	<ns1:PT_TIPO_PRODUCTO_CLI_ITEM>{ data($customer/PRODUCT_TYPE) }</ns1:PT_TIPO_PRODUCTO_CLI_ITEM>
				} 
			</ns1:PT_TIPO_PRODUCTO_CLI>
			<ns1:PT_NUMERO_PRODUCTO>
				{
				   	for $product in $group/PRODUCTS/PRODUCT
					return
				    	<ns1:PT_TIPO_PRODUCTO_CLI_ITEM>{ data($product/ID) }</ns1:PT_TIPO_PRODUCTO_CLI_ITEM>
				} 
			</ns1:PT_NUMERO_PRODUCTO>
			<ns1:PT_TIPO_PRODUCTO>
				{
				   	for $product in $group/PRODUCTS/PRODUCT
					return
				    	<ns1:PT_TIPO_PRODUCTO_CLI_ITEM>{ data($product/TYPE) }</ns1:PT_TIPO_PRODUCTO_CLI_ITEM>
				} 
			</ns1:PT_TIPO_PRODUCTO>
			
        </ns1:InputParameters>
};

declare variable $group as element() external;

xf:sjObtenerSitFinancieraAbanksGTIn($group)
