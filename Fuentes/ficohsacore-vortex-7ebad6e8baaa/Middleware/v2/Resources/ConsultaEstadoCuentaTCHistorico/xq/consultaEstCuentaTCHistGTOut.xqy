xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$estadosCuentaHistoricoResponse1" element="ns0:EstadosCuentaHistoricoResponse" location="../../../BusinessServices/ABKGT/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:consultaEstadoCuentaTCHistoricoResponse" location="../../../../Business_Resources/tarjetaCredito/ConsultaEstadoCuentaTCHistorico/consultaEstadoCuentaTCHistoricoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaEstadoCuentaTCHistorico/xq/consultaEstadoCuentaTCHistoricoOut/";
declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoCuentaTCHistoricoTypes";

declare function local:getMoneda($codigoMoneda as xs:string?) as xs:string
{
	if ($codigoMoneda = "320") then "GTQ"
	else if ($codigoMoneda = "840") then "USD" 
	else( "" )

};

declare function xf:consultaEstadoCuentaTCHistoricoOut($estadosCuentaHistoricoResponse1 as element(ns0:EstadosCuentaHistoricoResponse))
    as element(ns1:consultaEstadoCuentaTCHistoricoResponse) {
        	<ns1:consultaEstadoCuentaTCHistoricoResponse>
				{
					for $nombreTitular in $estadosCuentaHistoricoResponse1/ns0:EstadosCuentaHistoricoResult/ns0:nombreTitular
					return
						<CUSTOMER_NAME>{ data($nombreTitular) }</CUSTOMER_NAME>
				}
				{
					for $noTarjetaCreditoTitular in $estadosCuentaHistoricoResponse1/ns0:EstadosCuentaHistoricoResult/ns0:noTarjetaCreditoTitular
					return
						<MAIN_CARD_NUMBER>{ data($noTarjetaCreditoTitular) }</MAIN_CARD_NUMBER>
				}
				{
					for $numeroCuenta in $estadosCuentaHistoricoResponse1/ns0:EstadosCuentaHistoricoResult/ns0:numeroCuenta
					return
						<ACCOUNT_NUMBER>{ data($numeroCuenta) }</ACCOUNT_NUMBER>
				}
				{
					for $fechaCorte in $estadosCuentaHistoricoResponse1/ns0:EstadosCuentaHistoricoResult/ns0:fechaCorte
					return
						<CUTOFF_DATE>{ data($fechaCorte) }</CUTOFF_DATE>
				}
				{
					for $maxFechaPago in $estadosCuentaHistoricoResponse1/ns0:EstadosCuentaHistoricoResult/ns0:maxFechaPago
					return
						<PAYMENT_LIMIT_DATE>{ data($maxFechaPago) }</PAYMENT_LIMIT_DATE>
				}
				{
					if( data($estadosCuentaHistoricoResponse1/ns0:EstadosCuentaHistoricoResult/ns0:saldos/ns0:ArrayOfStrucSaldosEstado[1]/ns0:limiteCredito) != 0) then (
						<CREDIT_LIMIT>{ data($estadosCuentaHistoricoResponse1/ns0:EstadosCuentaHistoricoResult/ns0:saldos/ns0:ArrayOfStrucSaldosEstado[1]/ns0:limiteCredito) }</CREDIT_LIMIT>,
						<CREDIT_LIMIT_CCY>{ local:getMoneda(data($estadosCuentaHistoricoResponse1/ns0:EstadosCuentaHistoricoResult/ns0:saldos/ns0:ArrayOfStrucSaldosEstado[1]/ns0:moneda)) }</CREDIT_LIMIT_CCY>
					) else (
						<CREDIT_LIMIT>{ data($estadosCuentaHistoricoResponse1/ns0:EstadosCuentaHistoricoResult/ns0:saldos/ns0:ArrayOfStrucSaldosEstado[2]/ns0:limiteCredito) }</CREDIT_LIMIT>,
						<CREDIT_LIMIT_CCY>{ local:getMoneda(data($estadosCuentaHistoricoResponse1/ns0:EstadosCuentaHistoricoResult/ns0:saldos/ns0:ArrayOfStrucSaldosEstado[2]/ns0:moneda)) }</CREDIT_LIMIT_CCY>
					)
				}
				<POINTS_AVAILABLE>{ data($estadosCuentaHistoricoResponse1/ns0:EstadosCuentaHistoricoResult/ns0:puntosAcumulados) }</POINTS_AVAILABLE>
				<LCY_PREVIOUS_BALANCE>{ data($estadosCuentaHistoricoResponse1/ns0:EstadosCuentaHistoricoResult/ns0:saldos/ns0:ArrayOfStrucSaldosEstado[1]/ns0:saldoAnterior) }</LCY_PREVIOUS_BALANCE>
				<LCY_PERIOD_BALANCE>{ data($estadosCuentaHistoricoResponse1/ns0:EstadosCuentaHistoricoResult/ns0:saldos/ns0:ArrayOfStrucSaldosEstado[1]/ns0:saldoCorte) }</LCY_PERIOD_BALANCE>
				<LCY_TOTAL_PAYMENT>{ data($estadosCuentaHistoricoResponse1/ns0:EstadosCuentaHistoricoResult/ns0:saldos/ns0:ArrayOfStrucSaldosEstado[1]/ns0:pagoContado) }</LCY_TOTAL_PAYMENT>
				<LCY_MIN_PAYMENT>{ data($estadosCuentaHistoricoResponse1/ns0:EstadosCuentaHistoricoResult/ns0:saldos/ns0:ArrayOfStrucSaldosEstado[1]/ns0:pagoMinimo) }</LCY_MIN_PAYMENT>
				<FCY_PREVIOUS_BALANCE>{ data($estadosCuentaHistoricoResponse1/ns0:EstadosCuentaHistoricoResult/ns0:saldos/ns0:ArrayOfStrucSaldosEstado[2]/ns0:saldoAnterior) }</FCY_PREVIOUS_BALANCE>
				<FCY_PERIOD_BALANCE>{ data($estadosCuentaHistoricoResponse1/ns0:EstadosCuentaHistoricoResult/ns0:saldos/ns0:ArrayOfStrucSaldosEstado[2]/ns0:saldoCorte) }</FCY_PERIOD_BALANCE>
				<FCY_TOTAL_PAYMENT>{ data($estadosCuentaHistoricoResponse1/ns0:EstadosCuentaHistoricoResult/ns0:saldos/ns0:ArrayOfStrucSaldosEstado[2]/ns0:pagoContado) }</FCY_TOTAL_PAYMENT>
				<FCY_MIN_PAYMENT>{ data($estadosCuentaHistoricoResponse1/ns0:EstadosCuentaHistoricoResult/ns0:saldos/ns0:ArrayOfStrucSaldosEstado[2]/ns0:pagoMinimo) }</FCY_MIN_PAYMENT>
				{
					for $ArrayOfItemTarjeta in $estadosCuentaHistoricoResponse1/ns0:EstadosCuentaHistoricoResult/ns0:tarjetas/ns0:ArrayOfItemTarjeta
					return
						<ns1:consultaEstadoCuentaTCTarjetasAdicionales>
							{
								for $noTarjetaCredito in $ArrayOfItemTarjeta/ns0:noTarjetaCredito
								return
									<CARD_NUMBER>{ data($noTarjetaCredito) }</CARD_NUMBER>
							}
							{
								for $nombreTarjetaHabiente in $ArrayOfItemTarjeta/ns0:nombreTarjetaHabiente
								return
									<CARD_HOLDER_NAME>{ data($nombreTarjetaHabiente) }</CARD_HOLDER_NAME>
							}
							{
								for $movimientos in $ArrayOfItemTarjeta/ns0:movimientos
								return
									<ns1:consultaEstadoCuentaTCHistoricoRegistroTarjetasAdicionales>
										{
											for $ArrayOfItemMovimiento in $movimientos/ns0:ArrayOfItemMovimiento
											return
												<ns1:consultaEstadoCuentaTCHistoricoDetalleTarjeta>
													{
														for $fechaTrx in $ArrayOfItemMovimiento/ns0:fechaTrx
														return
															<TRANSACTION_DATE>{ data($fechaTrx) }</TRANSACTION_DATE>
													}
													{
														for $descripcion in $ArrayOfItemMovimiento/ns0:descripcion
														return
															<DESCRIPTION>{ data($descripcion) }</DESCRIPTION>
													}
															<AMOUNT>{ data($ArrayOfItemMovimiento/ns0:montoTrx) }</AMOUNT>
													{
														for $monedaTrx in $ArrayOfItemMovimiento/ns0:monedaTrx
														return
															<CURRENCY>{ local:getMoneda($monedaTrx) }</CURRENCY>
													}
													{
														for $tipoMov in $ArrayOfItemMovimiento/ns0:tipoMov
														return
															<TYPE_OF_TRANSACTION>{ data($tipoMov) }</TYPE_OF_TRANSACTION>
													}
													{
														for $montoOrig in $ArrayOfItemMovimiento/ns0:montoOrgnlTrx
														return
															<ORIGINAL_AMOUNT>{ data($montoOrig) }</ORIGINAL_AMOUNT>
													}
													{
														for $monedaOrgnlTrx in $ArrayOfItemMovimiento/ns0:monedaOrgnlTrx
														return
															<ORIGINAL_CURRENCY>{ local:getMoneda($monedaOrgnlTrx) }</ORIGINAL_CURRENCY>
													}                                                                                                
												</ns1:consultaEstadoCuentaTCHistoricoDetalleTarjeta>
										}
									</ns1:consultaEstadoCuentaTCHistoricoRegistroTarjetasAdicionales>
							}
						</ns1:consultaEstadoCuentaTCTarjetasAdicionales>
				}
			</ns1:consultaEstadoCuentaTCHistoricoResponse>
};

declare variable $estadosCuentaHistoricoResponse1 as element(ns0:EstadosCuentaHistoricoResponse) external;

xf:consultaEstadoCuentaTCHistoricoOut($estadosCuentaHistoricoResponse1)