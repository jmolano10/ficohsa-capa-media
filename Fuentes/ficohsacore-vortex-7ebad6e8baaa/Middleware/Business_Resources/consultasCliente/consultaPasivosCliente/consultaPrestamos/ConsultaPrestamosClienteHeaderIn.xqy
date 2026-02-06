xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaPrestamoTypeRequest1" element="ns0:ConsultaPrestamoTypeRequest" location="ConsultaPrestamosCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns1:AutenticacionRequestHeader" location="../../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "ConsultaPrestamosCliente";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaPrestamos/ConsultaPrestamosClienteHeaderIn/";

declare function xf:ConsultaPrestamosClienteHeaderIn($consultaPrestamoTypeRequest1 as element(ns0:ConsultaPrestamoTypeRequest))
    as element(ns1:AutenticacionRequestHeader) {
        <ns1:AutenticacionRequestHeader>
            <UserName>{ data($consultaPrestamoTypeRequest1/ns0:AUTHENTICATION_PROXY/ns0:USERNAME[1]) }</UserName>
            <Password>{ data($consultaPrestamoTypeRequest1/ns0:AUTHENTICATION_PROXY/ns0:PASSWORD[1]) }</Password>
        </ns1:AutenticacionRequestHeader>
};

declare variable $consultaPrestamoTypeRequest1 as element(ns0:ConsultaPrestamoTypeRequest) external;

xf:ConsultaPrestamosClienteHeaderIn($consultaPrestamoTypeRequest1)