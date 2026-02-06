xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/consultaFondosPensionesClienteTypes";
(:: import schema at "../xsd/consultaFondosPensionesClienteTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../../../BusinessServices/FPC/CloudCode/Schemas/CloudCodeTypes.xsd" ::)

declare variable $response as element() (:: schema-element(ns1:clientesFondosPensionesResponse) ::) external;

declare function local:func($response as element() (:: schema-element(ns1:clientesFondosPensionesResponse) ::)) as element() (:: schema-element(ns2:consultaFondosPensionesClienteResponse) ::) {
    <ns2:consultaFondosPensionesClienteResponse>
            <ns2:CUSTOMER_ID_TYPE>{ data($response/ns1:datos/ns1:cliente/ns1:tipoIdentificacion) }</ns2:CUSTOMER_ID_TYPE>
            <ns2:CUSTOMER_ID_VALUE>{ data($response/ns1:datos/ns1:cliente/ns1:numeroIdentificacion) }</ns2:CUSTOMER_ID_VALUE>
            <ns2:CUSTOMER_CODE>{ data($response/ns1:datos/ns1:cliente/ns1:codigoCliente) }</ns2:CUSTOMER_CODE>
            <ns2:ACCOUNT_INFO>
			{
			   for $accountItem in $response/ns1:datos/ns1:cliente/ns1:cuentas
			   return
                <ns2:ACCOUNT_ITEM>
                            <ns2:ACCOUNT_NUMBER>{ data($accountItem/ns1:codigoCuenta) }</ns2:ACCOUNT_NUMBER>
                            <ns2:CURRENCY_CODE>{ data($accountItem/ns1:codigoMoneda)}</ns2:CURRENCY_CODE>
                            <ns2:CURRENCY_NAME>{ data($accountItem/ns1:nombreMoneda) }</ns2:CURRENCY_NAME>
                            <ns2:PRODUCT_CODE>{ data($accountItem/ns1:codigoLineaProducto) }</ns2:PRODUCT_CODE>
                            <ns2:PRODUCT_NAME>{ data($accountItem/ns1:nombreLineaProducto) }</ns2:PRODUCT_NAME>
                            <ns2:SUBPRODUCT_CODE>{ data($accountItem/ns1:codigoProducto) }</ns2:SUBPRODUCT_CODE>
                            <ns2:SUBPRODUCT_NAME>{ data($accountItem/ns1:nombreProducto) }</ns2:SUBPRODUCT_NAME>
                            <ns2:ACCOUNT_CODE>{ data($accountItem/ns1:alternativa) }</ns2:ACCOUNT_CODE>							                    
                </ns2:ACCOUNT_ITEM>
			}	
            </ns2:ACCOUNT_INFO>
    </ns2:consultaFondosPensionesClienteResponse>
};

local:func($response)