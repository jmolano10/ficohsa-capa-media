xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:validacionCuenta" location="../../../../v3/Resources/ValidacionCuenta/xsd/validacionCuentaType.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACHDebitos/xq/validacionCuentaACHIn/";

declare function xf:validacionCuentaACHIn($accountNumber as xs:string,
    $accountName as xs:string,
    $checkCancelled as xs:string)
    as element(ns0:validacionCuenta) {
        <ns0:validacionCuenta>
            <ACCOUNT_NUMBER>{ $accountNumber }</ACCOUNT_NUMBER>
            <ACCOUNT_NAME>{ $accountName }</ACCOUNT_NAME>
            <CHECK_CANCELLED_YES_NO>{ $checkCancelled }</CHECK_CANCELLED_YES_NO>
        </ns0:validacionCuenta>
};

declare variable $accountNumber as xs:string external;
declare variable $accountName as xs:string external;
declare variable $checkCancelled as xs:string external;

xf:validacionCuentaACHIn($accountNumber,
    $accountName,
    $checkCancelled)