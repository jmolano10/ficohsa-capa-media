xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$ingresaCuentaBeneficio" element="ns1:ingresaCuentaBeneficio" location="../xsd/ingresaCuentaBeneficioTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:crearGestion" location="../../../BusinessServices/SALESFORCE/ingresaCuentaBeneficio/wsdl/ingresaCuentaBeneficioPS.wsdl" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/ingresaCuentaBeneficioTypes";
declare namespace ns0 = "http://soap.sforce.com/schemas/class/WS_GestionesBancaSeguros";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/IngresaCuentaBeneficio/xq/ingresaCuentaBeneficioHnIn/";

declare function xf:ingresaCuentaBeneficioHnIn($ingresaCuentaBeneficio as element(ns1:ingresaCuentaBeneficio)
    )
    as element(ns0:crearGestion) {
        <ns0:crearGestion>
            <ns0:motivoCaso>{ data($ingresaCuentaBeneficio/REASON) }</ns0:motivoCaso>
            <ns0:nombreCliente>{ data($ingresaCuentaBeneficio/CLIENT/FULL_NAME) }</ns0:nombreCliente>
            <ns0:nroIdentidad>{ data($ingresaCuentaBeneficio/CLIENT/LEGAL_ID) }</ns0:nroIdentidad>
            <ns0:nroCuenta>{ data($ingresaCuentaBeneficio/PRODUCT/ACCOUNT) }</ns0:nroCuenta>
            <ns0:clienteUnico>{ data($ingresaCuentaBeneficio/CLIENT/CUSTOMER_ID) }</ns0:clienteUnico>
            <ns0:tipoPlan>{ data($ingresaCuentaBeneficio/PLAN_TYPE) }</ns0:tipoPlan>
            <ns0:tipoPPT>{ data($ingresaCuentaBeneficio/BENEFIT/TYPE) }</ns0:tipoPPT>
            <ns0:asunto>{ data($ingresaCuentaBeneficio/MATTER) }</ns0:asunto>
            <ns0:descripcion>{ data($ingresaCuentaBeneficio/DESCRIPTION) }</ns0:descripcion>
            <ns0:tipoGestion>{ data($ingresaCuentaBeneficio/MANAGEMENT_TYPE) }</ns0:tipoGestion>
        </ns0:crearGestion>
};

declare variable $ingresaCuentaBeneficio as element(ns1:ingresaCuentaBeneficio) external;


xf:ingresaCuentaBeneficioHnIn($ingresaCuentaBeneficio)