(:: pragma bea:global-element-return element="ns0:consultaClienteRequest" location="../../../../v3/Resources/ConsultaCliente/xsd/consultaClientesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPuntajeCredito/xq/consultaClienteIn/";

declare function xf:consultaClienteIn($customerLegalId as xs:string)
    as element(ns0:consultaClienteRequest) {
        <ns0:consultaClienteRequest>
            <ns0:CUSTOMER_ID_TYPE>{ 'LEGAL_ID' }</ns0:CUSTOMER_ID_TYPE>
            <ns0:CUSTOMER_ID_VALUE>{ $customerLegalId }</ns0:CUSTOMER_ID_VALUE>
        </ns0:consultaClienteRequest>
};

declare variable $customerLegalId as xs:string external;

xf:consultaClienteIn($customerLegalId)
