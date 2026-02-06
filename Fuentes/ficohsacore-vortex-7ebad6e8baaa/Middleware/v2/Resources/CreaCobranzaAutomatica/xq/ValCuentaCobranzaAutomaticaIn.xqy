xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:validacionCuenta" location="../../../BusinessServices/OSB/ValidacionCuenta_v3/xsd/XMLSchema_-84616870.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaCobranzaAutomatica/xq/ValCuentaCobranzaAutomaticaIn/";

declare function xf:ValCuentaCobranzaAutomaticaIn($accountNumber as xs:string,
    $accountName as xs:string,
    $checkCanccelled as xs:string)
    as element(ns0:validacionCuenta) {
        <ns0:validacionCuenta>
            <ACCOUNT_NUMBER>{ $accountNumber }</ACCOUNT_NUMBER>
            <ACCOUNT_NAME>{ $accountName }</ACCOUNT_NAME>
            <CHECK_CANCELLED_YES_NO>{ $checkCanccelled }</CHECK_CANCELLED_YES_NO>
        </ns0:validacionCuenta>
};

declare variable $accountNumber as xs:string external;
declare variable $accountName as xs:string external;
declare variable $checkCanccelled as xs:string external;

xf:ValCuentaCobranzaAutomaticaIn($accountNumber,
    $accountName,
    $checkCanccelled)