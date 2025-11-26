(:: pragma bea:global-element-parameter parameter="$consultaFondosPensionesClienteRequest" element="ns0:consultaFondosPensionesClienteRequest" location="../xsd/consultaFondosPensionesClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaFondosPensionesClienteRequest" location="../../../BusinessServices/FPC/getFundPensionClient12c/xsd/GetFundPensionClientTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaFondosPensionesClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFondosPensionesCliente/xq/getFundPensionClientIn/";

declare function xf:getFundPensionClientIn($consultaFondosPensionesClienteRequest as element(ns0:consultaFondosPensionesClienteRequest))
    as element(ns0:consultaFondosPensionesClienteRequest) {
        <ns0:consultaFondosPensionesClienteRequest>
            <ns0:CUSTOMER_ID_TYPE>{ data($consultaFondosPensionesClienteRequest/ns0:CUSTOMER_ID_TYPE) }</ns0:CUSTOMER_ID_TYPE>
            <ns0:CUSTOMER_ID_VALUE>{ data($consultaFondosPensionesClienteRequest/ns0:CUSTOMER_ID_VALUE) }</ns0:CUSTOMER_ID_VALUE>
            <ns0:CUSTOMER_CODE>{ data($consultaFondosPensionesClienteRequest/ns0:CUSTOMER_CODE) }</ns0:CUSTOMER_CODE>
        </ns0:consultaFondosPensionesClienteRequest>
};

declare variable $consultaFondosPensionesClienteRequest as element(ns0:consultaFondosPensionesClienteRequest) external;

xf:getFundPensionClientIn($consultaFondosPensionesClienteRequest)
