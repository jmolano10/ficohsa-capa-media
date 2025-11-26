(:: pragma bea:global-element-parameter parameter="$consultaCuentaRetiroEfectivo1" element="ns1:consultaCuentaRetiroEfectivo" location="../xsd/consultaCuentaRetiroEfectivoCBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:validacionCuenta" location="../../../../v3/Resources/ValidacionCuenta/xsd/validacionCuentaType.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCuentaRetiroEfectivoCBTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCuentaRetiroEfectivoCB/xq/ValidacionCuentaCBRetIn/";

declare function xf:ValidacionCuentaCBRetIn($consultaCuentaRetiroEfectivo1 as element(ns1:consultaCuentaRetiroEfectivo))
    as element(ns0:validacionCuenta) {
        <ns0:validacionCuenta>
            <ACCOUNT_NUMBER>{ data($consultaCuentaRetiroEfectivo1/ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
            <CHECK_CANCELLED_YES_NO>NO</CHECK_CANCELLED_YES_NO>
        </ns0:validacionCuenta>
};

declare variable $consultaCuentaRetiroEfectivo1 as element(ns1:consultaCuentaRetiroEfectivo) external;

xf:ValidacionCuentaCBRetIn($consultaCuentaRetiroEfectivo1)