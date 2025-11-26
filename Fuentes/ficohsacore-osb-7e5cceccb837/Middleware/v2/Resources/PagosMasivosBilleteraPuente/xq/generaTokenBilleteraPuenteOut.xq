(:: pragma bea:global-element-parameter parameter="$generaTokenBilleteraResponse" element="ns1:generaTokenBilleteraResponse" location="../../../BusinessServices/TENGO/PagoMasivoBilleteraPuente/xsd/PagosMasivosBilletera_1.xsd" ::)
(:: pragma bea:global-element-return element="ns0:generaTokenBilleteraResponse" location="../xsd/pagosMasivosBilleteraPuenteTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraPuenteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagosMasivosBilleteraPuente/xq/generaTokenBilleteraPuenteOut/";

declare function xf:generaTokenBilleteraPuenteOut($generaTokenBilleteraResponse as element(ns1:generaTokenBilleteraResponse))
    as element(ns0:generaTokenBilleteraResponse) {
        <ns0:generaTokenBilleteraResponse>
            <SECURITY_TOKEN>{ data($generaTokenBilleteraResponse/SECURITY_TOKEN) }</SECURITY_TOKEN>
        </ns0:generaTokenBilleteraResponse>
};

declare variable $generaTokenBilleteraResponse as element(ns1:generaTokenBilleteraResponse) external;

xf:generaTokenBilleteraPuenteOut($generaTokenBilleteraResponse)
