xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare variable $date as xs:string external;

(: Se encarga de calcular el último día del mes anterior a la fecha del sistema. Devuelve la fecha como un string en formato "YYYYMMDD" :)
declare function  local:last-day-of-previous-month($fecha as xs:date) as xs:string
{
 concat(year-from-date($fecha - xs:yearMonthDuration("P1M")), 
        substring(xs:string($fecha - xs:yearMonthDuration("P1M")), 6, 2), 
        local:days-in-month($fecha - xs:yearMonthDuration("P1M")))
};

(: Se encarga de devolver la cantidad de dias del mes de una fecha :) 
declare function local:days-in-month 
  ( $date as xs:date )  as xs:integer? {
       
   if (month-from-date($date) = 2 and
       local:is-leap-year($date))
   then 29
   else
   (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
    [month-from-date($date)]
 } ;
 
 (: Devuelve verdadero si la fecha corresponde a un año bisiesto, de lo contrario devuleve falso :)
declare function local:is-leap-year 
  ( $date as xs:date )  as xs:boolean {
       
    for $year in xs:integer(substring(string($date),1,4))
    return ($year mod 4 = 0 and
            $year mod 100 != 0) or
            $year mod 400 = 0
 } ;

(: Se encarga de convertir un String que representa una fecha en formato "YYYYMMDD" a date:)
declare function local:string-to-date($fecha as xs:string) as xs:date
{
 xs:date(concat(substring($fecha, 1, 4), "-", substring($fecha, 5, 2), "-", substring($fecha, 7, 2)))
};

declare function local:func($date as xs:string) as xs:string {
    local:last-day-of-previous-month(local:string-to-date($date))
};

local:func($date)