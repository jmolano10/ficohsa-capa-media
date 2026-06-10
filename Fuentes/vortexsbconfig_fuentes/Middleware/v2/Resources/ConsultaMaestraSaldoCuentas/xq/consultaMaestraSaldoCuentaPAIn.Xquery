<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMaestraSaldoCuenta" element="ns0:consultaMaestraSaldoCuenta" location="../xsd/consultaMaestraSaldoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKPA/consultaMaestraSaldoCuenta/xsd/consultaMaestraSaldoCuenta_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMaestraSaldoCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMaestraSaldoCuentas/xq/consultaMaestraSaldoCuentaPAIn/";

declare function xf:consultaMaestraSaldoCuentaPAIn($consultaMaestraSaldoCuenta as element(ns0:consultaMaestraSaldoCuenta))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:PV_ACCOUNT_NUMBER>{ data($consultaMaestraSaldoCuenta/ACCOUNT_NUMBER) }&lt;/ns1:PV_ACCOUNT_NUMBER>
        &lt;/ns1:InputParameters>
};

declare variable $consultaMaestraSaldoCuenta as element(ns0:consultaMaestraSaldoCuenta) external;

xf:consultaMaestraSaldoCuentaPAIn($consultaMaestraSaldoCuenta)</con:xquery>
    <con:dependency location="../xsd/consultaMaestraSaldoCuentaTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaMaestraSaldoCuentas/xsd/consultaMaestraSaldoCuentaTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKPA/consultaMaestraSaldoCuenta/xsd/consultaMaestraSaldoCuenta_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKPA/consultaMaestraSaldoCuenta/xsd/consultaMaestraSaldoCuenta_sp"/>
    </con:dependency>
</con:xqueryEntry>