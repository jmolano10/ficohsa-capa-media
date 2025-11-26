(:: pragma bea:global-element-parameter parameter="$consultaCuenta1" element="ns0:consultaCuenta" location="../xsd/consultaCuentaCBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validacionCuenta" location="../../../../Business_Resources/validacionCuenta/ValidacionCuenta/validacionCuentaType.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaCuentaCBTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCuentaBC/xq/consultaCuentaIn/";

declare function xf:consultaCuentaIn($consultaCuenta1 as element(ns0:consultaCuenta))
    as element(ns1:validacionCuenta) {
        <ns1:validacionCuenta>
            <ACCOUNT_NUMBER>{ data($consultaCuenta1/ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
            <CHECK_CANCELLED_YES_NO>NO</CHECK_CANCELLED_YES_NO>
        </ns1:validacionCuenta>
};

declare variable $consultaCuenta1 as element(ns0:consultaCuenta) external;

xf:consultaCuentaIn($consultaCuenta1)