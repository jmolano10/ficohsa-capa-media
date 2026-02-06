xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$crearGestionResponse" element="ns1:CrearGestionResponse" location="../../../BusinessServices/OIC/gestionBloqueo/wsdl/gestionBloqueo.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:ingresaGestionProductoBeneficioResponse" location="../../GestionesProductoBeneficio/xsd/gestionesProductoBeneficioTypes.xsd" ::)

declare namespace ns1 = "http://soap.sforce.com/schemas/class/WS_GestionBloqueo";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesProductoBeneficioTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/IngresaGestionProductoBeneficio/xq/IngresaGestionProductoBeneficioOut/";

declare function xf:IngresaGestionProductoBeneficioOut($crearGestionResponse as element(ns1:CrearGestionResponse))
    as element(ns0:ingresaGestionProductoBeneficioResponse) {
        <ns0:ingresaGestionProductoBeneficioResponse>
            <MANAGEMENT_NUMBER>{ data($crearGestionResponse/ns1:result/ns1:IdGestion) }</MANAGEMENT_NUMBER>
            <MANAGEMENT_STATUS>{ data($crearGestionResponse/ns1:result/ns1:estadoGestion) }</MANAGEMENT_STATUS>
        </ns0:ingresaGestionProductoBeneficioResponse>
};

declare variable $crearGestionResponse as element(ns1:CrearGestionResponse) external;

xf:IngresaGestionProductoBeneficioOut($crearGestionResponse)