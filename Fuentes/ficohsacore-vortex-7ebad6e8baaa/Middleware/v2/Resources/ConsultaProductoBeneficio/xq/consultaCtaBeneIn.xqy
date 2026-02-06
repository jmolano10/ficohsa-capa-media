xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaCuentaBeneficios" location="../../ConsultaCuentaBeneficios/xsd/consultaCuentaBeneficiosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaCuentaBeneficiosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductoBeneficio/xq/consultaCtaBeneIn/";

declare function xf:consultaCtaBeneIn($account as xs:string)
    as element(ns0:consultaCuentaBeneficios) {
        <ns0:consultaCuentaBeneficios>
            <ACCOUNT_NUMBER>{ $account }</ACCOUNT_NUMBER>
        </ns0:consultaCuentaBeneficios>
};

declare variable $account as xs:string external;

xf:consultaCtaBeneIn($account)