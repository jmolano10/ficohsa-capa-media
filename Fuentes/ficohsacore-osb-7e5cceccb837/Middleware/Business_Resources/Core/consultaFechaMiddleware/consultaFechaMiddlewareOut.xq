(:: pragma bea:global-element-return element="ns0:consultaFechaSistemaResponse" location="consultaFechaSistemaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaFechaSistemaTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaFechaMiddleware/consultaFechaMiddlewareOut/";

declare function xf:consultaFechaMiddlewareOut()
as element(ns0:consultaFechaSistemaResponse) {
	let $fechaSistema := fn:current-date()
	let $anio := fn:string(year-from-date($fechaSistema))
	let $mes := fn-bea:pad-left(fn:string(month-from-date($fechaSistema)) , 2, "0")
	let $dia := fn-bea:pad-left(fn:string(day-from-date($fechaSistema)), 2, "0")
	let $sfechaSistema := fn:current-date() + xdt:dayTimeDuration("PT24H")
	let $sanio := fn:string(year-from-date($sfechaSistema))
	let $smes := fn-bea:pad-left(fn:string(month-from-date($sfechaSistema)) , 2, "0")
	let $sdia := fn-bea:pad-left(fn:string(day-from-date($sfechaSistema)), 2, "0")
	let $primerDia := xs:date(concat($anio,"-01-01"))
	let $daysBetween := fn-bea:pad-left( (fn:string(($fechaSistema - $primerDia) div xdt:dayTimeDuration("PT24H"))), 3, "0")    
	return
    	(
		    <ns0:consultaFechaSistemaResponse>
		        <ns0:consultaFechaSistemaResponseType>
		            <ns0:consultaFechaSistemaResponseRecordType>
		                <WORKING_DATE>{ concat($anio,$mes,$dia) }</WORKING_DATE>
		                <JULIAN_DATE>{ concat($anio,$daysBetween) }</JULIAN_DATE>
		                <NEXT_WORKING_DATE>{ concat($sanio,$smes,$sdia) }</NEXT_WORKING_DATE>
		            </ns0:consultaFechaSistemaResponseRecordType>
		        </ns0:consultaFechaSistemaResponseType>
		    </ns0:consultaFechaSistemaResponse>
	    )
};


xf:consultaFechaMiddlewareOut()