(:: pragma bea:global-element-parameter parameter="$pagoSeguro1" element="ns1:pagoSeguro" location="../xsd/pagoSeguroTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/CNV/registroPagoSeguro/xsd/RegistroPagoSeguro_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoSeguroTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/RegistroPagoSeguro";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoSeguros/xq/registroPagoSeguroIn/";

declare function xf:registroPagoSeguroIn($pagoSeguro1 as element(ns1:pagoSeguro),
    $maxAttempts as xs:string,
    $movementsIndicator as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_NUMERO_POLIZA>{ data($pagoSeguro1/POLICY_NUMBER) }</ns0:PV_NUMERO_POLIZA>
            <ns0:PV_NUMERO_CUENTA>{ data($pagoSeguro1/DEBIT_ACCOUNT) }</ns0:PV_NUMERO_CUENTA>
            <ns0:PN_NUMERO_CUOTA>{ xs:integer(data($pagoSeguro1/INSTALLMENT_NUMBER)) }</ns0:PN_NUMERO_CUOTA>
            <ns0:PN_MAX_INTENTOS>{ xs:integer($maxAttempts) }</ns0:PN_MAX_INTENTOS>
            <ns0:PV_MOV_INDICATOR>{ $movementsIndicator }</ns0:PV_MOV_INDICATOR>
        </ns0:InputParameters>
};

declare variable $pagoSeguro1 as element(ns1:pagoSeguro) external;
declare variable $maxAttempts as xs:string external;
declare variable $movementsIndicator as xs:string external;

xf:registroPagoSeguroIn($pagoSeguro1,
    $maxAttempts,
    $movementsIndicator)