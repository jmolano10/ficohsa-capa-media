(:: pragma bea:global-element-parameter parameter="$consultarUltimoECResponse1" element="ns1:ConsultarUltimoECResponse" location="../Resources/TarjetaDeCredito.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:consultaEstadoCuentaTCResponse" location="consultaEstadoCuentaTCTypes.xsd" ::)

declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoCuentaTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/ConsultaEstadoCuentaTC/consultaEstadoCuentaTCOut/";

declare function local:getMoneda($codigoMoneda as xs:string?) as xs:string
{
	if ($codigoMoneda = "340") then "HNL"
	else if ($codigoMoneda = "840") then "USD" 
	else( "" )

};

declare function xf:consultaEstadoCuentaTCOut($consultarUltimoECResponse1 as element(ns1:ConsultarUltimoECResponse))
    as element(ns0:consultaEstadoCuentaTCResponse) {
        <ns0:consultaEstadoCuentaTCResponse>
            <CUSTOMER_NAME>{ data($consultarUltimoECResponse1/ns1:ConsultarUltimoECResult/ns1:nombreTitular) }</CUSTOMER_NAME>
            <MAIN_CARD_NUMBER>{ data($consultarUltimoECResponse1/ns1:ConsultarUltimoECResult/ns1:noTarjetaCreditoTitular) }</MAIN_CARD_NUMBER>
            <ACCOUNT_NUMBER>{ data($consultarUltimoECResponse1/ns1:ConsultarUltimoECResult/ns1:numeroCuenta) }</ACCOUNT_NUMBER>
            <CUTOFF_DATE>{ data($consultarUltimoECResponse1/ns1:ConsultarUltimoECResult/ns1:fechaCorte) }</CUTOFF_DATE>
            <PAYMENT_LIMIT_DATE>{ data($consultarUltimoECResponse1/ns1:ConsultarUltimoECResult/ns1:maxFechaPago) }</PAYMENT_LIMIT_DATE>
            <POINTS_AVAILABLE>{ data($consultarUltimoECResponse1/ns1:ConsultarUltimoECResult/ns1:puntosAcumulados) }</POINTS_AVAILABLE>
            {
            	for $limites in $consultarUltimoECResponse1/ns1:ConsultarUltimoECResult/ns1:saldos/ns1:ArrayOfStrucSaldosEstado
            	return
            	
            		if ( local:getMoneda($limites/ns1:moneda) = "HNL") then 
            		(
            			<LCY_PREVIOUS_BALANCE>{ data($limites/ns1:saldoAnterior) }</LCY_PREVIOUS_BALANCE>,
            			<LCY_PERIOD_BALANCE>{ data($limites/ns1:saldoCorte) }</LCY_PERIOD_BALANCE>,
            			<LCY_TOTAL_PAYMENT>{ data($limites/ns1:pagoContado) }</LCY_TOTAL_PAYMENT>,
            			<LCY_MIN_PAYMENT>{ data($limites/ns1:pagoMinimo) }</LCY_MIN_PAYMENT>,
						
						if ($limites/ns1:limiteCredito != 0) then 
						(
							<CREDIT_LIMIT>{ data($limites/ns1:limiteCredito) }</CREDIT_LIMIT>,
							<CREDIT_LIMIT_CCY>{ local:getMoneda($limites/ns1:moneda) }</CREDIT_LIMIT_CCY>
						)
						else ()
					) else if ( local:getMoneda($limites/ns1:moneda) = "USD" ) then
            		(
            			<FCY_PREVIOUS_BALANCE>{ data($limites/ns1:saldoAnterior) }</FCY_PREVIOUS_BALANCE>,
            			<FCY_PERIOD_BALANCE>{ data($limites/ns1:saldoCorte) }</FCY_PERIOD_BALANCE>,
            			<FCY_TOTAL_PAYMENT>{ data($limites/ns1:pagoContado) }</FCY_TOTAL_PAYMENT>,
            			<FCY_MIN_PAYMENT>{ data($limites/ns1:pagoMinimo) }</FCY_MIN_PAYMENT>,
						
						if ($limites/ns1:limiteCredito != 0) then 
						(
							<CREDIT_LIMIT>{ data($limites/ns1:limiteCredito) }</CREDIT_LIMIT>,
							<CREDIT_LIMIT_CCY>{ local:getMoneda($limites/ns1:moneda) }</CREDIT_LIMIT_CCY>
						)
						else ()
					) else ()
            }
            {
                for $ArrayOfItemTarjeta in $consultarUltimoECResponse1/ns1:ConsultarUltimoECResult/ns1:tarjetas/ns1:ArrayOfItemTarjeta
                return
                    <ns0:consultaEstadoCuentaTCTarjetasAdicionales>
                    	<CARD_NUMBER>{ data($ArrayOfItemTarjeta/ns1:noTarjetaCredito) }</CARD_NUMBER>
                        <CARD_HOLDER_NAME>{ data($ArrayOfItemTarjeta/ns1:nombreTarjetaHabiente) }</CARD_HOLDER_NAME>
                        <ns0:consultaEstadoCuentaTCRegistroTarjetasAdicionales>
                            {
                                for $ArrayOfItemMovimiento in $ArrayOfItemTarjeta/ns1:movimientos/ns1:ArrayOfItemMovimiento
                                return
                                    <ns0:consultaEstadoCuentaTCDetalleTarjeta>
                                    	<TRANSACTION_DATE>{ data($ArrayOfItemMovimiento/ns1:fechaTrx) }</TRANSACTION_DATE>
                                        <DESCRIPTION>{ data($ArrayOfItemMovimiento/ns1:descripcion) }</DESCRIPTION>
                                        <AMOUNT>{ data($ArrayOfItemMovimiento/ns1:montoTrx) }</AMOUNT>
                                        <CURRENCY>{ local:getMoneda(data($ArrayOfItemMovimiento/ns1:monedaTrx)) }</CURRENCY>
                                        <TYPE_OF_TRANSACTION>{ data($ArrayOfItemMovimiento/ns1:tipoMov) }</TYPE_OF_TRANSACTION>
                                        <ORIGINAL_AMOUNT>{ data($ArrayOfItemMovimiento/ns1:montoOrgnlTrx) }</ORIGINAL_AMOUNT>
                                        <ORIGINAL_CURRENCY>{ data($ArrayOfItemMovimiento/ns1:monedaOrgnlTrx) }</ORIGINAL_CURRENCY>
                                    </ns0:consultaEstadoCuentaTCDetalleTarjeta>
                            }
                        </ns0:consultaEstadoCuentaTCRegistroTarjetasAdicionales>
                    </ns0:consultaEstadoCuentaTCTarjetasAdicionales>
            }
        </ns0:consultaEstadoCuentaTCResponse>
};

declare variable $consultarUltimoECResponse1 as element(ns1:ConsultarUltimoECResponse) external;

xf:consultaEstadoCuentaTCOut($consultarUltimoECResponse1)