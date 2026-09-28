(:: pragma bea:global-element-return element="ns0:consultaClienteRequest" location="../../../../v3/Resources/ConsultaCliente/xsd/consultaClientesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaClienteTarjetas/xq/consultaClienteV3In/";

declare function xf:consultaClienteV3In($SEARCH_CRITERIA as xs:string,
    $SEARCH_VALUE as xs:string)
    as element(ns0:consultaClienteRequest) {
        <ns0:consultaClienteRequest>
            <ns0:CUSTOMER_ID_TYPE>{ $SEARCH_CRITERIA }</ns0:CUSTOMER_ID_TYPE>
            <ns0:CUSTOMER_ID_VALUE>{ $SEARCH_VALUE }</ns0:CUSTOMER_ID_VALUE>
        </ns0:consultaClienteRequest>
};

declare variable $SEARCH_CRITERIA as xs:string external;
declare variable $SEARCH_VALUE as xs:string external;

xf:consultaClienteV3In($SEARCH_CRITERIA,
    $SEARCH_VALUE)