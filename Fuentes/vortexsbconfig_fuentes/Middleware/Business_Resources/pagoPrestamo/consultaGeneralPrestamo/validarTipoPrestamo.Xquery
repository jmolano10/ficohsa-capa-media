<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
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

xf:validarTipoPrestamo($NumeroPrestamo)</con:xquery>
</con:xqueryEntry>