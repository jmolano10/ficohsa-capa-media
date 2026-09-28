(:: pragma bea:global-element-parameter parameter="$consultaDetalladaMovimientosCuenta" element="ns1:consultaDetalladaMovimientosCuenta" location="../Resources/consultasGeneralesCuentasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../Resources/ConsultaDetalladaMovimientosCuenta/xsd/ORA_BANK_OSB_K__CONSDETMOVSCTA_TOPLEVEL-24OSB_CON_DET_MOVS_CTA.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K__CONSDETMOVSCTA/TOPLEVEL-24OSB_CON_DET_MOVS_CTA/";
declare namespace xf = "http://tempuri.org/MiddlewareAbanks/Business_Resources/ConsultasCuenta/ConsultaDetalladaMovimientosCuenta/consultaDetalladaMovimientosCuentaIn/";

(: Devuelve verdadero si la fecha corresponde a un año bisiesto, de lo contrario devuleve falso :)
declare function is-leap-year 
  ( $date as xs:date )  as xs:boolean {
       
    for $year in xs:integer(substring(string($date),1,4))
    return ($year mod 4 = 0 and
            $year mod 100 != 0) or
            $year mod 400 = 0
 } ;
 
(: Se encarga de devolver la cantidad de dias del mes de una fecha :) 
declare function days-in-month 
  ( $date as xs:date )  as xs:integer? {
       
   if (month-from-date($date) = 2 and
       is-leap-year($date))
   then 29
   else
   (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
    [month-from-date($date)]
 } ;

(: Se encarga de convertir un date a string en formato "YYYYMMDD" :)
declare function date-to-string($fecha as xs:date) as xs:string
{
	concat(substring(xs:string($fecha), 1, 4), substring(xs:string($fecha), 6, 2), substring(xs:string($fecha), 9, 2))
};

(: Se encarga de convertir un String que representa una fecha en formato "YYYYMMDD" a date:)
declare function string-to-date($fecha as xs:string) as xs:date
{
	xs:date(concat(substring($fecha, 1, 4), "-", substring($fecha, 5, 2), "-", substring($fecha, 7, 2)))
};

(: Se encarga de calcular el primer día del mes anterior a la fecha del sistema. Devuelve la fecha como un string en formato "YYYYMMDD" :)
declare function  first-day-of-previous-month($fecha as xs:date) as xs:string
{
	 concat(year-from-date($fecha - xdt:yearMonthDuration("P1M")),  
	 		substring(xs:string($fecha - xdt:yearMonthDuration("P1M")), 6, 2), 
	 		"01")
};

(: Se encarga de calcular el último día del mes anterior a la fecha del sistema. Devuelve la fecha como un string en formato "YYYYMMDD" :)
declare function  last-day-of-previous-month($fecha as xs:date) as xs:string
{
	concat(year-from-date($fecha - xdt:yearMonthDuration("P1M")), 
	       substring(xs:string($fecha - xdt:yearMonthDuration("P1M")), 6, 2), 
	       days-in-month($fecha - xdt:yearMonthDuration("P1M")))
};

declare function xf:consultaDetalladaMovimientosCuentaIn($consultaDetalladaMovimientosCuenta as element(ns1:consultaDetalladaMovimientosCuenta),
    $currentDate as xs:string,
    $cuentaAbanks as xs:string,
    $fechaSalidaT24 as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
        {
        	if ( fn:upper-case( fn-bea:trim( data($consultaDetalladaMovimientosCuenta/ENTRY_RANGE) )) = "TODAY" ) then (
        	
	            <ns0:ACCOUNT_NUMBER>{ $cuentaAbanks }</ns0:ACCOUNT_NUMBER>,
	            <ns0:BEGIN_DATE>{ $currentDate }</ns0:BEGIN_DATE>,
	            <ns0:END_DATE>{ $currentDate }</ns0:END_DATE>
	            
	    	) else if ( fn:upper-case( fn-bea:trim( data($consultaDetalladaMovimientosCuenta/ENTRY_RANGE) )) = "LAST_STMT" ) then (
	    		
	    		<ns0:ACCOUNT_NUMBER>{ $cuentaAbanks }</ns0:ACCOUNT_NUMBER>,
	            <ns0:BEGIN_DATE>{ first-day-of-previous-month( string-to-date($currentDate) ) }</ns0:BEGIN_DATE>,
	            if(data($consultaDetalladaMovimientosCuenta/END_DATE) < $fechaSalidaT24)then (
	            	<ns0:END_DATE>{ data($consultaDetalladaMovimientosCuenta/END_DATE) }</ns0:END_DATE>
	            ) else (
	            	<ns0:END_DATE>{ concat(substring(data($consultaDetalladaMovimientosCuenta/END_DATE), 1, 7),1) }</ns0:END_DATE>
	            )
	    	
	    	) else if ( fn:upper-case( fn-bea:trim( data($consultaDetalladaMovimientosCuenta/ENTRY_RANGE) )) = "FREE_RANGE" ) then (
	            
	            <ns0:ACCOUNT_NUMBER>{ $cuentaAbanks }</ns0:ACCOUNT_NUMBER>,
	            <ns0:BEGIN_DATE>{ data($consultaDetalladaMovimientosCuenta/BEGIN_DATE) }</ns0:BEGIN_DATE>,
	            if(data($consultaDetalladaMovimientosCuenta/END_DATE) < $fechaSalidaT24)then (
	            	<ns0:END_DATE>{ data($consultaDetalladaMovimientosCuenta/END_DATE) }</ns0:END_DATE>
	            ) else (
	            	<ns0:END_DATE>{ concat(substring(data($consultaDetalladaMovimientosCuenta/END_DATE), 1, 7),1) }</ns0:END_DATE>
	            )
	            	    	
	    	) else ()
        }
        </ns0:InputParameters>
};

declare variable $consultaDetalladaMovimientosCuenta as element(ns1:consultaDetalladaMovimientosCuenta) external;
declare variable $currentDate as xs:string external;
declare variable $cuentaAbanks as xs:string external;
declare variable $fechaSalidaT24 as xs:string external;

xf:consultaDetalladaMovimientosCuentaIn($consultaDetalladaMovimientosCuenta,
    $currentDate,
    $cuentaAbanks,
    $fechaSalidaT24)