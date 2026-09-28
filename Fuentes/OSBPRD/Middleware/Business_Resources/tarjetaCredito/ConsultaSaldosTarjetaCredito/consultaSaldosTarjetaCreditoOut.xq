(:: pragma bea:global-element-parameter parameter="$consultarSaldosResponse1" element="ns0:consultarSaldosResponse" location="../Resources/TarjetaDeCredito.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:consultaSaldosTarjetaCreditoResponse" location="consultaSaldosTarjetaCreditoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoOut/";

declare function local:getMoneda($codigoMoneda as xs:string?) as xs:string
{
	if ($codigoMoneda = "340") then "HNL"
	else if ($codigoMoneda = "840") then "USD" else()

};

declare function xf:consultaSaldosTarjetaCreditoOut($consultarSaldosResponse1 as element(ns0:consultarSaldosResponse))
    as element(ns1:consultaSaldosTarjetaCreditoResponse) {
        if (fn:string($consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:estatusConfirmacion/text()) = ("0","00") and 
        	fn:string($consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:nombreTitular/text()) != "" ) then ( 
	        <ns1:consultaSaldosTarjetaCreditoResponse>
	            {
	                for $noTarjetaCreditoTitular in $consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:noTarjetaCreditoTitular
	                return
	                    <CARD_NUMBER>{ data($noTarjetaCreditoTitular) }</CARD_NUMBER>
	            }
	            {
	                for $nombreTitular in $consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:nombreTitular
	                return
	                    <CARD_HOLDER_NAME>{ data($nombreTitular) }</CARD_HOLDER_NAME>
	            }
	            {
	            	for $limites at $i in $consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:saldos/ns0:ArrayOfStrucSaldosConsulta
	            	return
	            		if ($limites/ns0:moneda = 340) then 
	            		(
	            			<LCY_MIN_PAYMENT>{ data($limites/ns0:pagoMinimo) }</LCY_MIN_PAYMENT>,
							<LCY_TOTAL_PAYMENT>{ data($limites/ns0:pagoContado) }</LCY_TOTAL_PAYMENT>
						) else if ($limites/ns0:moneda = 840) then
	            		(
	            			<FCY_MIN_PAYMENT>{ data($limites/ns0:pagoMinimo) }</FCY_MIN_PAYMENT>,
							<FCY_TOTAL_PAYMENT>{ data($limites/ns0:pagoContado) }</FCY_TOTAL_PAYMENT>
						) else ()
	            }
	            {
	            	let $limitCount := fn:count($consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:saldos/ns0:ArrayOfStrucSaldosConsulta[ns0:limiteCredito != 0]/ns0:limiteCredito)
	            	return 
	            	if ( $limitCount = 0) then (
	            		<CREDIT_LIMIT>0</CREDIT_LIMIT>,
		            	<CREDIT_LIMIT_CCY>HNL</CREDIT_LIMIT_CCY>
		            ) else if ($limitCount = 1) then (
		            	<CREDIT_LIMIT>{ fn:string($consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:saldos/ns0:ArrayOfStrucSaldosConsulta[ns0:limiteCredito != 0]/ns0:limiteCredito/text()) }</CREDIT_LIMIT>,
		            	<CREDIT_LIMIT_CCY>{ local:getMoneda(fn:string($consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:saldos/ns0:ArrayOfStrucSaldosConsulta[ns0:limiteCredito != 0]/ns0:moneda/text())) }</CREDIT_LIMIT_CCY>
		            ) else (
		            	<CREDIT_LIMIT>{ fn:string($consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:saldos/ns0:ArrayOfStrucSaldosConsulta[ns0:moneda = 840]/ns0:limiteCredito/text()) }</CREDIT_LIMIT>,
		            	<CREDIT_LIMIT_CCY>{ local:getMoneda(fn:string($consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:saldos/ns0:ArrayOfStrucSaldosConsulta[ns0:moneda = 840]/ns0:moneda/text())) }</CREDIT_LIMIT_CCY>
		            )
	            }
	            {
	                for $puntosAcumulados in $consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:puntosAcumulados
	                return
	                    <POINTS_EARNED>{ data($puntosAcumulados) }</POINTS_EARNED>
	            }
	            {
	                for $maxFechaPago in $consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:maxFechaPago
	                return
	                    <MAX_PAYMENT_DATE>{ data($maxFechaPago) }</MAX_PAYMENT_DATE>
	            }
	            {
	                for $fechaUltimoCorte in $consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:fechaUltimoCorte
	                return
	                    <LAST_CUTOFF_DATE>{ data($fechaUltimoCorte) }</LAST_CUTOFF_DATE>
	            }
	            <ns1:consultaSaldosTarjetaCreditoResponseType>
	                {
	                    for $ArrayOfStrucSaldosConsulta in $consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:saldos/ns0:ArrayOfStrucSaldosConsulta
	                    return
	                        <ns1:consultaSaldosTarjetaCreditoResponseRecordType>
	                            {
	                                for $moneda in $ArrayOfStrucSaldosConsulta/ns0:moneda
	                                return
	                                    <CURRENCY>{ local:getMoneda(data($moneda)) }</CURRENCY>
	                            }
	                            {
	                                for $overdue_balance in $ArrayOfStrucSaldosConsulta/ns0:saldoVencido
	                                return
	                                    <OVERDUE_BALANCE>{ data($overdue_balance) }</OVERDUE_BALANCE>
	                            }
	                            {
	                                for $floating_balance in $ArrayOfStrucSaldosConsulta/ns0:saldoFlotante
	                                return
	                                    <FLOATING_BALANCE>{ data($floating_balance) }</FLOATING_BALANCE>
	                            }
	                            {
	                                for $current_balance in $ArrayOfStrucSaldosConsulta/ns0:saldoActual
	                                return
	                                    <CURRENT_BALANCE>{ data($current_balance) }</CURRENT_BALANCE>
	                            }
	                            {
	                                for $purchases_limit in $ArrayOfStrucSaldosConsulta/ns0:disponibleCompras
	                                return
	                                    <PURCHASES_LIMIT>{ data($purchases_limit) }</PURCHASES_LIMIT>
	                            }
	                            {
	                                for $withdrawal_limit in $ArrayOfStrucSaldosConsulta/ns0:disponibleRetiros
	                                return
	                                    <WITHDRAWAL_LIMIT>{ data($withdrawal_limit) }</WITHDRAWAL_LIMIT>
	                            }
	                            {
	                                for $payments_today in $ArrayOfStrucSaldosConsulta/ns0:pagosDia
	                                return
	                                    <PAYMENTS_TODAY>{ data($payments_today) }</PAYMENTS_TODAY>
	                            }                         
	                        </ns1:consultaSaldosTarjetaCreditoResponseRecordType>
	                }
	            </ns1:consultaSaldosTarjetaCreditoResponseType>
	        </ns1:consultaSaldosTarjetaCreditoResponse>
	    ) else (
	    	<ns1:consultaSaldosTarjetaCreditoResponse/>
	    )
};

declare variable $consultarSaldosResponse1 as element(ns0:consultarSaldosResponse) external;
declare variable $limite as xs:int external;

xf:consultaSaldosTarjetaCreditoOut($consultarSaldosResponse1)