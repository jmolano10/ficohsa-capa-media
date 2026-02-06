xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../Resources/ConsultarRespuestaTercero/xsd/FLINK_OSB_CONSULTAR_RPTA_TERCERO.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_CONSULTAR_RPTA_TERCERO/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/recaudos/consultaRecaudo/consultaRecaudoObtenerDebtorNameIn/";

declare function xf:consultaRecaudoObtenerDebtorNameIn($outputParameters as element(ns0:OutputParameters))
    as xs:string {
    	let $response := fn-bea:inlinedXML($outputParameters/ns0:RESPUESTA_TERCERO)
    	return
    		fn:string($response//moreParameters/data[@fieldName="debtorName"]/text())
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaRecaudoObtenerDebtorNameIn($outputParameters)