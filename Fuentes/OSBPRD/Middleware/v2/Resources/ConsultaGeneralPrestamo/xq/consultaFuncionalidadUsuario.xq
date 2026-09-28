(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ValidaFuncionalidadUsuario/xsd/ValidaFuncionalidadUsuario_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaFuncionalidadUsuario";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaGeneralPrestamo/xq/consultaFuncionalidadUsuario2/";

declare function xf:consultaFuncionalidadUsuario2($requestHeader1 as element(ns1:RequestHeader),
    $functionality as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_USUARIO>{ fn:upper-case(data($requestHeader1/Authentication/UserName)) }</ns0:PV_USUARIO>
            <ns0:PV_FUNCIONALIDAD>{ $functionality }</ns0:PV_FUNCIONALIDAD>
        </ns0:InputParameters>
};

declare variable $requestHeader1 as element(ns1:RequestHeader) external;
declare variable $functionality as xs:string external;

xf:consultaFuncionalidadUsuario2($requestHeader1,
    $functionality)