xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$estadosCuentaHistoricoResponse" element="ns3:EstadosCuentaHistoricoResponse" location="../../../BusinessServices/ABKPA/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)
(:: pragma bea:global-element-parameter parameter="$conInfoHistoricaOut" element="ns1:OutputParameters" location="../../../BusinessServices/ProcesosPA/conInfoHistoricaTC/xsd/conInfoHistoricaTC_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$conTransaccionesHistoricasOut" element="ns0:OutputParameters" location="../../../BusinessServices/ProcesosPA/conTransaccionesHistoricas/xsd/conTransaccionesHistoricas_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:consultaEstadoCuentaTCHistoricoResponse" location="../../../../Business_Resources/tarjetaCredito/ConsultaEstadoCuentaTCHistorico/consultaEstadoCuentaTCHistoricoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoCuentaTCHistorico/xq/conEstadoCuentaTCHisPAOut/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoCuentaTCHistoricoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conInfoHistoricaTC";
declare namespace ns3 = "http://alcance.local/wsinfotarjetas/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTransaccionesHistoricas";

declare function local:getMoneda($codigoMoneda as xs:string?) as xs:string
{
	if ($codigoMoneda = "590") then "PAB"
	else if ($codigoMoneda = "840") then "USD" 
	else( "" )

};

declare function xf:conEstadoCuentaTCHisPAOut($estadosCuentaHistoricoResponse as element(ns3:EstadosCuentaHistoricoResponse)?,
    $conInfoHistoricaOut as element(ns1:OutputParameters)?,
    $conTransaccionesHistoricasOut as element(ns0:OutputParameters)?)
    as element(ns2:consultaEstadoCuentaTCHistoricoResponse) {
        <ns2:consultaEstadoCuentaTCHistoricoResponse>
        {
        	if(not(empty($estadosCuentaHistoricoResponse/*)))then(
        		for $estadoCuentaTCHist in $estadosCuentaHistoricoResponse/ns3:EstadosCuentaHistoricoResult
        		return(
	        		<CUSTOMER_NAME> { data($estadoCuentaTCHist/ns3:nombreTitular) } </CUSTOMER_NAME>,
					<MAIN_CARD_NUMBER> { data($estadoCuentaTCHist/ns3:noTarjetaCreditoTitular) } </MAIN_CARD_NUMBER>,
					<ACCOUNT_NUMBER> {data($estadoCuentaTCHist/ns3:numeroCuenta) } </ACCOUNT_NUMBER>,
					<CUTOFF_DATE>{ data($estadoCuentaTCHist/ns3:fechaCorte) }</CUTOFF_DATE>,
					<PAYMENT_LIMIT_DATE>{ data($estadoCuentaTCHist/ns3:maxFechaPago) }</PAYMENT_LIMIT_DATE>,
					if( data($estadoCuentaTCHist/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[1]/ns3:limiteCredito) != 0) then (
						<CREDIT_LIMIT>{ data($estadoCuentaTCHist/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[1]/ns3:limiteCredito) }</CREDIT_LIMIT>,
						<CREDIT_LIMIT_CCY>{ local:getMoneda(data($estadoCuentaTCHist/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[1]/ns3:moneda)) }</CREDIT_LIMIT_CCY>
					) else (
						<CREDIT_LIMIT>{ data($estadoCuentaTCHist/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[2]/ns3:limiteCredito) }</CREDIT_LIMIT>,
						<CREDIT_LIMIT_CCY>{ local:getMoneda(data($estadoCuentaTCHist/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[2]/ns3:moneda)) }</CREDIT_LIMIT_CCY>
					),
					<POINTS_AVAILABLE>{ data($estadoCuentaTCHist/ns3:puntosAcumulados) }</POINTS_AVAILABLE>,
					<LCY_PREVIOUS_BALANCE>{ data($estadoCuentaTCHist/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[1]/ns3:saldoAnterior) }</LCY_PREVIOUS_BALANCE>,
					<LCY_PERIOD_BALANCE>{ data($estadoCuentaTCHist/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[1]/ns3:saldoCorte) }</LCY_PERIOD_BALANCE>,
					<LCY_TOTAL_PAYMENT>{ data($estadoCuentaTCHist/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[1]/ns3:pagoContado) }</LCY_TOTAL_PAYMENT>,
					<LCY_MIN_PAYMENT>{ data($estadoCuentaTCHist/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[1]/ns3:pagoMinimo) }</LCY_MIN_PAYMENT>,
					<FCY_PREVIOUS_BALANCE>{ data($estadoCuentaTCHist/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[2]/ns3:saldoAnterior) }</FCY_PREVIOUS_BALANCE>,
					<FCY_PERIOD_BALANCE>{ data($estadoCuentaTCHist/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[2]/ns3:saldoCorte) }</FCY_PERIOD_BALANCE>,
					<FCY_TOTAL_PAYMENT>{ data($estadoCuentaTCHist/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[2]/ns3:pagoContado) }</FCY_TOTAL_PAYMENT>,
					<FCY_MIN_PAYMENT>{ data($estadoCuentaTCHist/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[2]/ns3:pagoMinimo) }</FCY_MIN_PAYMENT>,
			    	
	                for $ArrayOfItemTarjeta in $estadoCuentaTCHist/ns3:tarjetas/ns3:ArrayOfItemTarjeta
	                return
	                    <ns2:consultaEstadoCuentaTCTarjetasAdicionales>
	                        {
	                            for $noTarjetaCredito in $ArrayOfItemTarjeta/ns3:noTarjetaCredito
	                            return
	                                <CARD_NUMBER>{ data($noTarjetaCredito) }</CARD_NUMBER>
	                        }
	                        {
	                            for $nombreTarjetaHabiente in $ArrayOfItemTarjeta/ns3:nombreTarjetaHabiente
	                            return
	                                <CARD_HOLDER_NAME>{ data($nombreTarjetaHabiente) }</CARD_HOLDER_NAME>
	                        }
	                        {
	                            for $movimientos in $ArrayOfItemTarjeta/ns3:movimientos
	                            return
	                                <ns2:consultaEstadoCuentaTCHistoricoRegistroTarjetasAdicionales>
	                                    {
	                                        for $ArrayOfItemMovimiento in $movimientos/ns3:ArrayOfItemMovimiento
	                                        return
	                                            <ns2:consultaEstadoCuentaTCHistoricoDetalleTarjeta>
	                                                <TRANSACTION_DATE>{ data($ArrayOfItemMovimiento/ns3:fechaTrx) }</TRANSACTION_DATE>
	                                                <DESCRIPTION>{ data($ArrayOfItemMovimiento/ns3:descripcion) }</DESCRIPTION>
	                                                <AMOUNT>{ data($ArrayOfItemMovimiento/ns3:montoTrx) }</AMOUNT>
	                                                <CURRENCY>{ local:getMoneda($ArrayOfItemMovimiento/ns3:monedaTrx) }</CURRENCY>
	                                           		<TYPE_OF_TRANSACTION>{ data($ArrayOfItemMovimiento/ns3:tipoMov) }</TYPE_OF_TRANSACTION>
	                                               	<ORIGINAL_AMOUNT>{ data($ArrayOfItemMovimiento/ns3:montoOrgnlTrx) }</ORIGINAL_AMOUNT>
	                                              	<ORIGINAL_CURRENCY>{ data($ArrayOfItemMovimiento/ns3:monedaOrgnlTrx) }</ORIGINAL_CURRENCY>
	                                                                                                                                                                                      </ns2:consultaEstadoCuentaTCHistoricoDetalleTarjeta>
	                                    }
	                                </ns2:consultaEstadoCuentaTCHistoricoRegistroTarjetasAdicionales>
	                        	}
	                    </ns2:consultaEstadoCuentaTCTarjetasAdicionales>            
        	)
        	)else()
        }
        {
      	  	if(not(empty($conInfoHistoricaOut/*)) or not(empty($conTransaccionesHistoricasOut/*)))then(
      	  		for $conInfoHistorica in $conInfoHistoricaOut/ns1:RowSet/ns1:Row[1]
      	  		return(
	        	    <CUSTOMER_NAME> { data($conInfoHistorica/ns1:Column[lower-case(@name) = 'account_name']) } </CUSTOMER_NAME>,
					<MAIN_CARD_NUMBER> { data($conInfoHistorica/ns1:Column[lower-case(@name) = 'numtarjeta'])} </MAIN_CARD_NUMBER>,
					<ACCOUNT_NUMBER> { data($conInfoHistorica/ns1:Column[lower-case(@name) = 'account_nbr']) } </ACCOUNT_NUMBER>,
					
					<CUTOFF_DATE>{ data($conInfoHistorica/ns1:Column[lower-case(@name) = 'fecproxecta']) }</CUTOFF_DATE>,
					<PAYMENT_LIMIT_DATE>{ data($conInfoHistorica/ns1:Column[lower-case(@name) = 'fechamaximapago']) }</PAYMENT_LIMIT_DATE>,
					
					<CREDIT_LIMIT>{ data($conInfoHistorica/ns1:Column[lower-case(@name) = 'crlim']) }</CREDIT_LIMIT>,
					<CREDIT_LIMIT_CCY>{ data($conInfoHistorica/ns1:Column[lower-case(@name) = 'codmoneda']) }</CREDIT_LIMIT_CCY>,
					<POINTS_AVAILABLE>{ data(xs:int(fn:floor($conInfoHistorica/ns1:Column[lower-case(@name) = 'puntosacumulados']))) }</POINTS_AVAILABLE>,
					<LCY_PREVIOUS_BALANCE>{ data($conInfoHistorica/ns1:Column[lower-case(@name) = 'totbalini']) }</LCY_PREVIOUS_BALANCE>,
					<LCY_PERIOD_BALANCE>{ data($conInfoHistorica/ns1:Column[lower-case(@name) = 'saldoalcorte']) }</LCY_PERIOD_BALANCE>,
					<LCY_TOTAL_PAYMENT>{ data($conInfoHistorica/ns1:Column[lower-case(@name) = 'actualdue']) }</LCY_TOTAL_PAYMENT>,
					<LCY_MIN_PAYMENT>{ data($conInfoHistorica/ns1:Column[lower-case(@name) = 'pagominimo']) }</LCY_MIN_PAYMENT>,
					<FCY_PREVIOUS_BALANCE>{ data($conInfoHistorica/ns1:Column[lower-case(@name) = 'totbalini']) }</FCY_PREVIOUS_BALANCE>,
					<FCY_PERIOD_BALANCE>{ data($conInfoHistorica/ns1:Column[lower-case(@name) = 'saldoalcorte']) }</FCY_PERIOD_BALANCE>,
					<FCY_TOTAL_PAYMENT>{ data($conInfoHistorica/ns1:Column[lower-case(@name) = 'actualdue']) }</FCY_TOTAL_PAYMENT>,
					<FCY_MIN_PAYMENT>{ data($conInfoHistorica/ns1:Column[lower-case(@name) = 'pagominimo']) }</FCY_MIN_PAYMENT>,    	
			    	for $card_number in distinct-values ($conTransaccionesHistoricasOut/ns0:RowSet/ns0:Row/ns0:Column[@name='numtarjeta']/text())
			    	let $rowNumeroTarjeta := $conTransaccionesHistoricasOut/ns0:RowSet/ns0:Row[ns0:Column[@name = 'numtarjeta']/text() = string($card_number)][1]
			    	let $cardHolderName := string($rowNumeroTarjeta/ns0:Column[lower-case(@name) = 'nombretarjetahabiente']/text())
					return(
			    		<ns2:consultaEstadoCuentaTCTarjetasAdicionales>
			    		<CARD_NUMBER>{ $card_number }</CARD_NUMBER>
				        <CARD_HOLDER_NAME>{ $cardHolderName }</CARD_HOLDER_NAME>
				       	<ns2:consultaEstadoCuentaTCHistoricoRegistroTarjetasAdicionales>
				       	{
				       		for $mov in $conTransaccionesHistoricasOut/ns0:RowSet/ns0:Row[ns0:Column[@name = 'numtarjeta']/text() = $card_number ]
								return
								(
					        		<ns2:consultaEstadoCuentaTCHistoricoDetalleTarjeta>
					        			<TRANSACTION_DATE>{ fn-bea:dateTime-to-string-with-format('yyyyMMdd',data($mov/ns0:Column[lower-case(@name) = 'fecefectiva'])) }</TRANSACTION_DATE>
					        			<DESCRIPTION>{ data($mov/ns0:Column[lower-case(@name) = 'descripcion']) }</DESCRIPTION>
					        			<AMOUNT>{ data($mov/ns0:Column[lower-case(@name) = 'monto']) }</AMOUNT>
					        			<CURRENCY> {data($mov/ns0:Column[lower-case(@name) = 'codmoneda']) }</CURRENCY>
					        			<TYPE_OF_TRANSACTION>{ data($mov/ns0:Column[lower-case(@name) = 'tipomovimiento']) }</TYPE_OF_TRANSACTION>
					        			<ORIGINAL_AMOUNT>{ data($mov/ns0:Column[lower-case(@name) = 'montooriginal']) }</ORIGINAL_AMOUNT>
					        			<ORIGINAL_CURRENCY>{ data($mov/ns0:Column[lower-case(@name) = 'monedaoriginal']) }</ORIGINAL_CURRENCY>
					        			<TRANSACTION_POST_DATE>{ fn-bea:dateTime-to-string-with-format('yyyyMMdd',data($mov/ns0:Column[lower-case(@name) = 'fecposteo'])) }</TRANSACTION_POST_DATE>
					        			<TRANSACTION_CODE>{ data($mov/ns0:Column[lower-case(@name) = 'codtxn']) }</TRANSACTION_CODE>
					        			<PLAN_NUMBER>{ data($mov/ns0:Column[lower-case(@name) = 'plann']) }</PLAN_NUMBER>	        			
					        		</ns2:consultaEstadoCuentaTCHistoricoDetalleTarjeta>
					        	)
					    }
				    	</ns2:consultaEstadoCuentaTCHistoricoRegistroTarjetasAdicionales>
				    	</ns2:consultaEstadoCuentaTCTarjetasAdicionales>
				    ), 		    	
			    	<BEGINNING_BALANCE>{ data($conInfoHistorica/ns1:Column[lower-case(@name) = 'saldoiinicial']) }</BEGINNING_BALANCE>,
					<DEBIT_QUANTITY>{ data($conInfoHistorica/ns1:Column[lower-case(@name) = 'cantdebitos']) }</DEBIT_QUANTITY>,
					<DEBIT_AMOUNT>{ data($conInfoHistorica/ns1:Column[lower-case(@name) = 'montodebitos']) }</DEBIT_AMOUNT>,
					<CREDIT_QUANTITY>{ data($conInfoHistorica/ns1:Column[lower-case(@name) = 'cantcreditos']) }</CREDIT_QUANTITY>,
					<CREDIT_AMOUNT>{ data($conInfoHistorica/ns1:Column[lower-case(@name) = 'montocreditos']) }</CREDIT_AMOUNT>,
					<ENDING_BALANCE>{ data($conInfoHistorica/ns1:Column[lower-case(@name) = 'saldofinal']) }</ENDING_BALANCE>
				)
        	)else(
        	
        	)
        }
  		</ns2:consultaEstadoCuentaTCHistoricoResponse>
};

declare variable $estadosCuentaHistoricoResponse as element(ns3:EstadosCuentaHistoricoResponse)? external;
declare variable $conInfoHistoricaOut as element(ns1:OutputParameters)? external;
declare variable $conTransaccionesHistoricasOut as element(ns0:OutputParameters)? external;

xf:conEstadoCuentaTCHisPAOut($estadosCuentaHistoricoResponse,
    $conInfoHistoricaOut,
    $conTransaccionesHistoricasOut)