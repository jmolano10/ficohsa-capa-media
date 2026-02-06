xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ValidaFuncionalidadUsuario/xsd/ValidaFuncionalidadUsuario_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaFuncionalidadUsuario/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaFuncionalidadUsuario";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";

declare function xf:consultaFuncionalidadUsuario($requestHeader as element(ns1:RequestHeader),
    $functionality as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_USUARIO>{ fn:upper-case(data($requestHeader/Authentication/UserName)) }</ns0:PV_USUARIO>
            <ns0:PV_FUNCIONALIDAD>{ $functionality }</ns0:PV_FUNCIONALIDAD>
        </ns0:InputParameters>
};

declare variable $requestHeader as element(ns1:RequestHeader) external;
declare variable $functionality as xs:string external;

xf:consultaFuncionalidadUsuario($requestHeader,
    $functionality)