(:: pragma bea:global-element-parameter parameter="$opBuscarFechaSistemaRespuesta" element="ns1:opBuscarFechaSistemaRespuesta" location="../../../BusinessServices/CTS/generalService/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns2:consultaFechaSistemaResponse" location="../../../../Business_Resources/Core/consultaFechaSistema/consultaFechaSistemaTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaFechaSistemaTypes";
declare namespace ns1 = "http://service.srvaplcobisgenerales.ecobis.cobiscorp";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFechaSistema/xq/consultaFechaSistemaNIOut/";

declare function xf:consultaFechaSistemaNIOut($opBuscarFechaSistemaRespuesta as element(ns1:opBuscarFechaSistemaRespuesta))
	as element(ns2:consultaFechaSistemaResponse) {
		let $fecha := data($opBuscarFechaSistemaRespuesta/ns0:fechaProceso)
		let $fechaString := fn-bea:dateTime-to-string-with-format("yyyy-MM-dd", $fecha)
		let $fechaDate := xs:date($fechaString)
		let $nextDate := $fechaDate + xdt:dayTimeDuration("PT24H")		
		let $anio := fn:string(year-from-date($fechaDate))
		let $primerDia := xs:date(concat($anio,"-01-01"))
		let $daysBetween := fn-bea:pad-left((fn:string(($fechaDate - $primerDia) div xdt:dayTimeDuration("PT24H"))), 3, "0")
		return
	    	(
		        <ns2:consultaFechaSistemaResponse>
		            <ns2:consultaFechaSistemaResponseType>
		                <ns2:consultaFechaSistemaResponseRecordType>
		                    <WORKING_DATE>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd", $fecha) }</WORKING_DATE>
		                    <JULIAN_DATE>{ concat($anio,$daysBetween) }</JULIAN_DATE>
		                    <NEXT_WORKING_DATE>{ fn-bea:date-to-string-with-format("yyyyMMdd", $nextDate) }</NEXT_WORKING_DATE>
		                </ns2:consultaFechaSistemaResponseRecordType>
		            </ns2:consultaFechaSistemaResponseType>
		        </ns2:consultaFechaSistemaResponse>
	        )
};

declare variable $opBuscarFechaSistemaRespuesta as element(ns1:opBuscarFechaSistemaRespuesta) external;

xf:consultaFechaSistemaNIOut($opBuscarFechaSistemaRespuesta)