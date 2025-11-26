(:: pragma bea:global-element-parameter parameter="$login1" element="ns0:login" location="../xsd/loginTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validacionBasica" location="../../../BusinessServices/OSB/AutenticacionInterna_v2/xsd/XMLSchema_1706459653.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autenticacionInternaTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/loginTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Login/xq/validacionBasicaIN/";

declare function xf:validacionBasicaIN($login1 as element(ns0:login))
    as element(ns1:validacionBasica) {
        <ns1:validacionBasica>
            <USERNAME>{ data($login1/USERNAME) }</USERNAME>
            <PASSWORD>{ data($login1/PASSWORD) }</PASSWORD>
            <APPLICATION>{ data($login1/APPLICATION) }</APPLICATION>
        </ns1:validacionBasica>
};

declare variable $login1 as element(ns0:login) external;

xf:validacionBasicaIN($login1)
