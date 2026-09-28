(:: pragma bea:global-element-parameter parameter="$consultaMaestraSaldoCuenta" element="ns0:consultaMaestraSaldoCuenta" location="../xsd/consultaMaestraSaldoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKPA/consultaMaestraSaldoCuenta/xsd/consultaMaestraSaldoCuenta_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMaestraSaldoCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMaestraSaldoCuentas/xq/consultaMaestraSaldoCuentaPAIn/";

declare function xf:consultaMaestraSaldoCuentaPAIn($consultaMaestraSaldoCuenta as element(ns0:consultaMaestraSaldoCuenta))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_ACCOUNT_NUMBER>{ data($consultaMaestraSaldoCuenta/ACCOUNT_NUMBER) }</ns1:PV_ACCOUNT_NUMBER>
        </ns1:InputParameters>
};

declare variable $consultaMaestraSaldoCuenta as element(ns0:consultaMaestraSaldoCuenta) external;

xf:consultaMaestraSaldoCuentaPAIn($consultaMaestraSaldoCuenta)