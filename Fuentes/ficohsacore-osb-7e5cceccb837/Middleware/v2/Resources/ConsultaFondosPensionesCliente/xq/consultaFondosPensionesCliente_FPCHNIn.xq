(:: pragma bea:global-element-parameter parameter="$consultaFondosPensionesClienteRequest" element="ns1:consultaFondosPensionesClienteRequest" location="../xsd/consultaFondosPensionesClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/FPC/consultaFondosPensionesCliente/xsd/consultaFondosPensionesClienteFPC_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaFondosPensionesClienteFPC";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaFondosPensionesClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFondosPensionesCliente/xq/consultaFondosPensionesCliente_FPCHN/";

declare function xf:consultaFondosPensionesCliente_FPCHN($consultaFondosPensionesClienteRequest as element(ns1:consultaFondosPensionesClienteRequest))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PC_TIP_IDENTIFIC>{ data($consultaFondosPensionesClienteRequest/ns1:CUSTOMER_ID_TYPE) }</ns0:PC_TIP_IDENTIFIC>
            <ns0:PC_NUM_IDENTIFIC>{ data($consultaFondosPensionesClienteRequest/ns1:CUSTOMER_ID_VALUE) }</ns0:PC_NUM_IDENTIFIC>
            <ns0:PC_COD_PERSONA>{ data($consultaFondosPensionesClienteRequest/ns1:CUSTOMER_CODE) }</ns0:PC_COD_PERSONA>
        </ns0:InputParameters>
};

declare variable $consultaFondosPensionesClienteRequest as element(ns1:consultaFondosPensionesClienteRequest) external;

xf:consultaFondosPensionesCliente_FPCHN($consultaFondosPensionesClienteRequest)
