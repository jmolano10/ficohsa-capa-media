xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaPasivosClienteRequest" element="ns2:consultaPasivosClienteRequest" location="../../../../Business_Resources/consultasCliente/Resources/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultaTarjetaCreditoTypeRequest" location="../../../../Business_Resources/consultasCliente/consultaPasivosCliente/consultaTC/ConsultaTarjetaCreditoCliente.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPasivosCliente/xq/consultaTCIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns1 = "ConsultaTarjetaCreditoCliente";

declare function xf:consultaTCIn($requestHeader as element(ns0:RequestHeader),
    $consultaPasivosClienteRequest as element(ns2:consultaPasivosClienteRequest))
    as element(ns1:ConsultaTarjetaCreditoTypeRequest) {
        <ns1:ConsultaTarjetaCreditoTypeRequest>
            <ns1:AUTHENTICATION>
                <ns1:USERNAME>{ data($requestHeader/Authentication/UserName) }</ns1:USERNAME>
                <ns1:PASSWORD>{ data($requestHeader/Authentication/Password) }</ns1:PASSWORD>
            </ns1:AUTHENTICATION>
            <ns1:PARAMETERS>
                <ns1:CUSTOMERID>{ data($consultaPasivosClienteRequest/CUSTOMER_ID) }</ns1:CUSTOMERID>
            </ns1:PARAMETERS>
        </ns1:ConsultaTarjetaCreditoTypeRequest>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaPasivosClienteRequest as element(ns2:consultaPasivosClienteRequest) external;

xf:consultaTCIn($requestHeader,
    $consultaPasivosClienteRequest)