xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$ingresaGestionProductoBeneficioRequest" element="ns1:ingresaGestionProductoBeneficioRequest" location="../../GestionesProductoBeneficio/xsd/gestionesProductoBeneficioTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:CrearGestion" location="../../../BusinessServices/OIC/gestionBloqueo/wsdl/gestionBloqueo.wsdl" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionesProductoBeneficioTypes";
declare namespace ns0 = "http://soap.sforce.com/schemas/class/WS_GestionBloqueo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/IngresaGestionProductoBeneficio/xq/CrearGestionIn/";

declare function xf:CrearGestionIn($ingresaGestionProductoBeneficioRequest as element(ns1:ingresaGestionProductoBeneficioRequest),
    $pais as xs:string)
    as element(ns0:CrearGestion) {
        <ns0:CrearGestion>
            <ns0:NumTarjeta>{ data($ingresaGestionProductoBeneficioRequest/CARD_DETAILS/NUMBER) }</ns0:NumTarjeta>
            <ns0:TipoTarjeta>{ data($ingresaGestionProductoBeneficioRequest/CARD_DETAILS/PRODUCT_TYPE) }</ns0:TipoTarjeta>
            <ns0:EstadoTarjeta>{ data($ingresaGestionProductoBeneficioRequest/CARD_DETAILS/STATUS) }</ns0:EstadoTarjeta>
            <ns0:NombreTitular>{ data($ingresaGestionProductoBeneficioRequest/CARD_DETAILS/HOLDER_NAME) }</ns0:NombreTitular>
            <ns0:Identidad>{ data($ingresaGestionProductoBeneficioRequest/LEGAL_ID) }</ns0:Identidad>
            <ns0:Producto>{ data($ingresaGestionProductoBeneficioRequest/CARD_DETAILS/LOGO) }</ns0:Producto>
            <ns0:TipoGestion>{ data($ingresaGestionProductoBeneficioRequest/MANAGEMENT_TYPE) }</ns0:TipoGestion>
            {
            	if ($pais = 'GT01') then (
            		<ns0:Pais>GUATEMALA</ns0:Pais>
            	)
            	else if ($pais = 'HN01') then (
            		<ns0:Pais>HONDURAS</ns0:Pais>
            	)
            	else if ($pais = 'NI01') then (
            		<ns0:Pais>NICARAGUA</ns0:Pais>
            	)
            	else if ($pais = 'PA01') then (
            		<ns0:Pais>PANAMA</ns0:Pais>
            	)
            	else (
            		<ns0:Pais></ns0:Pais>
            	)
            }
        </ns0:CrearGestion>
};

declare variable $ingresaGestionProductoBeneficioRequest as element(ns1:ingresaGestionProductoBeneficioRequest) external;
declare variable $pais as xs:string external;

xf:CrearGestionIn($ingresaGestionProductoBeneficioRequest,
    $pais)