(:: pragma bea:global-element-parameter parameter="$consultaUsuariosPGAResponse1" element="ns0:consultaUsuariosPGAResponse" location="../../ConsultaUsuarioPGA/xsd/consultaUsuariosPGATypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$obtenerInfoUsuarioAPPResponse1" element="ns2:obtenerInfoUsuarioAPPResponse" location="../../../BusinessServices/OSB/ObtenerInfoUsuarioAPP_v2/xsd/XMLSchema_905029051.xsd" ::)
(:: pragma bea:global-element-return element="ns1:loginResponse" location="../xsd/loginTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/obtenerInfoUsuarioAPPTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/loginTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaUsuariosPGATypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Login/xq/LoginUsuarioINTBOut/";

declare function xf:LoginUsuarioINTBOut($consultaUsuariosPGAResponse1 as element(ns0:consultaUsuariosPGAResponse),
    $obtenerInfoUsuarioAPPResponse1 as element(ns2:obtenerInfoUsuarioAPPResponse))
    as element(ns1:loginResponse) {
        <ns1:loginResponse>
            {
                for $PROFILE in $consultaUsuariosPGAResponse1/PROFILE
                return
                    <PROFILE>{ data($PROFILE) }</PROFILE>
            }
            {
                for $ROLLCODE in $consultaUsuariosPGAResponse1/ROLLCODE
                return
                    <ROLLCODE>{ data($ROLLCODE) }</ROLLCODE>
            }
            {
                for $ROLLNAME in $consultaUsuariosPGAResponse1/ROLLNAME
                return
                    <ROLLNAME>{ data($ROLLNAME) }</ROLLNAME>
            }
            <USER_INFORMATION>
                {
                    for $NAME in $obtenerInfoUsuarioAPPResponse1/USER_INFORMATION[1]/NAME
                    return
                        <NAME>{ data($NAME) }</NAME>
                }
                {
                    for $VALUE in $obtenerInfoUsuarioAPPResponse1/USER_INFORMATION[1]/VALUE
                    return
                        <VALUE>{ data($VALUE) }</VALUE>
                }
            </USER_INFORMATION>
        </ns1:loginResponse>
};

declare variable $consultaUsuariosPGAResponse1 as element(ns0:consultaUsuariosPGAResponse) external;
declare variable $obtenerInfoUsuarioAPPResponse1 as element(ns2:obtenerInfoUsuarioAPPResponse) external;

xf:LoginUsuarioINTBOut($consultaUsuariosPGAResponse1,
    $obtenerInfoUsuarioAPPResponse1)
