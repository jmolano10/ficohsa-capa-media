xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaComisionesResponse" location="../xsd/consultaComisionesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComisiones/xq/consultaComisionesQR/";

declare function xf:consultaComisionesQR($amount as xs:string,
    $currency as xs:string)
    as element(ns0:consultaComisionesResponse) {
        <ns0:consultaComisionesResponse>
            <CURRENCY>{ $currency }</CURRENCY>
            <AMOUNT>{ $amount }</AMOUNT>
        </ns0:consultaComisionesResponse>
};

declare variable $amount as xs:string external;
declare variable $currency as xs:string external;

xf:consultaComisionesQR($amount,
    $currency)