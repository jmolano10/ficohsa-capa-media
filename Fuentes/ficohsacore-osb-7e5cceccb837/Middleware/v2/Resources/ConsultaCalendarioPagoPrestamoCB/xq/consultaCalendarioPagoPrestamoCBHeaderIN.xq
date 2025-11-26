(:: pragma bea:global-element-parameter parameter="$requestHeaderCB" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElementsCB.xsd" ::)
(:: pragma bea:global-element-return element="ns0:AutenticacionRequestHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCalendarioPagoPrestamoCB/xq/consultaCalendarioPagoPrestamoCBHeaderIN/";

declare function xf:consultaCalendarioPagoPrestamoCBHeaderIN($requestHeaderCB as element(ns0:RequestHeader))
    as element(ns0:AutenticacionRequestHeader) {
        <ns0:AutenticacionRequestHeader>
            <UserName>{ data($requestHeaderCB/Authentication/UserName) }</UserName>
            <Password>{ data($requestHeaderCB/Authentication/Password) }</Password>
        </ns0:AutenticacionRequestHeader>
};

declare variable $requestHeaderCB as element(ns0:RequestHeader) external;

xf:consultaCalendarioPagoPrestamoCBHeaderIN($requestHeaderCB)