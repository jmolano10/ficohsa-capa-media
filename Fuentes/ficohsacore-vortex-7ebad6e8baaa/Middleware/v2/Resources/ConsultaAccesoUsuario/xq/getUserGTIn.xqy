xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaAccesoUsuario" element="ns1:consultaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/JTeller/ConsultaAccesoUsuario/xsd/getUser_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetUser";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAccesoUsuario/xq/getUserGTIn/";

declare function xf:getUserGTIn($consultaAccesoUsuario as element(ns1:consultaAccesoUsuario))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:usr_code>{ data($consultaAccesoUsuario/consultaAccesoUsuario/APPLICATION_USER) }</ns0:usr_code>
        </ns0:InputParameters>
};

declare variable $consultaAccesoUsuario as element(ns1:consultaAccesoUsuario) external;

xf:getUserGTIn($consultaAccesoUsuario)