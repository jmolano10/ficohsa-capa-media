xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaTarjetaCreditoTypeRequest1" element="ns0:ConsultaTarjetaCreditoTypeRequest" location="ConsultaTarjetaCreditoCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns1:AutenticacionRequestHeader" location="../../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "ConsultaTarjetaCreditoCliente";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaSaldosTCHeaderIn/";

declare function xf:consultaSaldosTCHeaderIn($consultaTarjetaCreditoTypeRequest1 as element(ns0:ConsultaTarjetaCreditoTypeRequest))
    as element(ns1:AutenticacionRequestHeader) {
        <ns1:AutenticacionRequestHeader>
            <UserName>{ data($consultaTarjetaCreditoTypeRequest1/ns0:AUTHENTICATION/ns0:USERNAME[1]) }</UserName>
            <Password>{ data($consultaTarjetaCreditoTypeRequest1/ns0:AUTHENTICATION/ns0:PASSWORD[1]) }</Password>
        </ns1:AutenticacionRequestHeader>
};

declare variable $consultaTarjetaCreditoTypeRequest1 as element(ns0:ConsultaTarjetaCreditoTypeRequest) external;

xf:consultaSaldosTCHeaderIn($consultaTarjetaCreditoTypeRequest1)