<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../Resources/ConsultarRespuestaTercero/xsd/FLINK_OSB_CONSULTAR_RPTA_TERCERO.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_CONSULTAR_RPTA_TERCERO/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/recaudos/consultaRecaudo/consultaRecaudoObtenerDealslipIn/";

(:: Equivalente a un NVL en Oracle:)
declare function if-absent 
  ( $arg as item()* ,
    $value as item()* )  as item()* {
       
    if (exists($arg))
    then $arg
    else $value
 } ;
 
(:: Realiza un replcae multiple :)
declare function replace-multi 
  ( $arg as xs:string? ,
    $changeFrom as xs:string* ,
    $changeTo as xs:string* )  as xs:string? {
       
   if (count($changeFrom) > 0)
   then replace-multi(
          replace($arg, $changeFrom[1],
                     if-absent($changeTo[1],'')),
          $changeFrom[position() > 1],
          $changeTo[position() > 1])
   else $arg
 } ;

declare function xf:consultaRecaudoObtenerDealslipIn($outputParameters as element(ns0:OutputParameters))
    as xs:string {
    	let $response := fn-bea:inlinedXML($outputParameters/ns0:RESPUESTA_TERCERO)
    	return
    		replace-multi(fn:string($response//moreParameters/data[@fieldName="dealslip"]/text()), ('&amp;amp;#61', '&amp;amp;#44'), ('=',','))
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaRecaudoObtenerDealslipIn($outputParameters)</con:xquery>
    <con:dependency location="../Resources/ConsultarRespuestaTercero/xsd/FLINK_OSB_CONSULTAR_RPTA_TERCERO.xsd">
        <con:schema ref="Middleware/Business_Resources/recaudos/Resources/ConsultarRespuestaTercero/xsd/FLINK_OSB_CONSULTAR_RPTA_TERCERO"/>
    </con:dependency>
</con:xqueryEntry>