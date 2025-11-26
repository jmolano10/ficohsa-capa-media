(:: pragma bea:global-element-parameter parameter="$consultaECHistResponse1" element="ns1:ConsultaECHistResponse" location="../Resources/TarjetaDeCredito.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:consultaEstadoCuentaTCHistoricoResponse" location="consultaEstadoCuentaTCHistoricoTypes.xsd" ::)


declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoCuentaTCHistoricoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/PagoTarjetaCredito/ConsultaEstadoCuentaTCHistorico/consultaEstadoCuentaTCHistoricoLocalOut/";

declare function local:getMoneda($codigoMoneda as xs:string?) as xs:string
{
	if ($codigoMoneda = "340") then "HNL"
	else if ($codigoMoneda = "840") then "USD" 
	else( "" )

};

declare function xf:consultaEstadoCuentaTCHistoricoLocalOut($consultaECHistResponse1 as element(ns1:ConsultaECHistResponse))
    as element(ns0:consultaEstadoCuentaTCHistoricoResponse) {
        <ns0:consultaEstadoCuentaTCHistoricoResponse>
            {
                for $nombreTitular in $consultaECHistResponse1/ns1:ConsultaECHistResult/ns1:nombreTitular
                return
                    <CUSTOMER_NAME>{ data($nombreTitular) }</CUSTOMER_NAME>
            }
            {
                for $noTarjetaCreditoTitular in $consultaECHistResponse1/ns1:ConsultaECHistResult/ns1:noTarjetaCreditoTitular
                return
                    <MAIN_CARD_NUMBER>{ data($noTarjetaCreditoTitular) }</MAIN_CARD_NUMBER>
            }
            {
                for $numeroCuenta in $consultaECHistResponse1/ns1:ConsultaECHistResult/ns1:numeroCuenta
                return
                    <ACCOUNT_NUMBER>{ data($numeroCuenta) }</ACCOUNT_NUMBER>
            }
            {
                for $fechaCorte in $consultaECHistResponse1/ns1:ConsultaECHistResult/ns1:fechaCorte
                return
                    <CUTOFF_DATE>{ data($fechaCorte) }</CUTOFF_DATE>
            }
            {
                for $maxFechaPago in $consultaECHistResponse1/ns1:ConsultaECHistResult/ns1:maxFechaPago
                return
                    <PAYMENT_LIMIT_DATE>{ data($maxFechaPago) }</PAYMENT_LIMIT_DATE>
            }
            {
            	if( data($consultaECHistResponse1/ns1:ConsultaECHistResult/ns1:saldos/ns1:ArrayOfStrucSaldosEstado[1]/ns1:limiteCredito) != 0) then (
            		<CREDIT_LIMIT>{ data($consultaECHistResponse1/ns1:ConsultaECHistResult/ns1:saldos/ns1:ArrayOfStrucSaldosEstado[1]/ns1:limiteCredito) }</CREDIT_LIMIT>,
					<CREDIT_LIMIT_CCY>{ local:getMoneda(data($consultaECHistResponse1/ns1:ConsultaECHistResult/ns1:saldos/ns1:ArrayOfStrucSaldosEstado[1]/ns1:moneda)) }</CREDIT_LIMIT_CCY>
				) else (
            		<CREDIT_LIMIT>{ data($consultaECHistResponse1/ns1:ConsultaECHistResult/ns1:saldos/ns1:ArrayOfStrucSaldosEstado[2]/ns1:limiteCredito) }</CREDIT_LIMIT>,
					<CREDIT_LIMIT_CCY>{ local:getMoneda(data($consultaECHistResponse1/ns1:ConsultaECHistResult/ns1:saldos/ns1:ArrayOfStrucSaldosEstado[2]/ns1:moneda)) }</CREDIT_LIMIT_CCY>
				)
			}
            <POINTS_AVAILABLE>{ data($consultaECHistResponse1/ns1:ConsultaECHistResult/ns1:puntosAcumulados) }</POINTS_AVAILABLE>
            <LCY_PREVIOUS_BALANCE>{ data($consultaECHistResponse1/ns1:ConsultaECHistResult/ns1:saldos/ns1:ArrayOfStrucSaldosEstado[1]/ns1:saldoAnterior) }</LCY_PREVIOUS_BALANCE>
            <LCY_PERIOD_BALANCE>{ data($consultaECHistResponse1/ns1:ConsultaECHistResult/ns1:saldos/ns1:ArrayOfStrucSaldosEstado[1]/ns1:saldoCorte) }</LCY_PERIOD_BALANCE>
            <LCY_TOTAL_PAYMENT>{ data($consultaECHistResponse1/ns1:ConsultaECHistResult/ns1:saldos/ns1:ArrayOfStrucSaldosEstado[1]/ns1:pagoContado) }</LCY_TOTAL_PAYMENT>
            <LCY_MIN_PAYMENT>{ data($consultaECHistResponse1/ns1:ConsultaECHistResult/ns1:saldos/ns1:ArrayOfStrucSaldosEstado[1]/ns1:pagoMinimo) }</LCY_MIN_PAYMENT>
            <FCY_PREVIOUS_BALANCE>{ data($consultaECHistResponse1/ns1:ConsultaECHistResult/ns1:saldos/ns1:ArrayOfStrucSaldosEstado[2]/ns1:saldoAnterior) }</FCY_PREVIOUS_BALANCE>
            <FCY_PERIOD_BALANCE>{ data($consultaECHistResponse1/ns1:ConsultaECHistResult/ns1:saldos/ns1:ArrayOfStrucSaldosEstado[2]/ns1:saldoCorte) }</FCY_PERIOD_BALANCE>
            <FCY_TOTAL_PAYMENT>{ data($consultaECHistResponse1/ns1:ConsultaECHistResult/ns1:saldos/ns1:ArrayOfStrucSaldosEstado[2]/ns1:pagoContado) }</FCY_TOTAL_PAYMENT>
            <FCY_MIN_PAYMENT>{ data($consultaECHistResponse1/ns1:ConsultaECHistResult/ns1:saldos/ns1:ArrayOfStrucSaldosEstado[2]/ns1:pagoMinimo) }</FCY_MIN_PAYMENT>
            {
                for $ArrayOfItemTarjeta in $consultaECHistResponse1/ns1:ConsultaECHistResult/ns1:tarjetas/ns1:ArrayOfItemTarjeta
                return
                    <ns0:consultaEstadoCuentaTCTarjetasAdicionales>
                        {
                            for $noTarjetaCredito in $ArrayOfItemTarjeta/ns1:noTarjetaCredito
                            return
                                <CARD_NUMBER>{ data($noTarjetaCredito) }</CARD_NUMBER>
                        }
                        {
                            for $nombreTarjetaHabiente in $ArrayOfItemTarjeta/ns1:nombreTarjetaHabiente
                            return
                                <CARD_HOLDER_NAME>{ data($nombreTarjetaHabiente) }</CARD_HOLDER_NAME>
                        }
                        {
                            for $movimientos in $ArrayOfItemTarjeta/ns1:movimientos
                            return
                                <ns0:consultaEstadoCuentaTCHistoricoRegistroTarjetasAdicionales>
                                    {
                                        for $ArrayOfItemMovimiento in $movimientos/ns1:ArrayOfItemMovimiento
                                        return
                                            <ns0:consultaEstadoCuentaTCHistoricoDetalleTarjeta>
                                                {
                                                    for $fechaTrx in $ArrayOfItemMovimiento/ns1:fechaTrx
                                                    return
                                                        <TRANSACTION_DATE>{ data($fechaTrx) }</TRANSACTION_DATE>
                                                }
                                                {
                                                    for $descripcion in $ArrayOfItemMovimiento/ns1:descripcion
                                                    return
                                                        <DESCRIPTION>{ data($descripcion) }</DESCRIPTION>
                                                }
                                                		<AMOUNT>{ data($ArrayOfItemMovimiento/ns1:montoTrx) }</AMOUNT>
                                                {
                                                    for $monedaTrx in $ArrayOfItemMovimiento/ns1:monedaTrx
                                                    return
                                                        <CURRENCY>{ local:getMoneda($monedaTrx) }</CURRENCY>
                                                }
                                                {
                                                    for $tipoMov in $ArrayOfItemMovimiento/ns1:tipoMov
                                                    return
                                                        <TYPE_OF_TRANSACTION>{ data($tipoMov) }</TYPE_OF_TRANSACTION>
                                                }
                                                {
                                                    for $montoOrig in $ArrayOfItemMovimiento/ns1:montoOrgnlTrx
                                                    return
                                                        <ORIGINAL_AMOUNT>{ data($montoOrig) }</ORIGINAL_AMOUNT>
                                                }
                                                {
                                                    for $monedaOrgnlTrx in $ArrayOfItemMovimiento/ns1:monedaOrgnlTrx
                                                    return
                                                        <ORIGINAL_CURRENCY>{ local:getMoneda($monedaOrgnlTrx) }</ORIGINAL_CURRENCY>
                                                }   
                                                                                                                                           
                                            </ns0:consultaEstadoCuentaTCHistoricoDetalleTarjeta>
                                    }
                                </ns0:consultaEstadoCuentaTCHistoricoRegistroTarjetasAdicionales>
                        }
                    </ns0:consultaEstadoCuentaTCTarjetasAdicionales>
            }
        </ns0:consultaEstadoCuentaTCHistoricoResponse>
};

declare variable $consultaECHistResponse1 as element(ns1:ConsultaECHistResponse) external;


xf:consultaEstadoCuentaTCHistoricoLocalOut($consultaECHistResponse1)