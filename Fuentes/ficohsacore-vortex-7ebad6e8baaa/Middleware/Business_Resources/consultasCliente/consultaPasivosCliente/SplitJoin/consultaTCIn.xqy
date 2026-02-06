xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaPasivosClienteRequest1" element="ns1:consultaPasivosClienteRequest" location="../../Resources/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaTarjetaCreditoTypeRequest" location="../consultaTC/ConsultaTarjetaCreditoCliente.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "ConsultaTarjetaCreditoCliente";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/test/consultaTCIn/";

declare function xf:consultaTCIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $consultaPasivosClienteRequest1 as element(ns1:consultaPasivosClienteRequest))
    as element(ns0:ConsultaTarjetaCreditoTypeRequest) {
        <ns0:ConsultaTarjetaCreditoTypeRequest>
            <ns0:AUTHENTICATION>
                <ns0:USERNAME>{ data($autenticacionRequestHeader1/UserName) }</ns0:USERNAME>
                <ns0:PASSWORD>{ data($autenticacionRequestHeader1/Password) }</ns0:PASSWORD>
            </ns0:AUTHENTICATION>
            <ns0:PARAMETERS>
                <ns0:CUSTOMERID>{ data($consultaPasivosClienteRequest1/CUSTOMER_ID) }</ns0:CUSTOMERID>
            </ns0:PARAMETERS>
        </ns0:ConsultaTarjetaCreditoTypeRequest>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaPasivosClienteRequest1 as element(ns1:consultaPasivosClienteRequest) external;

xf:consultaTCIn($autenticacionRequestHeader1,
    $consultaPasivosClienteRequest1)