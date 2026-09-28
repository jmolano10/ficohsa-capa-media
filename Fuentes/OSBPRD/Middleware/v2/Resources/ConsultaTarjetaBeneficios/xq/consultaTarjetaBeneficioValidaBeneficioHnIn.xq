(:: pragma bea:global-element-parameter parameter="$consultaProductoBeneficios" element="ns1:consultaProductoBeneficios" location="../../ConsultaProductoBeneficio/xsd/consultaProductoBeneficiosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:crearGestion" location="../../../BusinessServices/SALESFORCE/ConsultaBeneficioTarjetas/wsdl/consultaBeneficioTarjetasPS.wsdl" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaProductoBeneficiosTypes";
declare namespace ns0 = "http://soap.sforce.com/schemas/class/WS_GestionesBeneficios";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTarjetaBeneficios/xq/consultaTarjetaBeneficioHnIn/";

declare function xf:consultaTarjetaBeneficioHnIn($beneficio as xs:string,
    $cuenta as xs:string,
    $identidad as xs:string)
    as element(ns0:validarBeneficio) {
        <ns0:validarBeneficio>
            <ns0:nroIdentidad>{ xs:string($identidad) }</ns0:nroIdentidad>
            <ns0:nroCuenta>{ xs:string($cuenta) }</ns0:nroCuenta>
            <ns0:beneficio>{ xs:string($beneficio) }</ns0:beneficio>
        </ns0:validarBeneficio>
};

declare variable $beneficio as xs:string external;
declare variable $cuenta as xs:string external;
declare variable $identidad as xs:string external;

xf:consultaTarjetaBeneficioHnIn($beneficio,
    $cuenta,
    $identidad)