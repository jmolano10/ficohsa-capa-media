(:: pragma bea:global-element-return element="ns0:validacionCuenta" location="../../../../Business_Resources/validacionCuenta/ValidacionCuenta/validacionCuentaType.xsd" ::)
(:: jgarcia - 31102017 :)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCuentaRetiroEfectivoCB/xq/ValidaCuentaCBRetIn/";

declare function xf:ValidaCuentaCBRetIn($numeroCuenta as xs:string)
    as element(ns0:validacionCuenta) {
        <ns0:validacionCuenta>
            <ACCOUNT_NUMBER>{ $numeroCuenta }</ACCOUNT_NUMBER>
            <CHECK_CANCELLED_YES_NO>NO</CHECK_CANCELLED_YES_NO>
        </ns0:validacionCuenta>
};

declare variable $numeroCuenta as xs:string external;

xf:ValidaCuentaCBRetIn($numeroCuenta)