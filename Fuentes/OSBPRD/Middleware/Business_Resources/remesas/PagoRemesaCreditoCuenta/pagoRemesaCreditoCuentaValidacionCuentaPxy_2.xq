xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:validacionCuenta" location="../../../v3/Resources/ValidacionCuenta/xsd/validacionCuentaType.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/PagoRemesaCreditoCuenta/pagoRemesaCreditoCuentaValidacionCuentaPxy_2/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaType";

declare function xf:pagoRemesaCreditoCuentaValidacionCuentaPxy_2($accountNumber as xs:string,
    $checkCancelled as xs:string,
    $accountName as xs:string)
as element(ns0:validacionCuenta) {
        <ns0:validacionCuenta>
            <ACCOUNT_NUMBER>{ $accountNumber }</ACCOUNT_NUMBER>
            <ACCOUNT_NAME>{ $accountName }</ACCOUNT_NAME>
            <CHECK_CANCELLED_YES_NO>{ $checkCancelled }</CHECK_CANCELLED_YES_NO>
        </ns0:validacionCuenta>
};

declare variable $accountNumber as xs:string external;
declare variable $checkCancelled as xs:string external;
declare variable $accountName as xs:string external;

xf:pagoRemesaCreditoCuentaValidacionCuentaPxy_2($accountNumber,
    $checkCancelled,
    $accountName)