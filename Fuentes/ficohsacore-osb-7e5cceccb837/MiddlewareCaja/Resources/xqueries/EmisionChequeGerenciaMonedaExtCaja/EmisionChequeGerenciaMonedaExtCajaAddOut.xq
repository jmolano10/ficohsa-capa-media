xquery version "1.0" encoding "Cp1252";
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/EmisionChequeGerenciaMonedaExtCaja/EmisionChequeGerenciaMonedaExtCajaAddOut/";

(: Función encargada de obtener el mes en letras:)
declare function getMonth ($month as xs:string)  as xs:string { 
	('Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio',
	'Agosto','Septiembre','Octubre','Noviembre','Diciembre')[xs:integer($month)]
};

declare function xf:EmisionChequeGerenciaMonedaExtCajaAddOut($processingDate as xs:string)
    as element(*)* {
        fn-bea:inlinedXML( concat(
	        "<PROCESSINGYEAR>", substring($processingDate, 1, 4), "</PROCESSINGYEAR>",
	        "<PROCESSINGMONTH>", fn-bea:fail-over(getMonth(substring($processingDate,5, 2)),""), "</PROCESSINGMONTH>",
	        "<PROCESSINGDAY>", substring($processingDate, 7), "</PROCESSINGDAY>")
        )
};
declare variable $processingDate as xs:string external;

xf:EmisionChequeGerenciaMonedaExtCajaAddOut($processingDate)