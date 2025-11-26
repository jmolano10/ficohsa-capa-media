(:: pragma bea:global-element-return element="ns0:generaTokenBilletera" location="../../PagosMasivosBilletera/xsd/pagosMasivosBilleteraTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraTokenBilletera/xq/generaTokenProxyIn/";

declare function xf:generaTokenProxyIn($SECURITY_KEY as xs:string)
    as element(ns0:generaTokenBilletera) {
        <ns0:generaTokenBilletera>
            <SECURITY_KEY>{ $SECURITY_KEY }</SECURITY_KEY>
        </ns0:generaTokenBilletera>
};

declare variable $SECURITY_KEY as xs:string external;

xf:generaTokenProxyIn($SECURITY_KEY)
