xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$creaAccesoUsuario" element="ns0:creaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:creaAccesoUsuarioResponse" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaAccesoUsuario/xq/creaAccesoUsuarioOut/";

declare function xf:creaAccesoUsuarioOut($creaAccesoUsuario as element(ns0:creaAccesoUsuario),
    $codigoJteller as xs:string)
    as element(ns0:creaAccesoUsuarioResponse) {
        <ns0:creaAccesoUsuarioResponse>
            <APPLICATION_USER>{ data($creaAccesoUsuario/creaAccesoUsuario/APPLICATION_USER) }</APPLICATION_USER>
            {
            	if($codigoJteller != '')then(
            	
            		<EMPLOYEE_CODE_INT>{ $codigoJteller }</EMPLOYEE_CODE_INT>
            	
            	)else()
            }
        </ns0:creaAccesoUsuarioResponse>
};

declare variable $creaAccesoUsuario as element(ns0:creaAccesoUsuario) external;
declare variable $codigoJteller as xs:string external;

xf:creaAccesoUsuarioOut($creaAccesoUsuario,
    $codigoJteller)