declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoPrestamo/consultaGeneralPrestamo/validarTipoPrestamo/";

declare function xf:validarTipoPrestamo($NumeroPrestamo as xs:string)
    as xs:string {
        if (fn:substring($NumeroPrestamo,1,2) = "AA") then (
        	"T24"
        ) else if (fn:string(fn:number($NumeroPrestamo)) != 'NaN') then (
        	"ABANKS"
        ) else (
        	"ERROR"
        )
};

declare variable $NumeroPrestamo as xs:string external;

xf:validarTipoPrestamo($NumeroPrestamo)