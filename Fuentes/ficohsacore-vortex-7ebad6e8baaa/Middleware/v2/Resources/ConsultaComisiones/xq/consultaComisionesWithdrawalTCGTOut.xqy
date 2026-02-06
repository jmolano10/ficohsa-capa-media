xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaComisionesResponse" location="../xsd/consultaComisionesTypes.xsd" ::)


declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComisiones/xq/consultaComisionesWithDrawalTCGTOut/";

declare function xf:consultaComisionesWithDrawalTCGTOut($currency as xs:string,
    $amount as xs:string,
    $percent as xs:string)
    as element(ns0:consultaComisionesResponse) {
    		let $result := xs:decimal($amount) * (xs:decimal($percent) div 100)
    	return
        <ns0:consultaComisionesResponse>
            <CURRENCY>{ $currency }</CURRENCY>
            <AMOUNT>{ round-half-to-even($result, 2) }</AMOUNT>
        </ns0:consultaComisionesResponse>
};

declare variable $currency as xs:string external;
declare variable $amount as xs:string external;
declare variable $percent as xs:string external;

xf:consultaComisionesWithDrawalTCGTOut($currency,
    $amount,
    $percent)