xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/DBConnectionProcesosHNBS";
(:: import schema at "../Schemas/DBConnectionProcesosHNBS_sp.xsd" ::)


declare function local:conTarjetaAnteriorTC($org as xs:string,
    $numeroTarjeta as xs:string,
    $codigoPais as xs:string,
    $month as xs:string,
    $year as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $codigoPais }</ns0:Pais>
            <ns0:NumCard>{ $numeroTarjeta }</ns0:NumCard>
            {
              if($month != '')then (
                <ns0:Mes>{ data($month) }</ns0:Mes>
              )else ()
            }
            {
              if($year != '')then (
                <ns0:Anio>{ data($year) }</ns0:Anio>
              )else ()
            }
        </ns0:InputParameters>
}; 

declare variable $org as xs:string external;
declare variable $numeroTarjeta as xs:string external;
declare variable $codigoPais as xs:string external;
declare variable $month as xs:string external;
declare variable $year as xs:string external;

local:conTarjetaAnteriorTC($org,
    $numeroTarjeta,
    $codigoPais,
    $month,
    $year)