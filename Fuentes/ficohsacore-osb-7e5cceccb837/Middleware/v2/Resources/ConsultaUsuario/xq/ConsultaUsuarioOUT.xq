(:: pragma bea:global-element-return element="ns0:consultaUsuarioResponse" location="../xsd/consultaUsuarioTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaUsuarioTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaUsuario/xq/ConsultaUsuarioOUT/";

declare function xf:ConsultaUsuarioOUT($UserName as xs:string)
    as element(ns0:consultaUsuarioResponse) {
        <ns0:consultaUsuarioResponse>
            <USER_NAME>{ $UserName }</USER_NAME>
        </ns0:consultaUsuarioResponse>
};

declare variable $UserName as xs:string external;

xf:ConsultaUsuarioOUT($UserName)
