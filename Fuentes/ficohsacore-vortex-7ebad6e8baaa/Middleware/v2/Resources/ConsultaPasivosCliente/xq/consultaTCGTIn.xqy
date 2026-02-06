xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaTarjetaCreditoTypeRequest" location="../../../../Business_Resources/consultasCliente/consultaPasivosCliente/consultaTC/ConsultaTarjetaCreditoCliente.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "ConsultaTarjetaCreditoCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPasivosCliente/xq/consultaTCGTIn/";

declare function xf:consultaTCGTIn($requestHeader1 as element(ns1:RequestHeader),
    $customerId as xs:string)
    as element(ns0:ConsultaTarjetaCreditoTypeRequest) {
        <ns0:ConsultaTarjetaCreditoTypeRequest>
            <ns0:AUTHENTICATION>
                <ns0:USERNAME>{ data($requestHeader1/Authentication/UserName) }</ns0:USERNAME>
                <ns0:PASSWORD>{ data($requestHeader1/Authentication/Password) }</ns0:PASSWORD>
            </ns0:AUTHENTICATION>
            <ns0:PARAMETERS>
                <ns0:CUSTOMERID>{ $customerId }</ns0:CUSTOMERID>
            </ns0:PARAMETERS>
        </ns0:ConsultaTarjetaCreditoTypeRequest>
};

declare variable $requestHeader1 as element(ns1:RequestHeader) external;
declare variable $customerId as xs:string external;

xf:consultaTCGTIn($requestHeader1,
    $customerId)