<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$generaTokenBilletera" element="ns0:generaTokenBilletera" location="../xsd/pagosMasivosBilleteraPuenteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:generaTokenBilletera" location="../../../BusinessServices/TENGO/PagoMasivoBilleteraPuente/xsd/PagosMasivosBilletera_1.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraPuenteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagosMasivosBilleteraPuente/xq/generaTokenBilleteraPuenteIn/";

declare function xf:generaTokenBilleteraPuenteIn($generaTokenBilletera as element(ns0:generaTokenBilletera))
    as element(ns1:generaTokenBilletera) {
        &lt;ns1:generaTokenBilletera>
            &lt;SECURITY_KEY>{ data($generaTokenBilletera/SECURITY_KEY) }&lt;/SECURITY_KEY>
        &lt;/ns1:generaTokenBilletera>
};

declare variable $generaTokenBilletera as element(ns0:generaTokenBilletera) external;

xf:generaTokenBilleteraPuenteIn($generaTokenBilletera)</con:xquery>
    <con:dependency location="../xsd/pagosMasivosBilleteraPuenteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/PagosMasivosBilleteraPuente/xsd/pagosMasivosBilleteraPuenteTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/TENGO/PagoMasivoBilleteraPuente/xsd/PagosMasivosBilletera_1.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/TENGO/PagoMasivoBilleteraPuente/xsd/PagosMasivosBilletera_1"/>
    </con:dependency>
</con:xqueryEntry>