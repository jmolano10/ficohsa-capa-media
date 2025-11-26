(:: pragma bea:global-element-parameter parameter="$creaAccesoUsuario" element="ns1:creaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:CrearUsuario" location="../../../BusinessServices/ACSELXGT/GestionAccesosUsuarios/wsdl/WS_AcselxIDM_gt.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaAccesoUsuario/xq/crearUsuarioGTIn/";

declare function xf:crearUsuarioGTIn($creaAccesoUsuario as element(ns1:creaAccesoUsuario))
    as element(ns0:CrearUsuario) {
        <ns0:CrearUsuario>
            <ns0:pvCodigoUsuarioGFF>{ data($creaAccesoUsuario/creaAccesoUsuario/APPLICATION_USER) }</ns0:pvCodigoUsuarioGFF>
            <ns0:pvArea>{ data($creaAccesoUsuario/creaAccesoUsuario/DEPARTMENT) }</ns0:pvArea>
            <ns0:pvPerfilPuesto>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "PROFILE"]/VALUE)) }</ns0:pvPerfilPuesto>
            <ns0:pvCodigoOficina>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "AGENCY"]/VALUE)) }</ns0:pvCodigoOficina>
            <ns0:pvEmailGFF>{ data($creaAccesoUsuario/creaAccesoUsuario/EMAIL) }</ns0:pvEmailGFF>
            <ns0:pvPrimerNombre>{ data($creaAccesoUsuario/creaAccesoUsuario/FIRST_NAME) }</ns0:pvPrimerNombre>
            <ns0:pvSegundoNombre>{ data($creaAccesoUsuario/creaAccesoUsuario/SECOND_NAME) }</ns0:pvSegundoNombre>
            <ns0:pvPrimerApellido>{ data($creaAccesoUsuario/creaAccesoUsuario/FIRST_LASTNAME) }</ns0:pvPrimerApellido>
            <ns0:pvSegundoApellido>{ data($creaAccesoUsuario/creaAccesoUsuario/SECOND_LASTNAME) }</ns0:pvSegundoApellido>
        </ns0:CrearUsuario>
};

declare variable $creaAccesoUsuario as element(ns1:creaAccesoUsuario) external;

xf:crearUsuarioGTIn($creaAccesoUsuario)