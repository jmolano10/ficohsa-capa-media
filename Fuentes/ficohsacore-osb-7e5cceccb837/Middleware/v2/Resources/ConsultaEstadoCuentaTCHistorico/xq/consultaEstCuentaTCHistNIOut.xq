<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[(:: pragma bea:global-element-parameter parameter="$conInfoHistoricaTCResponse" element="ns2:OutputParameters" location="../../../BusinessServices/MasterData/conInfoHistoricaTC/xsd/conInfoHistoricaTC_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$conTransaccionesHistoricas" element="ns0:OutputParameters" location="../../../BusinessServices/MasterData/conTransaccionesHistoricas/xsd/conTransaccionesHistoricas_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaEstadoCuentaTCHistoricoResponse" location="../../../../Business_Resources/tarjetaCredito/ConsultaEstadoCuentaTCHistorico/consultaEstadoCuentaTCHistoricoTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTransaccionesHistoricas";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conInfoHistoricaTC";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoCuentaTCHistoricoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoCuentaTCHistorico/xq/consultaEstCuentaTCHistNIOut/";

declare function round2decimals($item as item()?) as xs:double?
{
	if(string($item) != '')then(
		round-half-to-even(xs:decimal($item), 2)
	)else(0.0)
	
};



declare function xf:consultaEstCuentaTCHistNIOut($conInfoHistoricaTCResponse as element(ns2:OutputParameters),
    $conTransaccionesHistoricas as element(ns0:OutputParameters))
    as element(ns1:consultaEstadoCuentaTCHistoricoResponse) {
        <ns1:consultaEstadoCuentaTCHistoricoResponse>
      	{
      		<CUSTOMER_NAME>{ data($conInfoHistoricaTCResponse/ns2:RowSet/ns2:Row[1]/ns2:Column[@name= 'account_name']) }</CUSTOMER_NAME>,
	        <MAIN_CARD_NUMBER>{ data($conInfoHistoricaTCResponse/ns2:RowSet/ns2:Row[1]/ns2:Column[@name= 'numtarjeta']) }</MAIN_CARD_NUMBER>,
	        <ACCOUNT_NUMBER>{ data($conInfoHistoricaTCResponse/ns2:RowSet/ns2:Row[1]/ns2:Column[@name= 'Account_nbr']) }</ACCOUNT_NUMBER>,
	        <CUTOFF_DATE>{ data($conInfoHistoricaTCResponse/ns2:RowSet/ns2:Row[1]/ns2:Column[@name= 'fecproxecta']) }</CUTOFF_DATE>,
	        <PAYMENT_LIMIT_DATE>{ data($conInfoHistoricaTCResponse/ns2:RowSet/ns2:Row[1]/ns2:Column[@name= 'fechamaximapago']) }</PAYMENT_LIMIT_DATE>,
            let $rowInfoHistoricaUsd := $conInfoHistoricaTCResponse/ns2:RowSet/ns2:Row[ns2:Column[@name = 'CodMoneda']/text() = 'USD']
            let $controlRowUsd := count($rowInfoHistoricaUsd/*) 
            let $rowInfoHistoricaLocal := $conInfoHistoricaTCResponse/ns2:RowSet/ns2:Row[ns2:Column[@name = 'CodMoneda']/text() = 'NIO']
            let $controlRowLocal := count($rowInfoHistoricaLocal/*)
            let $PointAvailable := data($rowInfoHistoricaUsd/ns2:Column[@name= 'PuntosAcumulados'])
            let $LCYPreviousBalance := round2decimals(data($rowInfoHistoricaLocal/ns2:Column[@name = 'totbalini']))
            let $LCYPeriodBalance := data($rowInfoHistoricaLocal/ns2:Column[@name = 'SaldoAlCorte'])
            let $LCYTotalPayment := round2decimals(data($rowInfoHistoricaLocal/ns2:Column[@name = 'actualdue']))
            let $LCYMinPayment := round2decimals(data($rowInfoHistoricaLocal/ns2:Column[@name = 'pagominimo']))
            let $FCYPreviousBalance := round2decimals(data($rowInfoHistoricaUsd/ns2:Column[@name = 'totbalini']))
            let $FCYPeriodBalance := data($rowInfoHistoricaUsd/ns2:Column[@name = 'SaldoAlCorte'])
            let $FCYTotalPayment := round2decimals(data($rowInfoHistoricaUsd/ns2:Column[@name = 'actualdue']))
            let $FCYMinPayment := round2decimals(data($rowInfoHistoricaUsd/ns2:Column[@name = 'pagominimo']))   
            return(
	            if($controlRowUsd > 0 and $controlRowLocal > 0) then(
	            	<CREDIT_LIMIT>{round2decimals(data($rowInfoHistoricaUsd/ns2:Column[@name = 'CRLIM']))}</CREDIT_LIMIT>,
	            	<CREDIT_LIMIT_CCY>USD</CREDIT_LIMIT_CCY>,
	            	if($PointAvailable != '')then (
		            <POINTS_AVAILABLE>{data(xs:int(fn:floor($PointAvailable)))}</POINTS_AVAILABLE>
		       		 )else(), 
	            	<LCY_PREVIOUS_BALANCE>{$LCYPreviousBalance}</LCY_PREVIOUS_BALANCE>,
	            	if($LCYPeriodBalance != '') then (
	                	<LCY_PERIOD_BALANCE>{$LCYPeriodBalance}</LCY_PERIOD_BALANCE>
	            	)else(),
	            	<LCY_TOTAL_PAYMENT>{$LCYTotalPayment}</LCY_TOTAL_PAYMENT>,
	            	<LCY_MIN_PAYMENT>{$LCYMinPayment}</LCY_MIN_PAYMENT>,
	            	<FCY_PREVIOUS_BALANCE>{$FCYPreviousBalance}</FCY_PREVIOUS_BALANCE>,
	            	if($FCYPeriodBalance != '') then (
                		<FCY_PERIOD_BALANCE>{$FCYPeriodBalance}</FCY_PERIOD_BALANCE>
                	)else(),
                	<FCY_TOTAL_PAYMENT>{$FCYTotalPayment}</FCY_TOTAL_PAYMENT>,
                	<FCY_MIN_PAYMENT>{$FCYMinPayment}</FCY_MIN_PAYMENT>
	
	            )else 
	            	if($controlRowLocal > 0) then(
	            	<CREDIT_LIMIT>{$rowInfoHistoricaLocal/ns2:Column[@name = 'CRLIM']}</CREDIT_LIMIT>,
	            	<CREDIT_LIMIT_CCY>NIO</CREDIT_LIMIT_CCY>,
	            	<LCY_PREVIOUS_BALANCE>{$LCYPreviousBalance}</LCY_PREVIOUS_BALANCE>,
	            	if($LCYPeriodBalance != '') then (
	                	<LCY_PERIOD_BALANCE>{$LCYPeriodBalance}</LCY_PERIOD_BALANCE>
	            	)else(),
	            	<LCY_TOTAL_PAYMENT>{$LCYTotalPayment}</LCY_TOTAL_PAYMENT>,
	            	<LCY_MIN_PAYMENT>{$LCYMinPayment}</LCY_MIN_PAYMENT>
	            	
	            )else
	            	if($controlRowUsd > 0) then(
	            		<CREDIT_LIMIT>{$rowInfoHistoricaUsd/ns2:Column[@name = 'CRLIM']}</CREDIT_LIMIT>,
	            		<CREDIT_LIMIT_CCY>USD</CREDIT_LIMIT_CCY>,
	            		if($PointAvailable != '')then (
		            		<POINTS_AVAILABLE>{xs:int(fn:floor($PointAvailable))}</POINTS_AVAILABLE>
		       		 	)else(),
		       		 	<FCY_PREVIOUS_BALANCE>{$FCYPreviousBalance}</FCY_PREVIOUS_BALANCE>,
		       		 	if($FCYPeriodBalance != '') then (
                		<FCY_PERIOD_BALANCE>{$FCYPeriodBalance}</FCY_PERIOD_BALANCE>
                		)else(),
                		<FCY_TOTAL_PAYMENT>{$FCYTotalPayment}</FCY_TOTAL_PAYMENT>,
                		<FCY_MIN_PAYMENT>{$FCYMinPayment}</FCY_MIN_PAYMENT>
	            	)else()
	            )

        }
        
        {
		 	for $card_number in distinct-values ($conTransaccionesHistoricas/ns0:RowSet/ns0:Row/ns0:Column[@name='numtarjeta']/text())
	        let $rowNumeroTarjeta := $conTransaccionesHistoricas/ns0:RowSet/ns0:Row[ns0:Column[@name = 'numtarjeta']/text() = string($card_number)][1]
            let $cardHolderName := string($rowNumeroTarjeta/ns0:Column[@name = 'nombreTarjetahabiente']/text())
	        	return(
	        			<ns1:consultaEstadoCuentaTCTarjetasAdicionales> 
	        				<CARD_NUMBER>{$card_number}</CARD_NUMBER>
	        				<CARD_HOLDER_NAME>{$cardHolderName}</CARD_HOLDER_NAME>
						<ns1:consultaEstadoCuentaTCHistoricoRegistroTarjetasAdicionales>
	        			{
		        			for $mov in $conTransaccionesHistoricas/ns0:RowSet/ns0:Row[ns0:Column[@name = 'numtarjeta']/text() = $card_number ]
								return
								(											
									<ns1:consultaEstadoCuentaTCHistoricoDetalleTarjeta>																
										<TRANSACTION_DATE>{fn-bea:dateTime-to-string-with-format('yyyyMMdd', data($mov/ns0:Column[@name = 'fecefectiva']))}</TRANSACTION_DATE>			
										<DESCRIPTION>{string(data($mov/ns0:Column[@name = 'descripcion']))}</DESCRIPTION>		
										<AMOUNT>{round2decimals(data($mov/ns0:Column[@name = 'monto']))}</AMOUNT>															
										<CURRENCY>{string(data($mov/ns0:Column[@name = 'CodMoneda']))}</CURRENCY>									
										<TYPE_OF_TRANSACTION>{string(data($mov/ns0:Column[@name = 'TipoMovimiento']))}</TYPE_OF_TRANSACTION>																
										<ORIGINAL_AMOUNT>{round2decimals(string(data($mov/ns0:Column[@name = 'MontoOriginal'])))}</ORIGINAL_AMOUNT>																
										<ORIGINAL_CURRENCY>{string(data($mov/ns0:Column[@name = 'MonedaOriginal']))}</ORIGINAL_CURRENCY>
										<TRANSACTION_CODE>{string(data($mov/ns0:Column[@name = 'codtxn']))}</TRANSACTION_CODE>																																					
									</ns1:consultaEstadoCuentaTCHistoricoDetalleTarjeta>
								)	
					   }																	
						
						</ns1:consultaEstadoCuentaTCHistoricoRegistroTarjetasAdicionales>		
	        			</ns1:consultaEstadoCuentaTCTarjetasAdicionales>
	        		)
	   }
   	 </ns1:consultaEstadoCuentaTCHistoricoResponse>
};

declare variable $conInfoHistoricaTCResponse as element(ns2:OutputParameters) external;
declare variable $conTransaccionesHistoricas as element(ns0:OutputParameters) external;

xf:consultaEstCuentaTCHistNIOut($conInfoHistoricaTCResponse,
    $conTransaccionesHistoricas)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/MasterData/conInfoHistoricaTC/xsd/conInfoHistoricaTC_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MasterData/conInfoHistoricaTC/xsd/conInfoHistoricaTC_sp"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/MasterData/conTransaccionesHistoricas/xsd/conTransaccionesHistoricas_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MasterData/conTransaccionesHistoricas/xsd/conTransaccionesHistoricas_sp"/>
    </con:dependency>
    <con:dependency location="../../../../Business_Resources/tarjetaCredito/ConsultaEstadoCuentaTCHistorico/consultaEstadoCuentaTCHistoricoTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/tarjetaCredito/ConsultaEstadoCuentaTCHistorico/consultaEstadoCuentaTCHistoricoTypes"/>
    </con:dependency>
</con:xqueryEntry>