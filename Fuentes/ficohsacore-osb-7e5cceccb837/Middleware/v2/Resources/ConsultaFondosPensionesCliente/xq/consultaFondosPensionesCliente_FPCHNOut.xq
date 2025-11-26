(:: pragma bea:global-element-parameter parameter="$consultaFondosPensionesClienteRequest" element="ns1:consultaFondosPensionesClienteRequest" location="../xsd/consultaFondosPensionesClienteTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/FPC/consultaFondosPensionesCliente/xsd/consultaFondosPensionesClienteFPC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaFondosPensionesClienteResponse" location="../xsd/consultaFondosPensionesClienteTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaFondosPensionesClienteFPC";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaFondosPensionesClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFondosPensionesCliente/xq/consultaFondosPensionesCliente_FPCHNOut/";

declare function xf:consultaFondosPensionesCliente_FPCHNOut($consultaFondosPensionesClienteRequest as element(ns1:consultaFondosPensionesClienteRequest),
    $outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaFondosPensionesClienteResponse) {
        <ns1:consultaFondosPensionesClienteResponse>
            <ns1:CUSTOMER_ID_TYPE>{ data($consultaFondosPensionesClienteRequest/ns1:CUSTOMER_ID_TYPE) }</ns1:CUSTOMER_ID_TYPE>
            <ns1:CUSTOMER_ID_VALUE>{ data($consultaFondosPensionesClienteRequest/ns1:CUSTOMER_ID_VALUE) }</ns1:CUSTOMER_ID_VALUE>
            <ns1:CUSTOMER_CODE>{ data($consultaFondosPensionesClienteRequest/ns1:CUSTOMER_CODE) }</ns1:CUSTOMER_CODE>
            <ns1:ACCOUNT_INFO>
                {
                    for $PT_INFO_CUENTAS_ITEM in $outputParameters/ns0:PT_INFO_CUENTAS/ns0:PT_INFO_CUENTAS_ITEM
                    return
                        <ns1:ACCOUNT_ITEM>
                            <ns1:ACCOUNT_NUMBER>{ data($PT_INFO_CUENTAS_ITEM/ns0:COD_CUENTA) }</ns1:ACCOUNT_NUMBER>
                            <ns1:CURRENCY_CODE>{ data($PT_INFO_CUENTAS_ITEM/ns0:COD_MONEDA) }</ns1:CURRENCY_CODE>
                            <ns1:CURRENCY_NAME>{ data($PT_INFO_CUENTAS_ITEM/ns0:DES_MONEDA) }</ns1:CURRENCY_NAME>
                            <ns1:PRODUCT_CODE>{ data($PT_INFO_CUENTAS_ITEM/ns0:COD_PRODUCTO) }</ns1:PRODUCT_CODE>
                            <ns1:PRODUCT_NAME>{ data($PT_INFO_CUENTAS_ITEM/ns0:DES_PRODUCTO) }</ns1:PRODUCT_NAME>
                            <ns1:SUBPRODUCT_CODE>{ data($PT_INFO_CUENTAS_ITEM/ns0:COD_SUBPRODUCTO) }</ns1:SUBPRODUCT_CODE>
                            <ns1:SUBPRODUCT_NAME>{ data($PT_INFO_CUENTAS_ITEM/ns0:DES_SUBPRODUCTO) }</ns1:SUBPRODUCT_NAME>
                            <ns1:ACCOUNT_CODE>{ data($PT_INFO_CUENTAS_ITEM/ns0:PC_COD_INVERSION) }</ns1:ACCOUNT_CODE>
                        </ns1:ACCOUNT_ITEM>
                }
            </ns1:ACCOUNT_INFO>
        </ns1:consultaFondosPensionesClienteResponse>
};

declare variable $consultaFondosPensionesClienteRequest as element(ns1:consultaFondosPensionesClienteRequest) external;
declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaFondosPensionesCliente_FPCHNOut($consultaFondosPensionesClienteRequest,
    $outputParameters)
