xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)


declare function local:obtenerUUID()
as xs:string {
    let $fechaSistema := fn:current-date()
    let $mes := fn-bea:pad-left(fn:string(month-from-date($fechaSistema)) , 2, "0")
    let $dia := fn-bea:pad-left(fn:string(day-from-date($fechaSistema)), 2, "0")
    let $uuid := fn-bea:uuid()
    return
    	fn:concat($mes, $dia, $uuid)
};


local:obtenerUUID()