xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadetasadecambiofcyResponse" element="ns1:ConsultadetasadecambiofcyResponse" location="../Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTasaCambioResponse" location="consultaTasaCambioTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaCambioTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaTasaCambio/consultaTasaCambioExtranjeraOut/";

declare function xf:consultaTasaCambioExtranjeraOut($source as xs:string,
    $target as xs:string,
    $consultadetasadecambiofcyResponse as element(ns1:ConsultadetasadecambiofcyResponse))
    as element(ns0:consultaTasaCambioResponse) {
        <ns0:consultaTasaCambioResponse>
        	<ns0:consultaTasaCambioResponseType>
	        	<ns0:consultaTasaCambioResponseRecordType>
		        {
		        	if( $source = "USD" and $target = "USD") then (
		        		<BUY_RATE>1</BUY_RATE>,
		        		<SELL_RATE>1</SELL_RATE>
		        	) else if( $source = "USD" ) then (
		        		let $targets := fn:tokenize($consultadetasadecambiofcyResponse/WSFCYEXCHRATEType[1]/gWSFCYEXCHRATEDetailType/mWSFCYEXCHRATEDetailType[1]/CURRENCY, "\|\|")
		        		let $buys := fn:tokenize($consultadetasadecambiofcyResponse/WSFCYEXCHRATEType[1]/gWSFCYEXCHRATEDetailType/mWSFCYEXCHRATEDetailType[1]/USDBUYRATE, "\|\|")
		        		let $sells := fn:tokenize($consultadetasadecambiofcyResponse/WSFCYEXCHRATEType[1]/gWSFCYEXCHRATEDetailType/mWSFCYEXCHRATEDetailType[1]/USDSALERATE, "\|\|")
		        		for $item at $i in $targets
		        			return
		        				if ($item = $target) then (
		        					<BUY_RATE>{ $buys[$i] }</BUY_RATE>,
		        					<SELL_RATE>{ $sells[$i] }</SELL_RATE>
		        				) else ()
		        	) else if ($target = "USD") then (
		        		let $sources := fn:tokenize($consultadetasadecambiofcyResponse/WSFCYEXCHRATEType[1]/gWSFCYEXCHRATEDetailType/mWSFCYEXCHRATEDetailType[1]/CURRENCY, "\|\|")
		        		let $buys := fn:tokenize($consultadetasadecambiofcyResponse/WSFCYEXCHRATEType[1]/gWSFCYEXCHRATEDetailType/mWSFCYEXCHRATEDetailType[1]/USDBUYRATE, "\|\|")
		        		let $sells := fn:tokenize($consultadetasadecambiofcyResponse/WSFCYEXCHRATEType[1]/gWSFCYEXCHRATEDetailType/mWSFCYEXCHRATEDetailType[1]/USDSALERATE, "\|\|")
		        		for $item at $i in $sources
		        			return
		        				if ($item = $source) then (
		        					<BUY_RATE>{ fn-bea:fail-over(round-half-to-even(1 div number($buys[$i]), 4), 0) }</BUY_RATE>,
		        					<SELL_RATE>{ fn-bea:fail-over(round-half-to-even(1 div number($sells[$i]), 4), 0) }</SELL_RATE>
		        				) else ()
		        	) else ()
		        }
		        </ns0:consultaTasaCambioResponseRecordType>
	        </ns0:consultaTasaCambioResponseType>
        </ns0:consultaTasaCambioResponse>
};

declare variable $source as xs:string external;
declare variable $target as xs:string external;
declare variable $consultadetasadecambiofcyResponse as element(ns1:ConsultadetasadecambiofcyResponse) external;

xf:consultaTasaCambioExtranjeraOut($source,
    $target,
    $consultadetasadecambiofcyResponse)