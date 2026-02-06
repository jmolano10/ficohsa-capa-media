xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaPasivosClienteResponse1" element="ns1:consultaPasivosClienteResponse" location="../../../../v2/Resources/ConsultaPasivosCliente/xsd/consultaPasivosClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaProductosAfiliadosBatchResponse" location="../xsd/ConsultaProductosAfiliadosBatchTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ConsultaProductosAfiliadosBatchTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ProductosAfiliados/consultaProductosAfiliados/xq/consultaPasivosClienteOut/";

declare function xf:dsddd($consultaPasivosClienteResponse1 as element(ns1:consultaPasivosClienteResponse))
    as element(ns0:consultaProductosAfiliadosBatchResponse) {
        <ns0:consultaProductosAfiliadosBatchResponse>
        {
            for $consultaPasivoResponseRecords in $consultaPasivosClienteResponse1/ns1:consultaPasivosClienteTCreditoResponseType
            return
				<ns0:PRODUCTS> 
    			{
				 for $consultaPasivoResponseRecord in $consultaPasivoResponseRecords/ns1:consultaPasivosClienteResponseRecordType
				 return            
				  	<ns0:PRODUCT>                   
				        	<ns0:DESTINATION>
				     		<ns0:COUNTRY>HN01</ns0:COUNTRY>
				    		<ns0:PRODUCT_TYPE>TRC</ns0:PRODUCT_TYPE>
							<ns0:BANK_NAME></ns0:BANK_NAME>
				        </ns0:DESTINATION> 
				        <ns0:PRODUCT_ID>{fn:concat(fn:substring(data($consultaPasivoResponseRecord/LIABILITY_NUMBER), 1, 6), 'XXXXXX', fn:substring(data($consultaPasivoResponseRecord/LIABILITY_NUMBER), 13, 4)) }</ns0:PRODUCT_ID>
				        <ns0:NAME>{ data($consultaPasivoResponseRecord//LIABILITY_CUST_NAME) }</ns0:NAME>
				        <ns0:ALIAS></ns0:ALIAS>
				        <ns0:EMAIL></ns0:EMAIL>
				        <ns0:CURRENCY>{ data($consultaPasivoResponseRecord//LIABILITY_CURRENCY_1) }</ns0:CURRENCY>
				        <ns0:PRODUCT_ID_ENCRYPT>{ data($consultaPasivoResponseRecord/LIABILITY_NUMBER) }</ns0:PRODUCT_ID_ENCRYPT>
				  	</ns0:PRODUCT>
				 }           
				</ns0:PRODUCTS>
			}        
        </ns0:consultaProductosAfiliadosBatchResponse>
};

declare variable $consultaPasivosClienteResponse1 as element(ns1:consultaPasivosClienteResponse) external;

xf:dsddd($consultaPasivosClienteResponse1)