xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$login1" element="ns1:login" location="../xsd/loginTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaUsuariosPGAResponse1" element="ns0:consultaUsuariosPGAResponse" location="../../ConsultaUsuarioPGA/xsd/consultaUsuariosPGATypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:obtenerInfoUsuarioAPP" location="../../../BusinessServices/OSB/ObtenerInfoUsuarioAPP_v2/xsd/XMLSchema_905029051.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/obtenerInfoUsuarioAPPTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/loginTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaUsuariosPGATypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Login/xq/obtenerInfoUsuarioAPPIn/";

declare function xf:obtenerInfoUsuarioAPPIn($login1 as element(ns1:login),
    $consultaUsuariosPGAResponse1 as element(ns0:consultaUsuariosPGAResponse))
    as element(ns2:obtenerInfoUsuarioAPP) {
        <ns2:obtenerInfoUsuarioAPP>
            <PROFILE>{ data($consultaUsuariosPGAResponse1/PROFILE) }</PROFILE>
            <APPLICATION>{ data($login1/APPLICATION) }</APPLICATION>
        </ns2:obtenerInfoUsuarioAPP>
};

declare variable $login1 as element(ns1:login) external;
declare variable $consultaUsuariosPGAResponse1 as element(ns0:consultaUsuariosPGAResponse) external;

xf:obtenerInfoUsuarioAPPIn($login1,
    $consultaUsuariosPGAResponse1)