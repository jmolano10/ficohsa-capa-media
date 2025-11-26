xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../xsds/Recaudos/ConsultarRespuestaTercero/FLINK_OSB_CONSULTAR_RPTA_TERCERO.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudo/obtenerDealslipIn/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_CONSULTAR_RPTA_TERCERO/";

declare function xf:obtenerDealslipIn($outputParameters as element(ns0:OutputParameters))
    as xs:string {
    	let $response := fn-bea:inlinedXML($outputParameters/ns0:RESPUESTA_TERCERO)
    	return
    		fn:string($response//moreParameters/data[@fieldName="dealslip"]/text())
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:obtenerDealslipIn($outputParameters)