xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultarSaldosResponse1" element="ns1:consultarSaldosResponse" location="../../../BusinessServices/ABKGT/transaccionesTCOnline/wsdl/WSDL.asmx.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:consultaSaldosTarjetaCreditoResponse" location="../xsd/consultaSaldosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace ns1 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/consultaSaldosTCGTOnlineOut/";

declare function local:getMoneda($codigoMoneda as xs:string?) as xs:string
{
	if ($codigoMoneda = "320") then "GTQ"
	else if ($codigoMoneda = "840") then "USD" else()

};

declare function local:getPoint($pointsNegativos as xs:string, $pointsVasa as xs:string) as xs:string
{
	if($pointsNegativos = "-1") then $pointsNegativos
	else ($pointsVasa)
};

declare function xf:consultaSaldosTCGTOnlineOut($consultarSaldosResponse1 as element(ns1:consultarSaldosResponse), $puntosActualizado as xs:string)
    as element(ns0:consultaSaldosTarjetaCreditoResponse) {
        <ns0:consultaSaldosTarjetaCreditoResponse>
            {
                for $noTarjetaCreditoTitular in $consultarSaldosResponse1/ns1:consultarSaldosResult/ns1:noTarjetaCreditoTitular
                return
                    <CARD_NUMBER>{ data($noTarjetaCreditoTitular) }</CARD_NUMBER>
            }
            {
                for $nombreTitular in $consultarSaldosResponse1/ns1:consultarSaldosResult/ns1:nombreTitular
                return
                    <CARD_HOLDER_NAME>{ data($nombreTitular) }</CARD_HOLDER_NAME>
            }
            {
            	for $limites at $i in $consultarSaldosResponse1/ns1:consultarSaldosResult/ns1:saldos/ns1:ArrayOfStrucSaldosConsulta
            	return
            		if ($limites/ns1:moneda = 320) then 
            		(
            			<LCY_MIN_PAYMENT>{ data($limites/ns1:pagoMinimo) }</LCY_MIN_PAYMENT>,
						<LCY_TOTAL_PAYMENT>{ data($limites/ns1:pagoContado) }</LCY_TOTAL_PAYMENT>,
						
						if ($limites/ns1:limiteCredito != 0) then 
						(
							<CREDIT_LIMIT>{ data($limites/ns1:limiteCredito) }</CREDIT_LIMIT>,
							<CREDIT_LIMIT_CCY>{ local:getMoneda($limites/ns1:moneda) }</CREDIT_LIMIT_CCY>
						)
						else ()
					) else if ($limites/ns1:moneda = 840) then
            		(
            			<FCY_MIN_PAYMENT>{ data($limites/ns1:pagoMinimo) }</FCY_MIN_PAYMENT>,
						<FCY_TOTAL_PAYMENT>{ data($limites/ns1:pagoContado) }</FCY_TOTAL_PAYMENT>,
						
						if ($limites/ns1:limiteCredito != 0) then 
						(
							<CREDIT_LIMIT>{ data($limites/ns1:limiteCredito) }</CREDIT_LIMIT>,
							<CREDIT_LIMIT_CCY>{ local:getMoneda($limites/ns1:moneda) }</CREDIT_LIMIT_CCY>
						)
						else ()
					) else ()
            }
            {
                for $puntosAcumulados in $consultarSaldosResponse1/ns1:consultarSaldosResult/ns1:puntosAcumulados
                let $point := $puntosActualizado
                return
                    <POINTS_EARNED>{ local:getPoint($point, data($puntosAcumulados)) }</POINTS_EARNED>
            }            
            {
                for $maxFechaPago in $consultarSaldosResponse1/ns1:consultarSaldosResult/ns1:maxFechaPago
                return
                    <MAX_PAYMENT_DATE>{ data($maxFechaPago) }</MAX_PAYMENT_DATE>
            }
            {
                for $fechaUltimoCorte in $consultarSaldosResponse1/ns1:consultarSaldosResult/ns1:fechaUltimoCorte
                return
                    <LAST_CUTOFF_DATE>{ data($fechaUltimoCorte) }</LAST_CUTOFF_DATE>
            }
            <ns0:consultaSaldosTarjetaCreditoResponseType>
                {
                    for $ArrayOfStrucSaldosConsulta in $consultarSaldosResponse1/ns1:consultarSaldosResult/ns1:saldos/ns1:ArrayOfStrucSaldosConsulta
                    return
                        <ns0:consultaSaldosTarjetaCreditoResponseRecordType>
                            {
                                for $moneda in $ArrayOfStrucSaldosConsulta/ns1:moneda
                                return
                                    <CURRENCY>{ local:getMoneda(data($moneda)) }</CURRENCY>
                            }
                            {
                                for $overdue_balance in $ArrayOfStrucSaldosConsulta/ns1:saldoVencido
                                return
                                    <OVERDUE_BALANCE>{ data($overdue_balance) }</OVERDUE_BALANCE>
                            }
                            {
                                for $floating_balance in $ArrayOfStrucSaldosConsulta/ns1:saldoFlotante
                                return
                                    <FLOATING_BALANCE>{ data($floating_balance) }</FLOATING_BALANCE>
                            }
                            {
                                for $current_balance in $ArrayOfStrucSaldosConsulta/ns1:saldoActual
                                return
                                    <CURRENT_BALANCE>{ data($current_balance) }</CURRENT_BALANCE>
                            }
                            {
                                for $purchases_limit in $ArrayOfStrucSaldosConsulta/ns1:disponibleCompras
                                return
                                    <PURCHASES_LIMIT>{ data($purchases_limit) }</PURCHASES_LIMIT>
                            }
                            {
                                for $withdrawal_limit in $ArrayOfStrucSaldosConsulta/ns1:disponibleRetiros
                                return
                                    <WITHDRAWAL_LIMIT>{ data($withdrawal_limit) }</WITHDRAWAL_LIMIT>
                            }
                            {
                                for $payments_today in $ArrayOfStrucSaldosConsulta/ns1:pagosDia
                                return
                                    <PAYMENTS_TODAY>{ data($payments_today) }</PAYMENTS_TODAY>
                            }
                        </ns0:consultaSaldosTarjetaCreditoResponseRecordType>
                }
            </ns0:consultaSaldosTarjetaCreditoResponseType>
        </ns0:consultaSaldosTarjetaCreditoResponse>
};

declare variable $consultarSaldosResponse1 as element(ns1:consultarSaldosResponse) external;
declare variable $puntosActualizado as xs:string external; 

xf:consultaSaldosTCGTOnlineOut($consultarSaldosResponse1, $puntosActualizado)