xquery version "1.0" encoding "Cp1252";

(:: pragma bea:global-element-parameter parameter="$consultarEstadosCuentaUltimoCorteResponse1" element="ns0:ConsultarEstadosCuentaUltimoCorteResponse" location="../../../BusinessServices/ABKPA/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)
(:: pragma bea:global-element-parameter parameter="$conInfoHistoricaTCResponse" element="ns2:OutputParameters" location="../../../BusinessServices/ProcesosPA/conInfoHistoricaTC/xsd/conInfoHistoricaTC_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$conTransaccionesHistoricasResponse" element="ns1:OutputParameters" location="../../../BusinessServices/ProcesosPA/conTransaccionesHistoricas/xsd/conTransaccionesHistoricas_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaEstadoCuentaTCResponse" location="../../../../Business_Resources/tarjetaCredito/ConsultaEstadoCuentaTC/consultaEstadoCuentaTCTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoCuentaTCTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTransaccionesHistoricas";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conInfoHistoricaTC";
declare namespace ns3 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoCuentaTC/xq/consultaEstCuentaTCPAOut/";


declare function local:getMoneda($codigoMoneda as xs:string?) as xs:string
{
	if ($codigoMoneda = "590") then "PAB"
	else if ($codigoMoneda = "840") then "USD" 
	else( "" )

};

declare function xf:consultaEstCuentaTCPAOut($conInfoHistoricaTCResponse as element(ns2:OutputParameters)?,
    $conTransaccionesHistoricasResponse as element(ns1:OutputParameters)?, $consultarEstadosCuentaUltimoCorteResponse1 as element(ns3:ConsultarEstadosCuentaUltimoCorteResponse)?)
    as element(ns0:consultaEstadoCuentaTCResponse) {
    	if(not(empty($consultarEstadosCuentaUltimoCorteResponse1/*)))then(
    		for $result in $consultarEstadosCuentaUltimoCorteResponse1/ns3:ConsultarEstadosCuentaUltimoCorteResult
    		return
    		<ns0:consultaEstadoCuentaTCResponse>
    		<CUSTOMER_NAME>{ data($result/ns3:nombreTitular) }</CUSTOMER_NAME>
    		<MAIN_CARD_NUMBER>{ data($result/ns3:noTarjetaCreditoTitular) }</MAIN_CARD_NUMBER>
    		<ACCOUNT_NUMBER>{ data($result/ns3:numeroCuenta) }</ACCOUNT_NUMBER>
    		<CUTOFF_DATE>{ data($result/ns3:fechaCorte) }</CUTOFF_DATE>
    		<PAYMENT_LIMIT_DATE>{ data($result/ns3:maxFechaPago) }</PAYMENT_LIMIT_DATE>
    		{
            	for $limites in $result/ns3:saldos/ns3:ArrayOfStrucSaldosEstado
            	return
            	if ($limites/ns3:limiteCredito != 0) then 
						(
							<CREDIT_LIMIT>{ data($limites/ns3:limiteCredito) }</CREDIT_LIMIT>,
							<CREDIT_LIMIT_CCY>{ local:getMoneda($limites/ns3:moneda) }</CREDIT_LIMIT_CCY>
						)
				else ()
            }
            <POINTS_AVAILABLE>{ data($result/ns3:puntosAcumulados) }</POINTS_AVAILABLE>
            {
            	for $limites in $result/ns3:saldos/ns3:ArrayOfStrucSaldosEstado
            	return
            	
            		if ( local:getMoneda($limites/ns3:moneda) = "PAB") then 
            		(
            			<LCY_PREVIOUS_BALANCE>{ data($limites/ns3:saldoAnterior) }</LCY_PREVIOUS_BALANCE>,
            			<LCY_PERIOD_BALANCE>{ data($limites/ns3:saldoCorte) }</LCY_PERIOD_BALANCE>,
            			<LCY_TOTAL_PAYMENT>{ data($limites/ns3:pagoContado) }</LCY_TOTAL_PAYMENT>,
            			<LCY_MIN_PAYMENT>{ data($limites/ns3:pagoMinimo) }</LCY_MIN_PAYMENT>
					) else if ( local:getMoneda($limites/ns3:moneda) = "USD" ) then
            		(
            			<FCY_PREVIOUS_BALANCE>{ data($limites/ns3:saldoAnterior) }</FCY_PREVIOUS_BALANCE>,
            			<FCY_PERIOD_BALANCE>{ data($limites/ns3:saldoCorte) }</FCY_PERIOD_BALANCE>,
            			<FCY_TOTAL_PAYMENT>{ data($limites/ns3:pagoContado) }</FCY_TOTAL_PAYMENT>,
            			<FCY_MIN_PAYMENT>{ data($limites/ns3:pagoMinimo) }</FCY_MIN_PAYMENT>
					) else ()
            }
            {
                for $ArrayOfItemTarjeta in $result/ns3:tarjetas/ns3:ArrayOfItemTarjeta
                return
                    <ns0:consultaEstadoCuentaTCTarjetasAdicionales>
                    	<CARD_NUMBER>{ data($ArrayOfItemTarjeta/ns3:noTarjetaCredito) }</CARD_NUMBER>
                        <CARD_HOLDER_NAME>{ data($ArrayOfItemTarjeta/ns3:nombreTarjetaHabiente) }</CARD_HOLDER_NAME>
                        <ns0:consultaEstadoCuentaTCRegistroTarjetasAdicionales>
                            {
                                for $ArrayOfItemMovimiento in $ArrayOfItemTarjeta/ns3:movimientos/ns3:ArrayOfItemMovimiento
                                return
                                    <ns0:consultaEstadoCuentaTCDetalleTarjeta>
                                    	<TRANSACTION_DATE>{ data($ArrayOfItemMovimiento/ns3:fechaTrx) }</TRANSACTION_DATE>
                                        <DESCRIPTION>{ data($ArrayOfItemMovimiento/ns3:descripcion) }</DESCRIPTION>
                                        <AMOUNT>{ data($ArrayOfItemMovimiento/ns3:montoTrx) }</AMOUNT>
                                        <CURRENCY>{ local:getMoneda(data($ArrayOfItemMovimiento/ns3:monedaTrx)) }</CURRENCY>
                                        <TYPE_OF_TRANSACTION>{ data($ArrayOfItemMovimiento/ns3:tipoMov) }</TYPE_OF_TRANSACTION>
                                        <ORIGINAL_AMOUNT>{ data($ArrayOfItemMovimiento/ns3:montoOrgnlTrx) }</ORIGINAL_AMOUNT>
                                        <ORIGINAL_CURRENCY>{ data($ArrayOfItemMovimiento/ns3:monedaOrgnlTrx) }</ORIGINAL_CURRENCY>
                                    </ns0:consultaEstadoCuentaTCDetalleTarjeta>
                            }
                        </ns0:consultaEstadoCuentaTCRegistroTarjetasAdicionales>
                    </ns0:consultaEstadoCuentaTCTarjetasAdicionales>
            }
    		</ns0:consultaEstadoCuentaTCResponse>
	    )else(
	    	for $conInfoHistoricaTC in $conInfoHistoricaTCResponse/ns2:RowSet/ns2:Row[1]
	    	return
	    	<ns0:consultaEstadoCuentaTCResponse>
	    		<CUSTOMER_NAME>{data($conInfoHistoricaTC/ns2:Column[@name = 'account_name'])}</CUSTOMER_NAME>
	            <MAIN_CARD_NUMBER>{data($conInfoHistoricaTC/ns2:Column[@name = 'numtarjeta'])}</MAIN_CARD_NUMBER>
	            <ACCOUNT_NUMBER>{data($conInfoHistoricaTC/ns2:Column[@name = 'Account_nbr'])}</ACCOUNT_NUMBER>
	            <CUTOFF_DATE>{data($conInfoHistoricaTC/ns2:Column[@name = 'fecproxecta'])}</CUTOFF_DATE>
	            <PAYMENT_LIMIT_DATE>{string($conInfoHistoricaTC/ns2:Column[@name = 'fechamaximapago']/text())}</PAYMENT_LIMIT_DATE>
	       		<CREDIT_LIMIT>{data($conInfoHistoricaTC/ns2:Column[@name = 'CRLIM'])}</CREDIT_LIMIT>
	       		<CREDIT_LIMIT_CCY>USD</CREDIT_LIMIT_CCY>
	       		<POINTS_AVAILABLE>{data($conInfoHistoricaTC/ns2:Column[@name = 'PuntosAcumulados'])}</POINTS_AVAILABLE>
	       		<LCY_PREVIOUS_BALANCE>{data($conInfoHistoricaTC/ns2:Column[@name = 'totbalini'])}</LCY_PREVIOUS_BALANCE>
             	<LCY_PERIOD_BALANCE>{data($conInfoHistoricaTC/ns2:Column[@name = 'SaldoAlCorte'])}</LCY_PERIOD_BALANCE>
             	<LCY_TOTAL_PAYMENT>{data($conInfoHistoricaTC/ns2:Column[@name = 'actualdue'])}</LCY_TOTAL_PAYMENT>
             	<LCY_MIN_PAYMENT>{data($conInfoHistoricaTC/ns2:Column[@name = 'pagominimo'])}</LCY_MIN_PAYMENT>
	    		<ns0:consultaEstadoCuentaTCTarjetasAdicionales>
	    		{
	       		for $numeroTarjeta in fn:distinct-values($conTransaccionesHistoricasResponse/ns1:RowSet/ns1:Row/ns1:Column[@name = 'numtarjeta']/text())
		       		
		       		let $rowNumeroTarjeta := $conTransaccionesHistoricasResponse/ns1:RowSet/ns1:Row[ns1:Column[@name = 'numtarjeta']/text() = string($numeroTarjeta)][1]
	            	let $cardHolderName := string($rowNumeroTarjeta/ns1:Column[@name = 'nombreTarjetahabiente']/text())
		       		return (
		       		
		       			<CARD_NUMBER>{string($numeroTarjeta)}</CARD_NUMBER>,
		       			<CARD_HOLDER_NAME>{$cardHolderName}</CARD_HOLDER_NAME>,
		       			<ns0:consultaEstadoCuentaTCRegistroTarjetasAdicionales>
		       			{
		       				for $rowTransaccionesHistoricas in $conTransaccionesHistoricasResponse/ns1:RowSet/ns1:Row[ns1:Column[@name = 'numtarjeta']/text() = string($numeroTarjeta)]
				            return
				            (
				              <ns0:consultaEstadoCuentaTCDetalleTarjeta>
				              <TRANSACTION_DATE>{fn-bea:dateTime-to-string-with-format('yyyyMMdd', data($rowTransaccionesHistoricas/ns1:Column[@name = 'fecefectiva']))}</TRANSACTION_DATE>
				              <DESCRIPTION>{ string(data($rowTransaccionesHistoricas/ns1:Column[@name = 'descripcion']))}</DESCRIPTION>
				              <AMOUNT>{ string(data($rowTransaccionesHistoricas/ns1:Column[@name = 'monto']))}</AMOUNT>
				              <CURRENCY>{ string(data($rowTransaccionesHistoricas/ns1:Column[@name = 'CodMoneda']))}</CURRENCY>
				              <TYPE_OF_TRANSACTION>{ string(data($rowTransaccionesHistoricas/ns1:Column[@name = 'TipoMovimiento']))}</TYPE_OF_TRANSACTION>
				              <ORIGINAL_AMOUNT>{ string(data($rowTransaccionesHistoricas/ns1:Column[@name = 'MontoOriginal']))}</ORIGINAL_AMOUNT>
				              <ORIGINAL_CURRENCY>{ string(data($rowTransaccionesHistoricas/ns1:Column[@name = 'MonedaOriginal']))}</ORIGINAL_CURRENCY>
				              </ns0:consultaEstadoCuentaTCDetalleTarjeta>
				             )
		       			}
		       			</ns0:consultaEstadoCuentaTCRegistroTarjetasAdicionales>
		       	
		       		)
		       	}
		       	</ns0:consultaEstadoCuentaTCTarjetasAdicionales>
	    	</ns0:consultaEstadoCuentaTCResponse>
	    )
};

declare variable $conInfoHistoricaTCResponse as element(ns2:OutputParameters)? external;
declare variable $conTransaccionesHistoricasResponse as element(ns1:OutputParameters)? external;
declare variable $consultarEstadosCuentaUltimoCorteResponse1 as element(ns3:ConsultarEstadosCuentaUltimoCorteResponse)? external;

xf:consultaEstCuentaTCPAOut($conInfoHistoricaTCResponse,
    $conTransaccionesHistoricasResponse, $consultarEstadosCuentaUltimoCorteResponse1)