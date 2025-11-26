(:: pragma bea:local-element-parameter parameter="$authenticationCB" type="ns0:RequestHeader/Authentication" location="../../esquemas_generales/HeaderElementsCB.xsd" ::)
(:: pragma bea:global-element-return element="ns0:AutenticacionRequestHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCalendarioPagoPrestamoCB/xq/consultaCalendarioPagoPrestamoCBsHeaderIN/";

declare function xf:consultaCalendarioPagoPrestamoCBsHeaderIN($authenticationCB as element())
    as element(ns0:AutenticacionRequestHeader) {
        <ns0:AutenticacionRequestHeader>
            <UserName>{ data($authenticationCB/UserName) }</UserName>
            <Password>{ data($authenticationCB/Password) }</Password>
        </ns0:AutenticacionRequestHeader>
};

declare variable $authenticationCB as element() external;

xf:consultaCalendarioPagoPrestamoCBsHeaderIN($authenticationCB)
