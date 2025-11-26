(:: pragma bea:global-element-parameter parameter="$consultaFondosPensionesClienteRequest" element="ns1:consultaFondosPensionesClienteRequest" location="../xsd/consultaFondosPensionesClienteTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaFondosPensionesClienteResponse" element="ns0:consultaFondosPensionesClienteResponse" location="../../../BusinessServices/FPC/getFundPensionClient12c/xsd/GetFundPensionClientTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaFondosPensionesClienteResponse" location="../xsd/consultaFondosPensionesClienteTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaFondosPensionesClienteTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaFondosPensionesClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFondosPensionesCliente/xq/getFundPensionClientHNOut/";


declare function xf:getFundPensionClientHNOut($consultaFondosPensionesClienteRequest as element(ns1:consultaFondosPensionesClienteRequest), $consultaFondosPensionesClienteResponse as element(ns0:consultaFondosPensionesClienteResponse))
    as element(ns0:consultaFondosPensionesClienteResponse) {
        <ns0:consultaFondosPensionesClienteResponse>
            <ns1:CUSTOMER_ID_TYPE>{ data($consultaFondosPensionesClienteRequest/ns1:CUSTOMER_ID_TYPE) }</ns1:CUSTOMER_ID_TYPE>
            <ns1:CUSTOMER_ID_VALUE>{ data($consultaFondosPensionesClienteRequest/ns1:CUSTOMER_ID_VALUE) }</ns1:CUSTOMER_ID_VALUE>
            <ns1:CUSTOMER_CODE>{ data($consultaFondosPensionesClienteRequest/ns1:CUSTOMER_CODE) }</ns1:CUSTOMER_CODE>
            <ns0:ACCOUNT_INFO>
			{
			   for $accountItem in $consultaFondosPensionesClienteResponse/ns0:ACCOUNT_INFO/ns0:ACCOUNT_ITEM
			   return
                <ns0:ACCOUNT_ITEM>
                            <ns0:ACCOUNT_NUMBER>{ data($accountItem/ns0:ACCOUNT_NUMBER) }</ns0:ACCOUNT_NUMBER>
                            <ns0:CURRENCY_CODE>{ data($accountItem/ns0:CURRENCY_CODE)}</ns0:CURRENCY_CODE>
                            <ns0:CURRENCY_NAME>{ data($accountItem/ns0:CURRENCY_NAME) }</ns0:CURRENCY_NAME>
                            <ns0:PRODUCT_CODE>{ data($accountItem/ns0:PRODUCT_CODE) }</ns0:PRODUCT_CODE>
                            <ns0:PRODUCT_NAME>{ data($accountItem/ns0:PRODUCT_NAME) }</ns0:PRODUCT_NAME>
                            <ns0:SUBPRODUCT_CODE>{ data($accountItem/ns0:SUBPRODUCT_CODE) }</ns0:SUBPRODUCT_CODE>
                            <ns0:SUBPRODUCT_NAME>{ data($accountItem/ns0:SUBPRODUCT_NAME) }</ns0:SUBPRODUCT_NAME>
                            <ns0:ACCOUNT_CODE>{ data($accountItem/ns0:ACCOUNT_CODE) }</ns0:ACCOUNT_CODE>							                    
                </ns0:ACCOUNT_ITEM>
			}	
            </ns0:ACCOUNT_INFO>
        </ns0:consultaFondosPensionesClienteResponse>
};

declare variable $consultaFondosPensionesClienteRequest as element(ns1:consultaFondosPensionesClienteRequest) external;
declare variable $consultaFondosPensionesClienteResponse as element(ns0:consultaFondosPensionesClienteResponse) external;

xf:getFundPensionClientHNOut($consultaFondosPensionesClienteRequest, $consultaFondosPensionesClienteResponse)