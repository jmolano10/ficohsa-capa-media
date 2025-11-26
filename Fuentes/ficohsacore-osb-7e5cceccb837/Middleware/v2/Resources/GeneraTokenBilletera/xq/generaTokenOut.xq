(:: pragma bea:global-element-parameter parameter="$jwtTengoResponse" element="ns1:jwtTengoResponse" location="../../../BusinessServices/TENGO/PagoMasivoBilletera/xsd/Services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:generaTokenBilleteraResponse" location="../../PagosMasivosBilletera/xsd/pagosMasivosBilleteraTypes.xsd" ::)

declare namespace ns1 = "http://main/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraTokenBilletera/xq/generaTokenOut/";

declare function xf:generaTokenOut($jwtTengoResponse as element(ns1:jwtTengoResponse))
    as element(ns0:generaTokenBilleteraResponse) {
        <ns0:generaTokenBilleteraResponse>
            <SECURITY_TOKEN>{ data($jwtTengoResponse/return/toket) }</SECURITY_TOKEN>
        </ns0:generaTokenBilleteraResponse>
};

declare variable $jwtTengoResponse as element(ns1:jwtTengoResponse) external;

xf:generaTokenOut($jwtTengoResponse)
