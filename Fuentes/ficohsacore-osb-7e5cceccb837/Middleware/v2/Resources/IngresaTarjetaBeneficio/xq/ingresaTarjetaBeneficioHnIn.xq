(:: pragma bea:global-element-parameter parameter="$ingresaTarjetaBeneficio" element="ns0:ingresaProductoBeneficio" location="../../GestionesProductoBeneficio/xsd/gestionesProductoBeneficioTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:crearGestion" location="../../../BusinessServices/SALESFORCE/gestionesBeneficio/wsdl/gestionesBeneficioPS.wsdl" ::)

declare namespace ns1 = "http://soap.sforce.com/schemas/class/WS_GestionesBeneficios";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesProductoBeneficioTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/IngresaTarjetaBeneficio/xq/ingresoTarjetaBeneficioHnIn/";

declare function xf:ingresoTarjetaBeneficioHnIn($ingresaTarjetaBeneficio as element(ns0:ingresaProductoBeneficio),
    $descripcion as xs:string,
    $identidad as xs:string,
    $cuenta as xs:string,
    $beneficio as xs:string,
    $tipoGestion as xs:string,
    $asunto as xs:string,
    $formaPago as xs:string,
    $origen as xs:string)
    as element(ns1:crearGestion) {
        <ns1:crearGestion>
            <ns1:tipoGestion>{ data($tipoGestion) }</ns1:tipoGestion>
            <ns1:nroIdentidad>{ data($identidad) }</ns1:nroIdentidad>
            <ns1:nroCuenta>{ data($cuenta) }</ns1:nroCuenta>
            <ns1:nroTarjeta>{ data($ingresaTarjetaBeneficio/PRODUCT/VALUE) }</ns1:nroTarjeta>
            <ns1:beneficio>{ data($beneficio) }</ns1:beneficio>
            <ns1:asunto>{ data($asunto) }</ns1:asunto>
            <ns1:descripcion>{ data($descripcion) }</ns1:descripcion>
            <ns1:formaPago>{ data($formaPago) }</ns1:formaPago>
            <ns1:origen>{ data($origen) }</ns1:origen>
        </ns1:crearGestion>
};

declare variable $ingresaTarjetaBeneficio as element(ns0:ingresaProductoBeneficio) external;
declare variable $descripcion as xs:string external;
declare variable $identidad as xs:string external;
declare variable $cuenta as xs:string external;
declare variable $beneficio as xs:string external;
declare variable $tipoGestion as xs:string external;
declare variable $asunto as xs:string external;
declare variable $formaPago as xs:string external;
declare variable $origen as xs:string external;

xf:ingresoTarjetaBeneficioHnIn($ingresaTarjetaBeneficio,
    $descripcion,
    $identidad,
    $cuenta,
    $beneficio,
    $tipoGestion,
    $asunto,
    $formaPago,
    $origen)