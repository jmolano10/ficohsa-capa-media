(:: pragma bea:global-element-parameter parameter="$pagoSeguro1" element="ns0:pagoSeguro" location="../xsd/pagoSeguroTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ConsultaUltimoMovimientoCuenta/xsd/ConsultaUltimoMovimientoCuenta_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaUltimoMovimientoCuenta";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoSeguroTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoSeguros/xq/consultaUltimoMovimientoCuenta/";

declare function xf:consultaUltimoMovimientoCuenta($pagoSeguro1 as element(ns0:pagoSeguro))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CUENTA>{ data($pagoSeguro1/DEBIT_ACCOUNT) }</ns1:PV_CUENTA>
        </ns1:InputParameters>
};

declare variable $pagoSeguro1 as element(ns0:pagoSeguro) external;

xf:consultaUltimoMovimientoCuenta($pagoSeguro1)