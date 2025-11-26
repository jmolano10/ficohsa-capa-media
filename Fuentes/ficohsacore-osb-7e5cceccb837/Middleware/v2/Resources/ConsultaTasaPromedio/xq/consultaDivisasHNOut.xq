xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ConsultaTasaPromedio/xsd/fxConsultaDivisas_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaTasaPromedioResponse" location="../xsd/consultaTasaPromedioTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTasaPromedio/xq/consultaDivisasHNOut/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/fxConsultaDivisas";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaPromedioTypes";

declare function xf:consultaDivisasHNOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:consultaTasaPromedioResponse) {
         <ns1:consultaTasaPromedioResponse>
        {
        	let $rowSet := $outputParameters1/ns0:RowSet[1]
        	for $Row in $rowSet/ns0:Row
			    return(
			    <BADGE>
			       <TRANSACTION_TYPE>{ string($Row/ns0:Column[@name = 'TIPO_TXN']/text()) }</TRANSACTION_TYPE>
				   <CURRENT_VOLUME>{ string($Row/ns0:Column[@name = 'VOLUMEN_DIA']/text()) }</CURRENT_VOLUME>
				   <AVERAGE_RATE>{ string($Row/ns0:Column[@name = 'TASA_PROMEDIO_DIA']/text()) }</AVERAGE_RATE>
				   <RATE_DATE>{ fn-bea:date-from-dateTime(data($Row/ns0:Column[@name = 'FECHA'])) }</RATE_DATE>
		        </BADGE>
               ) 	
		}
        </ns1:consultaTasaPromedioResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaDivisasHNOut($outputParameters1)
