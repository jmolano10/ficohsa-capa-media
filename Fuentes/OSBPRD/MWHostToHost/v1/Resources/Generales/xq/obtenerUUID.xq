xquery version "1.0" encoding "Cp1252";

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/general/UUID/obtenerUUID/";

declare function xf:obtenerUUID()
as xs:string {
    let $fechaSistema := fn:current-date()
    let $mes := fn-bea:pad-left(fn:string(month-from-date($fechaSistema)) , 2, "0")
    let $dia := fn-bea:pad-left(fn:string(day-from-date($fechaSistema)), 2, "0")
    let $uuid := fn-bea:uuid()
    return
    	fn:concat($mes, $dia, $uuid)
};


xf:obtenerUUID()