(:: pragma bea:global-element-parameter parameter="$pagoRemesaCreditoCuenta1" element="ns0:pagoRemesaCreditoCuenta" location="../../../../Business_Resources/remesas/PagoRemesaCreditoCuenta/pagoRemesaCreditoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoRemesaCreditoCuentaResponse" location="../../../../Business_Resources/remesas/PagoRemesaCreditoCuenta/pagoRemesaCreditoCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesaCreditoCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesaCreditoCuenta/xq/PagRemCredCtaOut/";

declare function xf:PagRemCredCtaOut($pagoRemesaCreditoCuenta1 as element(ns0:pagoRemesaCreditoCuenta))
    as element(ns0:pagoRemesaCreditoCuentaResponse) {
        <ns0:pagoRemesaCreditoCuentaResponse>
            <REMITTANCE_ID>{ data($pagoRemesaCreditoCuenta1/REMITTANCE_ID) }</REMITTANCE_ID>
        </ns0:pagoRemesaCreditoCuentaResponse>
};

declare variable $pagoRemesaCreditoCuenta1 as element(ns0:pagoRemesaCreditoCuenta) external;

xf:PagRemCredCtaOut($pagoRemesaCreditoCuenta1)