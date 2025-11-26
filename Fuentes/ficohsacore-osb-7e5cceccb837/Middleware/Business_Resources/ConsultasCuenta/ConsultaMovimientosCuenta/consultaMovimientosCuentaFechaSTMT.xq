xquery version "1.0" encoding "Cp1252";
(:: pragma  parameter="$date" type="xs:string" ::)
(:: pragma  type="xs:string" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaMovimientosCuenta/consultaMovimientosCuentaFechaSTMT/";

(: Se encarga de calcular el último día del mes anterior a la fecha del sistema. Devuelve la fecha como un string en formato "YYYYMMDD" :)
declare function  last-day-of-previous-month($fecha as xs:date) as xs:string
{
 concat(year-from-date($fecha - xdt:yearMonthDuration("P1M")), 
        substring(xs:string($fecha - xdt:yearMonthDuration("P1M")), 6, 2), 
        days-in-month($fecha - xdt:yearMonthDuration("P1M")))
};

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
 
 (: Devuelve verdadero si la fecha corresponde a un año bisiesto, de lo contrario devuleve falso :)
declare function is-leap-year 
  ( $date as xs:date )  as xs:boolean {
       
    for $year in xs:integer(substring(string($date),1,4))
    return ($year mod 4 = 0 and
            $year mod 100 != 0) or
            $year mod 400 = 0
 } ;

(: Se encarga de convertir un String que representa una fecha en formato "YYYYMMDD" a date:)
declare function string-to-date($fecha as xs:string) as xs:date
{
 xs:date(concat(substring($fecha, 1, 4), "-", substring($fecha, 5, 2), "-", substring($fecha, 7, 2)))
};

declare function xf:consultaMovimientosCuentaFechaSTMT($date as xs:string)
    as xs:string {
    	last-day-of-previous-month(string-to-date($date))
};

declare variable $date as xs:string external;

xf:consultaMovimientosCuentaFechaSTMT($date)