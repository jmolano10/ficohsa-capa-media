xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ProcesosHN/conHistorialTxVnet/xsd/conHistorialTxVnetHN_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaCargosRecurrentesHistoricosResponse" location="../xsd/consultaCargosRecurrentesHistoricosTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCargosRecurrentesHistoricos/xq/consultaCargosRecurrentesHistoricosHNOut/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conHistorialTxVnetHN";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCargosRecurrentesHistoricosTypes";

declare function getStatusDescripción($valor as xs:string) as xs:string {
	if($valor = "S") then "Aplicado"
	else if ( $valor= "N" )then "Rechazado"
	else("")				
};

declare function xf:consultaCargosRecurrentesHistoricosHNOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaCargosRecurrentesHistoricosResponse) {
        <ns1:consultaCargosRecurrentesHistoricosResponse>
    	{
    		for $totalRegistrosExistentes in $outputParameters/ns0:TotalRegistrosExistentes
    		return
    			(
    				if(string($totalRegistrosExistentes/text()) != '') then 
    				(
    					<RECORDS_TOTAL>{ data($totalRegistrosExistentes) }</RECORDS_TOTAL>
    				) else ()
    			)
    	}		
    	{
	     	for $rowMovementInformation in $outputParameters/ns0:RowSet/ns0:Row
	     	return
	     		<MOVEMENT_INFORMATION>
	     		    {
	     		    	for $commerceName in $rowMovementInformation/ns0:Column[@name = 'NombreComercio']
	     					return
	     						<COMMERCE_NAME>{data($commerceName)}</COMMERCE_NAME>
	     			}
	     			{
	     		    	for $paymentProcess in $rowMovementInformation/ns0:Column[@name = 'EstadoProcesamiento']
	     					return
	     						<MOVEMENT_STATUS>{getStatusDescripción(($paymentProcess/text()))}</MOVEMENT_STATUS> 
	     			}
	     			{
	     		    	for $transactionDate in $rowMovementInformation/ns0:Column[@name = 'FechaTransaccion']
	     					return
	     						<TRANSACTION_DATE>{fn-bea:dateTime-from-string-with-format("yyyy-MM-dd HH:mm:ss", data($transactionDate))}</TRANSACTION_DATE>
	     			}
	     			{
	     		    	for $transactionAmount in $rowMovementInformation/ns0:Column[@name = 'MontoTransaccion']
	     					return
	     						<TRANSACTION_AMOUNT>{data($transactionAmount)}</TRANSACTION_AMOUNT>
	     			}
	     			{
	     		    	for $currencyCode in $rowMovementInformation/ns0:Column[@name = 'Moneda']
	     					return
	     						<TRANSACTION_CURRENCY>{data($currencyCode)}</TRANSACTION_CURRENCY>
	     			}
	            </MOVEMENT_INFORMATION>
         }  		
    </ns1:consultaCargosRecurrentesHistoricosResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaCargosRecurrentesHistoricosHNOut($outputParameters)