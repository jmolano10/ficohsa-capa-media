(:: pragma bea:global-element-return element="ns0:consultaClienteRequest" location="../../../../v3/Resources/ConsultaCliente/xsd/consultaClientesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCuentaRetiroEfectivoCB/xq/ConsultaClienteV3In/";

declare function xf:ConsultaClienteV3In($tipoBusqueda as xs:string,
    $codigoBusqueda as xs:string)
    as element(ns0:consultaClienteRequest) {
        <ns0:consultaClienteRequest>
            <ns0:CUSTOMER_ID_TYPE>{ $tipoBusqueda }</ns0:CUSTOMER_ID_TYPE>
            <ns0:CUSTOMER_ID_VALUE>{ $codigoBusqueda }</ns0:CUSTOMER_ID_VALUE>
        </ns0:consultaClienteRequest>
};

declare variable $tipoBusqueda as xs:string external;
declare variable $codigoBusqueda as xs:string external;

xf:ConsultaClienteV3In($tipoBusqueda,
    $codigoBusqueda)