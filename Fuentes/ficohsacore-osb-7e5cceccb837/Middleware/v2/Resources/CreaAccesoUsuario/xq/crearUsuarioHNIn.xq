(:: pragma bea:global-element-parameter parameter="$creaAccesoUsuario" element="ns1:creaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:CrearUsuario" location="../../../BusinessServices/ACSELXHN/GestionAccesosUsuarios/wsdl/WS_AcselxIDM.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaAccesoUsuario/xq/crearUsuarioHNIn/";

declare function xf:crearUsuarioHNIn($creaAccesoUsuario as element(ns1:creaAccesoUsuario))
    as element(ns0:CrearUsuario) {
        <ns0:CrearUsuario>
            <ns0:pvCodigoUsuarioGFF>{ data($creaAccesoUsuario/creaAccesoUsuario/APPLICATION_USER) }</ns0:pvCodigoUsuarioGFF>
            <ns0:pvArea>{ data($creaAccesoUsuario/creaAccesoUsuario/DEPARTMENT) }</ns0:pvArea>
            <ns0:pvPerfilPuesto>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "PROFILE"]/VALUE)) }</ns0:pvPerfilPuesto>
            <ns0:pvCodigoJefeGFF>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "BOSS_CODE"]/VALUE)) }</ns0:pvCodigoJefeGFF>
            <ns0:pvCodigoOficina>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "AGENCY"]/VALUE)) }</ns0:pvCodigoOficina>
            <ns0:pvEmailGFF>{ data($creaAccesoUsuario/creaAccesoUsuario/EMAIL) }</ns0:pvEmailGFF>
            <ns0:pvTipoPersona>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "TYPE_OF_PERSON"]/VALUE)) }</ns0:pvTipoPersona>
            <ns0:pvTipoDocumento>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "TYPE_OF_DOCUMENT"]/VALUE)) }</ns0:pvTipoDocumento>
            <ns0:pvIdentificacion>{ data($creaAccesoUsuario/creaAccesoUsuario/LEGAL_ID) }</ns0:pvIdentificacion>
            <ns0:pdFechaNacimiento>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "DATE_OF_BIRTH"]/VALUE)) }</ns0:pdFechaNacimiento>
            <ns0:pvPrimerNombre>{ data($creaAccesoUsuario/creaAccesoUsuario/FIRST_NAME) }</ns0:pvPrimerNombre>
            <ns0:pvSegundoNombre>{ data($creaAccesoUsuario/creaAccesoUsuario/SECOND_NAME) }</ns0:pvSegundoNombre>
            <ns0:pvPrimerApellido>{ data($creaAccesoUsuario/creaAccesoUsuario/FIRST_LASTNAME) }</ns0:pvPrimerApellido>
            <ns0:pvSegundoApellido>{ data($creaAccesoUsuario/creaAccesoUsuario/SECOND_LASTNAME) }</ns0:pvSegundoApellido>
            <ns0:pvApellidoCasada>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "MARRIED_NAME"]/VALUE)) }</ns0:pvApellidoCasada>
            <ns0:pvNombreConyugue>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "SPOUSE_NAME"]/VALUE)) }</ns0:pvNombreConyugue>
            <ns0:pvSexo>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "GENDER"]/VALUE)) }</ns0:pvSexo>
            <ns0:pvPaisNacimiento>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "COUNTRY_OF_BIRTH"]/VALUE)) }</ns0:pvPaisNacimiento>
            <ns0:pvEstadoCivil>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "MARITAL_STATUS"]/VALUE)) }</ns0:pvEstadoCivil>
            <ns0:pvPaisResidencia>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "COUNTRY"]/VALUE)) }</ns0:pvPaisResidencia>
            <ns0:pvEstadoResidencia>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "STATE"]/VALUE)) }</ns0:pvEstadoResidencia>
            <ns0:pvCiudadResidencia>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "CITY"]/VALUE)) }</ns0:pvCiudadResidencia>
            <ns0:pvMunicipioResidencia>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "MUNICIPALITY"]/VALUE)) }</ns0:pvMunicipioResidencia>
            <ns0:pvDireccionResidencia>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "ADDRESS"]/VALUE)) }</ns0:pvDireccionResidencia>
            <ns0:pvTelefono>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "PHONE"]/VALUE)) }</ns0:pvTelefono>
        </ns0:CrearUsuario>
};

declare variable $creaAccesoUsuario as element(ns1:creaAccesoUsuario) external;

xf:crearUsuarioHNIn($creaAccesoUsuario)