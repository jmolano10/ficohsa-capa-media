xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$generaTokenBilletera" element="ns0:generaTokenBilletera" location="../xsd/pagosMasivosBilleteraPuenteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:generaTokenBilletera" location="../../../BusinessServices/TENGO/PagoMasivoBilleteraPuente/xsd/PagosMasivosBilletera_1.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraPuenteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagosMasivosBilleteraPuente/xq/generaTokenBilleteraPuenteIn/";

declare function xf:generaTokenBilleteraPuenteIn($generaTokenBilletera as element(ns0:generaTokenBilletera))
    as element(ns1:generaTokenBilletera) {
        <ns1:generaTokenBilletera>
            <SECURITY_KEY>{ data($generaTokenBilletera/SECURITY_KEY) }</SECURITY_KEY>
        </ns1:generaTokenBilletera>
};

declare variable $generaTokenBilletera as element(ns0:generaTokenBilletera) external;

xf:generaTokenBilleteraPuenteIn($generaTokenBilletera)