xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ProcesosHN/conTarjetaAnteriorTC/xsd/conTarjetaAnteriorTC_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTarjetaAnteriorTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesosHN/xq/conTarjetaAnteriorTC/";

declare function xf:conTarjetaAnteriorTC($org as xs:string,
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

xf:conTarjetaAnteriorTC($org,
    $numeroTarjeta,
    $codigoPais,
    $month,
    $year)