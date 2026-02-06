xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$cambiaEstadoAccesoUsuario" element="ns0:cambiaEstadoAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/JTeller/CambiaEstadoAccesoUsuario/xsd/updateUserStatus_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/UpdateUserStatus";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CambiaEstadoAccesoUsuario/xq/updateUserStatusGTIn/";

declare function xf:updateUserStatusGTIn($cambiaEstadoAccesoUsuario as element(ns0:cambiaEstadoAccesoUsuario))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:usr_code>{ data($cambiaEstadoAccesoUsuario/cambiaEstadoAccesoUsuario/APPLICATION_USER) }</ns1:usr_code>
            <ns1:state>{ data($cambiaEstadoAccesoUsuario/cambiaEstadoAccesoUsuario/STATUS) }</ns1:state>
        </ns1:InputParameters>
};

declare variable $cambiaEstadoAccesoUsuario as element(ns0:cambiaEstadoAccesoUsuario) external;

xf:updateUserStatusGTIn($cambiaEstadoAccesoUsuario)