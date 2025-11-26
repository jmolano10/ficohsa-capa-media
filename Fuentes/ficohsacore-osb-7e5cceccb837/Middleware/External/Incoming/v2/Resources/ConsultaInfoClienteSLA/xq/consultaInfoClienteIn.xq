(:: pragma bea:global-element-return element="ns0:consultaClienteRequest" location="../../../../v3/BusinessServices/consultaCliente_v3/xsd/consultaClientesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/External/Incoming/v2/Resources/ConsultaInfoClienteSLA/xq/consultaInfoClienteIn/";

declare function xf:consultaInfoClienteIn($CustomerIdType as xs:string,
    $CustomerIdValue as xs:string)
    as element(ns0:consultaClienteRequest) {
        <ns0:consultaClienteRequest>
            <ns0:CUSTOMER_ID_TYPE>{ $CustomerIdType }</ns0:CUSTOMER_ID_TYPE>
            <ns0:CUSTOMER_ID_VALUE>{ $CustomerIdValue }</ns0:CUSTOMER_ID_VALUE>
        </ns0:consultaClienteRequest>
};

declare variable $CustomerIdType as xs:string external;
declare variable $CustomerIdValue as xs:string external;

xf:consultaInfoClienteIn($CustomerIdType,
    $CustomerIdValue)