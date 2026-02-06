xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/consultaFondoPensionesTypes";
(:: import schema at "../xsd/consultaFondoPensionesTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../../../BusinessServices/FPC/CloudCode/Schemas/CloudCodeTypes.xsd" ::)

declare variable $response as element() (:: schema-element(ns1:cuentasFondosPensionesResponse) ::) external;

declare function local:func($response as element() (:: schema-element(ns1:cuentasFondosPensionesResponse) ::)) as element() (:: schema-element(ns2:consultaFondoPensionesResponse) ::) {
    <ns2:consultaFondoPensionesResponse>
            <ns2:ACCOUNT_NUMBER>{fn:data($response/ns1:datos/ns1:cuenta/ns1:codigoCuenta)}</ns2:ACCOUNT_NUMBER>
            <ns2:CUSTOMER_ID>{fn:data($response/ns1:datos/ns1:cuenta/ns1:codigoCliente)}</ns2:CUSTOMER_ID>
            <ns2:CUSTOMER_NAME>{fn:data($response/ns1:datos/ns1:cuenta/ns1:nombreCliente)}</ns2:CUSTOMER_NAME>
            <ns2:PRODUCT_CODE>{fn:data($response/ns1:datos/ns1:cuenta/ns1:codigoLineaProducto)}</ns2:PRODUCT_CODE>
            <ns2:PRODUCT_NAME>{fn:data($response/ns1:datos/ns1:cuenta/ns1:nombreProducto)}</ns2:PRODUCT_NAME>
            <ns2:SUB_PRODUCT_CODE>{fn:data($response/ns1:datos/ns1:cuenta/ns1:codigoProducto)}</ns2:SUB_PRODUCT_CODE>
            <ns2:OPENING_DATE>{fn:data($response/ns1:datos/ns1:cuenta/ns1:fechaApertura)}</ns2:OPENING_DATE>
            <ns2:FREQUENCY>{fn:data($response/ns1:datos/ns1:cuenta/ns1:frecuenciaAporte)}</ns2:FREQUENCY>
            <ns2:PAYMENT_METHOD>{fn:data($response/ns1:datos/ns1:cuenta/ns1:formaAporte)}</ns2:PAYMENT_METHOD>
            <ns2:INSURED_AMOUNT>{fn:data($response/ns1:datos/ns1:cuenta/ns1:montoAsegurado)}</ns2:INSURED_AMOUNT>            
            <ns2:CONTRIBUTION_AMOUNT>{fn:data($response/ns1:datos/ns1:cuenta/ns1:montoAporte)}</ns2:CONTRIBUTION_AMOUNT>
            <ns2:LAST_CONTRIBUTION_AMOUNT>{fn:data($response/ns1:datos/ns1:cuenta/ns1:ultimoMontoContribucion)}</ns2:LAST_CONTRIBUTION_AMOUNT>            
            <ns2:LAST_CONTRIBUTION_DATE>{fn:data($response/ns1:datos/ns1:cuenta/ns1:ultimaContribucion)}</ns2:LAST_CONTRIBUTION_DATE>
            <ns2:NEXT_CONTRIBUTION_DATE>{fn:data($response/ns1:datos/ns1:cuenta/ns1:siguienteContribucion)}</ns2:NEXT_CONTRIBUTION_DATE>
            <ns2:LAST_EXTRA_CONTRIBUTION_AMOUNT>{fn:data($response/ns1:datos/ns1:cuenta/ns1:ultimaContribucicionExtra)}</ns2:LAST_EXTRA_CONTRIBUTION_AMOUNT>
            <ns2:BENEFICIARY_INFO>
                {
                    for $beneficiary in $response/ns1:datos/ns1:cuenta/ns1:beneficiarios
                    return
                        <ns2:BENEFICIARY_ITEM>
                            <ns2:FULL_NAME>{ data($beneficiary/ns1:nombreBeneficiario) }</ns2:FULL_NAME>
                            <ns2:RELATIONSHIP>{ data($beneficiary/ns1:relacionBeneficiario) }</ns2:RELATIONSHIP>
                        </ns2:BENEFICIARY_ITEM>
                }
            </ns2:BENEFICIARY_INFO>
    </ns2:consultaFondoPensionesResponse>
};

local:func($response)