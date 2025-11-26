(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns1:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../v2/BusinessServices/ValidaFuncionalidadUsuario/xsd/ValidaFuncionalidadUsuario_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaFuncionalidadUsuario";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaActivosCliente/consultaFuncionalidadUsuario/";

declare function xf:consultaFuncionalidadUsuario($autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader),
    $functionality as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_USUARIO>{ fn:upper-case(data($autenticacionRequestHeader1/UserName)) }</ns0:PV_USUARIO>
            <ns0:PV_FUNCIONALIDAD>{ $functionality }</ns0:PV_FUNCIONALIDAD>
        </ns0:InputParameters>
};

declare variable $autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader) external;
declare variable $functionality as xs:string external;

xf:consultaFuncionalidadUsuario($autenticacionRequestHeader1,
    $functionality)