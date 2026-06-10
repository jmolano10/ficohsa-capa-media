<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ProcesosGT/conTarjetaAnteriorTC/xsd/conTarjetaAnteriorTC_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTarjetaAnteriorTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesosGT/xq/conTarjetaAnteriorTCIn/";

declare function xf:conTarjetaAnteriorTCIn($org as xs:string,
    $numeroTarjeta as xs:string,
    $codigoPais as xs:string,
    $month as xs:string,
    $year as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ data($codigoPais) }</ns0:Pais>
            <ns0:NumCard>{ data($numeroTarjeta) }</ns0:NumCard>
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

xf:conTarjetaAnteriorTCIn($org,
    $numeroTarjeta,
    $codigoPais,
    $month,
    $year)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ProcesosGT/conTarjetaAnteriorTC/xsd/conTarjetaAnteriorTC_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ProcesosGT/conTarjetaAnteriorTC/xsd/conTarjetaAnteriorTC_sp"/>
    </con:dependency>
</con:xqueryEntry>