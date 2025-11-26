(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRemesaCreditoCuenta1" element="ns0:pagoRemesaCreditoCuenta" location="pagoRemesaCreditoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validacionCuenta" location="../../validacionCuenta/ValidacionCuenta/validacionCuentaType.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesaCreditoCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/PagoRemesaCreditoCuenta/pagoRemesaCreditoCuentaValidacionCuentaPxy/";

declare function xf:pagoRemesaCreditoCuentaValidacionCuentaPxy($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $validationType as xs:string,
    $pagoRemesaCreditoCuenta1 as element(ns0:pagoRemesaCreditoCuenta))
    as element(ns1:validacionCuenta) {
        <ns1:validacionCuenta>
            <ACCOUNT_NUMBER>{ data($pagoRemesaCreditoCuenta1/ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
            <ACCOUNT_NAME>
            {if ($validationType = "ACCONLY") then () else (data($pagoRemesaCreditoCuenta1/BENEFICIARY_NAME)) }
            </ACCOUNT_NAME>
            <CHECK_CANCELLED_YES_NO>NO</CHECK_CANCELLED_YES_NO>
        </ns1:validacionCuenta>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $validationType as xs:string external;
declare variable $pagoRemesaCreditoCuenta1 as element(ns0:pagoRemesaCreditoCuenta) external;

xf:pagoRemesaCreditoCuentaValidacionCuentaPxy($autenticacionRequestHeader1,
    $validationType,
    $pagoRemesaCreditoCuenta1)