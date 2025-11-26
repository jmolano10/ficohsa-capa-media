(:: pragma bea:global-element-parameter parameter="$consultarMovsRecientesResponse1" element="ns0:ConsultarMovsRecientesResponse" location="../../../../Business_Resources/tarjetaCredito/Resources/TarjetaDeCredito.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:consultaMovimientosRecientesTCResponse" location="../../../../Business_Resources/tarjetaCredito/ConsultaMovimientosRecientesTC/consultaMovimientosRecientesTCTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../BusinessServices/VASA/ConsultaMovimientosVasaSF/xsd/ConsultaMovimientosVasaSF_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMovimientosRecientesTCTypes";
declare namespace ns0 = "http://tempuri.org/";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaMovimientosVasaSF";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/ConsultaMovimientosRecientesTC/consultaMovimientosRecientesTCOut/";


declare function local:getMoneda($codigoMoneda as xs:string?) as xs:string
{
	if ($codigoMoneda = "340") then "HNL"
	else if ($codigoMoneda = "840") then "USD" 
	else( "" )

};

declare function xf:consultaMovimientosRecientesTCOut($consultarMovsRecientesResponse1 as element(ns0:ConsultarMovsRecientesResponse),$outputParameters as element(ns2:OutputParameters))
    as element(ns1:consultaMovimientosRecientesTCResponse) {
        <ns1:consultaMovimientosRecientesTCResponse>
            <OWNER_NAME>{ data($consultarMovsRecientesResponse1/ns0:ConsultarMovsRecientesResult/ns0:nombreTitular) }</OWNER_NAME>
            <CARD_NUMBER>{ data($consultarMovsRecientesResponse1/ns0:ConsultarMovsRecientesResult/ns0:noTarjetaCreditoTitular) }</CARD_NUMBER>
            {
             	for $limites in $consultarMovsRecientesResponse1/ns0:ConsultarMovsRecientesResult/ns0:saldos/ns0:ArrayOfStrucSaldosRecientes
            	return
            		if ($limites/ns0:limiteCredito != 0) then 
            		(
							<CREDIT_LIMIT>{ data($limites/ns0:limiteCredito) }</CREDIT_LIMIT>,
							<CREDIT_LIMIT_CCY>{ local:getMoneda($limites/ns0:moneda) }</CREDIT_LIMIT_CCY>
					) 
					else ()
            }
             
            {
             	for $limites in $consultarMovsRecientesResponse1/ns0:ConsultarMovsRecientesResult/ns0:saldos/ns0:ArrayOfStrucSaldosRecientes
            	return
            		if (  local:getMoneda($limites/ns0:moneda) = "HNL") then 
            		(
            			<PREVIOUS_BALANCE_LCY>{ data($limites/ns0:saldoAnterior) }</PREVIOUS_BALANCE_LCY>
					) else if ( local:getMoneda($limites/ns0:moneda) = "USD") then
            		(
            			<PREVIOUS_BALANCE_FCY>{ data($limites/ns0:saldoAnterior) }</PREVIOUS_BALANCE_FCY>
					) else ()
            }
            {
                for $ArrayOfItemTarjeta in $consultarMovsRecientesResponse1/ns0:ConsultarMovsRecientesResult/ns0:tarjetas/ns0:ArrayOfItemTarjeta
                return
                    <ns1:consultaMovimientosRecientesTCTarjetasAdicionales>
                    	<CARD_NUMBER>{ data($ArrayOfItemTarjeta/ns0:noTarjetaCredito) }</CARD_NUMBER>
                        <CARD_HOLDER_NAME>{ data($ArrayOfItemTarjeta/ns0:nombreTarjetaHabiente) }</CARD_HOLDER_NAME>
                        <ns1:consultaMovimientosRecientesTCRegistroTarjetasAdicionales>
                        {
                            for $ArrayOfItemMovimiento in $ArrayOfItemTarjeta/ns0:movimientos/ns0:ArrayOfItemMovimiento
                            return
                                <ns1:consultaMovimientosRecientesTCDetalleTarjeta>
                                	<TRANSACTION_DATE>{ data($ArrayOfItemMovimiento/ns0:fechaTrx) }</TRANSACTION_DATE>
                                    <DESCRIPTION>{ data($ArrayOfItemMovimiento/ns0:descripcion) }</DESCRIPTION>
                                    <AMOUNT>{ data($ArrayOfItemMovimiento/ns0:montoTrx) }</AMOUNT>
                                    <CURRENCY>{ local:getMoneda(data($ArrayOfItemMovimiento/ns0:monedaTrx)) }</CURRENCY>
                                    <ORIGINAL_AMOUNT>{ data($ArrayOfItemMovimiento/ns0:montoOrgnlTrx) }</ORIGINAL_AMOUNT>
                                    <ORIGINAL_CURRENCY>{ data($ArrayOfItemMovimiento/ns0:monedaOrgnlTrx) }</ORIGINAL_CURRENCY>
                                    <TYPE_OF_TRANSACTION>{ data($ArrayOfItemMovimiento/ns0:tipoMov) }</TYPE_OF_TRANSACTION>
						            {
						            	for $row in $outputParameters/ns2:RowSet/ns2:Row
						            	return(
							            	if(string(data($row/ns2:Column[@name="NRO_COMPROBANTE"])) = string(data($ArrayOfItemMovimiento/ns0:secuenciaMov)))then(
								           		<OPERATION_CODE>{data($row/ns2:Column[@name="COD_OPERACION"])}</OPERATION_CODE>,
								           		<MOVEMENT_GROUP>{data($row/ns2:Column[@name="GROUP_MOVIMIENTO"])}</MOVEMENT_GROUP>
						            		)else()
						            	)
						            }
                                </ns1:consultaMovimientosRecientesTCDetalleTarjeta>
                        }
                    	</ns1:consultaMovimientosRecientesTCRegistroTarjetasAdicionales>
                    </ns1:consultaMovimientosRecientesTCTarjetasAdicionales>
            }
            
        </ns1:consultaMovimientosRecientesTCResponse>
};

declare variable $consultarMovsRecientesResponse1 as element(ns0:ConsultarMovsRecientesResponse) external;
declare variable $outputParameters as element(ns2:OutputParameters) external;

xf:consultaMovimientosRecientesTCOut($consultarMovsRecientesResponse1, 
 $outputParameters)