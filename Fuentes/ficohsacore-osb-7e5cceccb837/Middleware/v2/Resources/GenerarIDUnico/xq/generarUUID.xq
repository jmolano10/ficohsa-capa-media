xquery version "1.0" encoding "Cp1252";

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GenerarIDUnico/xq/generarUUID/";

declare function xf:generarUUID()
as xs:string {
    let $uuid := fn-bea:uuid()
    return
    	fn:upper-case($uuid)
};

xf:generarUUID()
