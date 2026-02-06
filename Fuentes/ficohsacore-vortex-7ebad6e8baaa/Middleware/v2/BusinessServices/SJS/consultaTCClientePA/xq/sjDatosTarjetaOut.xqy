xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultarSaldosVasaResponse1" element="ns1:ConsultarSaldosVasaResponse" location="../../../ABKGT/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)
(:: pragma bea:local-element-return type="ns0:ConsultaTarjetaCreditoTypeResponse/ns0:CREDIT_CARD_DETAILS/ns0:CREDIT_CARD_DETAIL" location="../../../../../Business_Resources/consultasCliente/consultaPasivosCliente/consultaTC/ConsultaTarjetaCreditoCliente.xsd" ::)

declare namespace ns1 = "http://alcance.local/wsinfotarjetas/";
declare namespace ns0 = "ConsultaTarjetaCreditoCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaTCClienteGT/xq/sjDatosTarjetaOut/";

declare function local:getMoneda($codigoMoneda as xs:string?) as xs:string
{
	if ($codigoMoneda = "840") then "USD" else()

};

declare function xf:sjDatosTarjetaOut($consultarSaldosVasaResponse1 as element(ns1:ConsultarSaldosVasaResponse))
    as element() {
        <ns0:CREDIT_CARD_DETAIL>
        	<ns0:RESPONSE_HEADER>
        		<ns0:SUCCESS_INDICATOR>
        		{
        			if (fn:string($consultarSaldosVasaResponse1/ns1:ConsultarSaldosVasaResult/ns1:estatusConfirmacion/text()) = "00") then (
        				"SUCCESS"
        			) else (
        				"ERROR"
        			)
        		}
        		</ns0:SUCCESS_INDICATOR>
        	</ns0:RESPONSE_HEADER>
        	{
        	if (fn:string($consultarSaldosVasaResponse1/ns1:ConsultarSaldosVasaResult/ns1:estatusConfirmacion/text()) = "00") then (
	            <ns0:RESPONSE_BODY>
	                {
	                    for $noTarjetaCreditoTitular in $consultarSaldosVasaResponse1/ns1:ConsultarSaldosVasaResult/ns1:noTarjetaCreditoTitular
	                    return
	                        <ns0:CARD_NUMBER>{ data($noTarjetaCreditoTitular) }</ns0:CARD_NUMBER>
	                }
	                {
	                    for $nombreTitular in $consultarSaldosVasaResponse1/ns1:ConsultarSaldosVasaResult/ns1:nombreTitular
	                    return
	                        <ns0:CARD_HOLDER_NAME>{ data($nombreTitular) }</ns0:CARD_HOLDER_NAME>
	                }
		            {
		            	for $limites at $i in $consultarSaldosVasaResponse1/ns1:ConsultarSaldosVasaResult/ns1:saldos/ns1:ArrayOfStrucSaldosConsulta
		            	return
							if ($limites/ns1:moneda = 840) then
		            		(
		            			<ns0:FCY_MIN_PAYMENT>{ data($limites/ns1:pagoMinimo) }</ns0:FCY_MIN_PAYMENT>,
								<ns0:FCY_TOTAL_PAYMENT>{ data($limites/ns1:pagoContado) }</ns0:FCY_TOTAL_PAYMENT>,
								
								if ($limites/ns1:limiteCredito != 0) then 
								(
									<ns0:CREDIT_LIMIT>{ data($limites/ns1:limiteCredito) }</ns0:CREDIT_LIMIT>,
									<ns0:CREDIT_LIMIT_CCY>{ local:getMoneda($limites/ns1:moneda) }</ns0:CREDIT_LIMIT_CCY>
								)
								else ()
							) else ()
		            }                
	                {
	                    for $puntosAcumulados in $consultarSaldosVasaResponse1/ns1:ConsultarSaldosVasaResult/ns1:puntosAcumulados
	                    return
	                        <ns0:POINTS_EARNED>{ data($puntosAcumulados) }</ns0:POINTS_EARNED>
	                }
	                {
	                    for $maxFechaPago in $consultarSaldosVasaResponse1/ns1:ConsultarSaldosVasaResult/ns1:maxFechaPago
	                    return
	                        <ns0:MAX_PAYMENT_DATE>{ data($maxFechaPago) }</ns0:MAX_PAYMENT_DATE>
	                }
	                {
	                    for $fechaUltimoCorte in $consultarSaldosVasaResponse1/ns1:ConsultarSaldosVasaResult/ns1:fechaUltimoCorte
	                    return
	                        <ns0:LAST_CUTOFF_DATE>{ data($fechaUltimoCorte) }</ns0:LAST_CUTOFF_DATE>
	                }
	                {
	                    for $saldos in $consultarSaldosVasaResponse1/ns1:ConsultarSaldosVasaResult/ns1:saldos
	                    return
	                        <ns0:BALANCE_DETAILS>
	                            {
	                                for $ArrayOfStrucSaldosConsulta in $saldos/ns1:ArrayOfStrucSaldosConsulta[ns1:limiteCredito!="0"]
	                                return
	                                    <ns0:BALANCE_DETAIL>
	                                        <ns0:CURRENCY>{ local:getMoneda(data($ArrayOfStrucSaldosConsulta/ns1:moneda)) }</ns0:CURRENCY>
	                                        <ns0:OVERDUE_BALANCE>{ data($ArrayOfStrucSaldosConsulta/ns1:saldoVencido) }</ns0:OVERDUE_BALANCE>
	                                        <ns0:FLOATING_BALANCE>{ data($ArrayOfStrucSaldosConsulta/ns1:saldoFlotante) }</ns0:FLOATING_BALANCE>
	                                        <ns0:CURRENT_BALANCE>{ data($ArrayOfStrucSaldosConsulta/ns1:saldoActual) }</ns0:CURRENT_BALANCE>
	                                        <ns0:PURCHASES_LIMIT>{ data($ArrayOfStrucSaldosConsulta/ns1:disponibleCompras) }</ns0:PURCHASES_LIMIT>
	                                        <ns0:WITHDRAWAL_LIMIT>{ data($ArrayOfStrucSaldosConsulta/ns1:disponibleRetiros) }</ns0:WITHDRAWAL_LIMIT>
	                                        <ns0:PAYMENTS_TODAY>{ data($ArrayOfStrucSaldosConsulta/ns1:pagosDia) }</ns0:PAYMENTS_TODAY>
	                                    </ns0:BALANCE_DETAIL>
										                                    
	                            }
	                        </ns0:BALANCE_DETAILS>
	                }
	            </ns0:RESPONSE_BODY>
            ) else (
            	<ns0:RESPONSE_BODY/>
            )
           	}
        </ns0:CREDIT_CARD_DETAIL>
};

declare variable $consultarSaldosVasaResponse1 as element(ns1:ConsultarSaldosVasaResponse) external;

xf:sjDatosTarjetaOut($consultarSaldosVasaResponse1)