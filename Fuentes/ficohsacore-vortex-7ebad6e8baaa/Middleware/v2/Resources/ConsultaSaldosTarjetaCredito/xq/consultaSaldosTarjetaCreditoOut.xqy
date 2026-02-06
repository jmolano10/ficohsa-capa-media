xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaSaldosTCResponse1" element="ns1:sjConsultaSaldosTCResponse" location="../../../BusinessServices/SJS/consultaSaldosTC/xsd/sjConsultaSaldosTC.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaSaldosTarjetaCreditoResponse" location="../xsd/consultaSaldosTarjetaCreditoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSaldosTC";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/consultaSaldosTarjetaCreditoOut/";

declare function local:getMoneda($codigoMoneda as xs:string?) as xs:string
{
	if ($codigoMoneda = "340") then "HNL"
	else if ($codigoMoneda = "840") then "USD" else()

};

declare function xf:consultaSaldosTarjetaCreditoOut($sjConsultaSaldosTCResponse1 as element(ns1:sjConsultaSaldosTCResponse), $puntosPlataforma as xs:string)
    as element(ns0:consultaSaldosTarjetaCreditoResponse) {
      if (fn:string($sjConsultaSaldosTCResponse1/consultarSaldosResponse/consultarSaldosResult/estatusConfirmacion/text()) = ("0","00") and
          fn:string($sjConsultaSaldosTCResponse1/consultarSaldosResponse/consultarSaldosResult/nombreTitular/text()) != "" ) then (  
        <ns0:consultaSaldosTarjetaCreditoResponse>
	            {
	                for $noTarjetaCreditoTitular in $sjConsultaSaldosTCResponse1/consultarSaldosResponse/consultarSaldosResult/noTarjetaCreditoTitular
	                return
	                    <CARD_NUMBER>{ data($noTarjetaCreditoTitular) }</CARD_NUMBER>
	            }
	            {
	                for $nombreTitular in $sjConsultaSaldosTCResponse1/consultarSaldosResponse/consultarSaldosResult/nombreTitular
	                return
	                    <CARD_HOLDER_NAME>{ data($nombreTitular) }</CARD_HOLDER_NAME>
	            }
	            {
	            	for $limites at $i in $sjConsultaSaldosTCResponse1/consultarSaldosResponse/consultarSaldosResult/saldos/ArrayOfStrucSaldosConsulta
	            	return
	            		if ($limites/moneda = 340) then 
	            		(
	            			<LCY_MIN_PAYMENT>{ data($limites/pagoMinimo) }</LCY_MIN_PAYMENT>,
							<LCY_TOTAL_PAYMENT>{ data($limites/pagoContado) }</LCY_TOTAL_PAYMENT>
						) else if ($limites/moneda = 840) then
	            		(
	            			<FCY_MIN_PAYMENT>{ data($limites/pagoMinimo) }</FCY_MIN_PAYMENT>,
							<FCY_TOTAL_PAYMENT>{ data($limites/pagoContado) }</FCY_TOTAL_PAYMENT>
						) else ()
	            }
	            {
	            	let $limitCount := fn:count($sjConsultaSaldosTCResponse1/consultarSaldosResponse/consultarSaldosResult/saldos/ArrayOfStrucSaldosConsulta[limiteCredito != 0]/limiteCredito)
	            	return 
	            	if ( $limitCount = 0) then (
	            		<CREDIT_LIMIT>0</CREDIT_LIMIT>,
		            	<CREDIT_LIMIT_CCY>HNL</CREDIT_LIMIT_CCY>
		            ) else if ($limitCount = 1) then (
		            	<CREDIT_LIMIT>{ fn:string($sjConsultaSaldosTCResponse1/consultarSaldosResponse/consultarSaldosResult/saldos/ArrayOfStrucSaldosConsulta[limiteCredito != 0]/limiteCredito/text()) }</CREDIT_LIMIT>,
		            	<CREDIT_LIMIT_CCY>{ local:getMoneda(fn:string($sjConsultaSaldosTCResponse1/consultarSaldosResponse/consultarSaldosResult/saldos/ArrayOfStrucSaldosConsulta[limiteCredito != 0]/moneda/text())) }</CREDIT_LIMIT_CCY>
		            ) else (
		            	<CREDIT_LIMIT>{ fn:string($sjConsultaSaldosTCResponse1/consultarSaldosResponse/consultarSaldosResult/saldos/ArrayOfStrucSaldosConsulta[moneda = 840]/limiteCredito/text()) }</CREDIT_LIMIT>,
		            	<CREDIT_LIMIT_CCY>{ local:getMoneda(fn:string($sjConsultaSaldosTCResponse1/consultarSaldosResponse/consultarSaldosResult/saldos/ArrayOfStrucSaldosConsulta[moneda = 840]/moneda/text())) }</CREDIT_LIMIT_CCY>
		            )
	            }
	            {
	                for $puntosAcumulados in $sjConsultaSaldosTCResponse1/consultarSaldosResponse/consultarSaldosResult/puntosAcumulados
	                return
	                 
	                 if (string-length($puntosPlataforma) = 0) then
	                    <POINTS_EARNED>{ data($puntosAcumulados) }</POINTS_EARNED>
	                 else
	                    <POINTS_EARNED>{ xs:integer(fn:number(data($puntosPlataforma))) }</POINTS_EARNED>
	                  
	            }
	            {
	                for $maxFechaPago in $sjConsultaSaldosTCResponse1/consultarSaldosResponse/consultarSaldosResult/maxFechaPago
	                return
	                    <MAX_PAYMENT_DATE>{ data($maxFechaPago) }</MAX_PAYMENT_DATE>
	            }
	            {
	                for $fechaUltimoCorte in $sjConsultaSaldosTCResponse1/consultarSaldosResponse/consultarSaldosResult/fechaUltimoCorte
	                return
	                    <LAST_CUTOFF_DATE>{ data($fechaUltimoCorte) }</LAST_CUTOFF_DATE>
	            }
	            <ns0:consultaSaldosTarjetaCreditoResponseType>
	                {
	                    for $ArrayOfStrucSaldosConsulta in $sjConsultaSaldosTCResponse1/consultarSaldosResponse/consultarSaldosResult/saldos/ArrayOfStrucSaldosConsulta
	                    return
	                        <ns0:consultaSaldosTarjetaCreditoResponseRecordType>
	                            {
	                                for $moneda in $ArrayOfStrucSaldosConsulta/moneda
	                                return
	                                    <CURRENCY>{ local:getMoneda(data($moneda)) }</CURRENCY>
	                            }
	                            {
	                                for $overdue_balance in $ArrayOfStrucSaldosConsulta/saldoVencido
	                                return
	                                    <OVERDUE_BALANCE>{ data($overdue_balance) }</OVERDUE_BALANCE>
	                            }
	                            {
	                                for $floating_balance in $ArrayOfStrucSaldosConsulta/saldoFlotante
	                                return
	                                    <FLOATING_BALANCE>{ data($floating_balance) }</FLOATING_BALANCE>
	                            }
	                            {
	                                for $current_balance in $ArrayOfStrucSaldosConsulta/saldoActual
	                                return
	                                    <CURRENT_BALANCE>{ data($current_balance) }</CURRENT_BALANCE>
	                            }
	                            {
	                                for $purchases_limit in $ArrayOfStrucSaldosConsulta/disponibleCompras
	                                return
	                                    <PURCHASES_LIMIT>{ data($purchases_limit) }</PURCHASES_LIMIT>
	                            }
	                            {
	                                for $withdrawal_limit in $ArrayOfStrucSaldosConsulta/disponibleRetiros
	                                return
	                                    <WITHDRAWAL_LIMIT>{ data($withdrawal_limit) }</WITHDRAWAL_LIMIT>
	                            }
	                            {
	                                for $payments_today in $ArrayOfStrucSaldosConsulta/pagosDia
	                                return
	                                    <PAYMENTS_TODAY>{ data($payments_today) }</PAYMENTS_TODAY>
	                            }
	                            {
	                                for $dispExtraFinanciamiento in $ArrayOfStrucSaldosConsulta/dispExtraFinanciamiento
	                                return
	                                    <AVAILABLE_EXTRA>{ data($dispExtraFinanciamiento) }</AVAILABLE_EXTRA>
	                            }	                            
	                            {
	                                for $saldoExtraFinanciamiento in $ArrayOfStrucSaldosConsulta/saldoExtraFinanciamiento
	                                return
	                                    <CURRENT_BALANCE_EXTRA>{ data($saldoExtraFinanciamiento) }</CURRENT_BALANCE_EXTRA>
	                            }
	                            {
	                                for $dispConsumoCuotas in $ArrayOfStrucSaldosConsulta/dispConsumoCuotas
	                                return
	                                    <AVAILABLE_INTRA>{ data($dispConsumoCuotas) }</AVAILABLE_INTRA>
	                            } 
	                            {
	                                for $saldoConsumoCuotas in $ArrayOfStrucSaldosConsulta/saldoConsumoCuotas
	                                return
	                                    <CURRENT_BALANCE_INTRA>{ data($saldoConsumoCuotas) }</CURRENT_BALANCE_INTRA>
	                            } 
	                        </ns0:consultaSaldosTarjetaCreditoResponseRecordType>
	                }
	            </ns0:consultaSaldosTarjetaCreditoResponseType>            
        </ns0:consultaSaldosTarjetaCreditoResponse>
	    ) else (
	    	<ns0:consultaSaldosTarjetaCreditoResponse/>
	    )        
};

declare variable $sjConsultaSaldosTCResponse1 as element(ns1:sjConsultaSaldosTCResponse) external;
declare variable $puntosPlataforma as xs:string external;

xf:consultaSaldosTarjetaCreditoOut($sjConsultaSaldosTCResponse1,$puntosPlataforma)