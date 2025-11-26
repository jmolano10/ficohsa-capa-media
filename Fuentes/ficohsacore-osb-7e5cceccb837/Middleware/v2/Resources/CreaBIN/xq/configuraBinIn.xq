(:: pragma bea:global-element-parameter parameter="$creaBIN" element="ns0:creaBIN" location="../../OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/DEBITCARD/configuraBin/xsd/configuraBin_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesTarjetaDebitoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/configuraBin";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaBIN/xq/configuraBinIn/";

declare function xf:configuraBinIn($creaBIN as element(ns0:creaBIN),
    $country as xs:string,
    $channel as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_BIN>{ data($creaBIN/BIN) }</ns1:PV_BIN>
            <ns1:PV_COMPANY>{ data($creaBIN/COMPANY) }</ns1:PV_COMPANY>
            <ns1:PV_COUNTRY>{ $country }</ns1:PV_COUNTRY>
            <ns1:PV_CHANNEL>{ $channel }</ns1:PV_CHANNEL>
        </ns1:InputParameters>
};

declare variable $creaBIN as element(ns0:creaBIN) external;
declare variable $country as xs:string external;
declare variable $channel as xs:string external;

xf:configuraBinIn($creaBIN,
    $country,
    $channel)