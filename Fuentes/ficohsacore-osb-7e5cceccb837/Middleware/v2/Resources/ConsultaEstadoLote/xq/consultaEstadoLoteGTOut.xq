(:: pragma bea:global-element-parameter parameter="$consultarLoteResponse" element="ns1:consultarLoteResponse" location="../../../BusinessServices/MTR/consultorLote/wsdl/consultorLoteEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:consultaEstadoLoteResponse" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns1 = "http://servicio.consultalotews.mtrpmsv.cidenet.com.co/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteGTOut/";

declare function optimista ($item as item())as xs:string{
	let $optimista:= fn-bea:trim(upper-case(fn:string($item/text())))
	return
		if($optimista = 'S') then (
			'YES'
		)		
		else if ($optimista = 'N') then (
			'NO'
		)
		else('')
};

declare function xf:consultaEstadoLoteGTOut($consultarLoteResponse as element(ns1:consultarLoteResponse))
    as element(ns0:consultaEstadoLoteResponse) {
        <ns0:consultaEstadoLoteResponse>
                { 
                	for $idLote in $consultarLoteResponse/respuestaConsultaLote/detalleRespuesta/lote/idLote
        			return
                		<BANK_BATCH_ID>{ data($idLote) }</BANK_BATCH_ID>
                }                
                <CUSTOMER_ID>{ data($consultarLoteResponse/respuestaConsultaLote/detalleRespuesta/lote/idClienteCore) }</CUSTOMER_ID>
                {
                    for $nombreCliente in $consultarLoteResponse/respuestaConsultaLote/detalleRespuesta/lote/nombreCliente
                    return
                        <CUSTOMER_NAME>{ data($nombreCliente) }</CUSTOMER_NAME>
                }
                <STATUS>{ data($consultarLoteResponse/respuestaConsultaLote/detalleRespuesta/lote/idEstado) }</STATUS>
                {
                    for $nombreEstado in $consultarLoteResponse/respuestaConsultaLote/detalleRespuesta/lote/nombreEstado
                    return
                        <STATUS_DESC>{ data($nombreEstado) }</STATUS_DESC>
                }
                {
                    for $optimista in $consultarLoteResponse/respuestaConsultaLote/detalleRespuesta/lote/optimista
                    return
                        <OPTIMISTIC>{ optimista($optimista) }</OPTIMISTIC>
                }
                {
                    for $cuentas in $consultarLoteResponse/respuestaConsultaLote/detalleRespuesta/cuentas
                    return
                        <ACCOUNTS>
                            {
                                for $cuenta in $cuentas/cuenta
                                return
                                    <ACCOUNT>
                                        {
                                            for $idProductoDebito in $cuenta/idProductoDebito
                                            return
                                                <DEBIT_ACCOUNT>{ data($idProductoDebito) }</DEBIT_ACCOUNT>
                                        }
                                        {
                                            for $monto in $cuenta/monto
                                            return
                                                <AMOUNT>{ data($monto) }</AMOUNT>
                                        }
                                        {
                                            for $idMoneda in $cuenta/idMoneda
                                            return
                                                <CURRENCY>{ data($idMoneda) }</CURRENCY>
                                        }
                                    </ACCOUNT>
                            }
                        </ACCOUNTS>
                }
                {
                    for $pagos in $consultarLoteResponse/respuestaConsultaLote/detalleRespuesta/pagos
                    return
                        <PAYMENTS>
                            {
                                for $pago in $pagos/pago
                                return
                                    <PAYMENT>
                                        {
                                            for $idMoneda in $pago/idMoneda
                                            return
                                                <CURRENCY>{ data($idMoneda) }</CURRENCY>
                                        }
                                        {
                                            for $monto in $pago/monto
                                            return
                                                <TOTAL_AMOUNT>{ data($monto) }</TOTAL_AMOUNT>
                                        }
                                        <EXCHANGE_RATE>{ data($pago/tasaCambio) }</EXCHANGE_RATE>
                                    </PAYMENT>
                            }
                        </PAYMENTS>
                }
                {
                    for $montoTotal in $consultarLoteResponse/respuestaConsultaLote/detalleRespuesta/lote/montoTotal
                    return
                        <TOTAL_AMOUNT>{ data($montoTotal) }</TOTAL_AMOUNT>
                }
                {
                    for $montoTotalError in $consultarLoteResponse/respuestaConsultaLote/detalleRespuesta/lote/montoTotalError
                    return
                        <TOTAL_AMOUNT_ERROR>{ data($montoTotalError) }</TOTAL_AMOUNT_ERROR>
                }
                <NUMBER_OF_TRANSACTIONS>{ data($consultarLoteResponse/respuestaConsultaLote/detalleRespuesta/lote/cantidadTransacciones) }</NUMBER_OF_TRANSACTIONS>
                <NUMBER_OF_TRANSACTIONS_SUCCESS>{ data($consultarLoteResponse/respuestaConsultaLote/detalleRespuesta/lote/cantidadTransaccionesExito) }</NUMBER_OF_TRANSACTIONS_SUCCESS>
                <NUMBER_OF_TRANSACTIONS_ERROR>{ data($consultarLoteResponse/respuestaConsultaLote/detalleRespuesta/lote/cantidadTransaccionesError) }</NUMBER_OF_TRANSACTIONS_ERROR>
                {
                    for $fechaAplicacion in $consultarLoteResponse/respuestaConsultaLote/detalleRespuesta/lote/fechaAplicacion
                    return
                        <APPLICATION_DATE>{ data($fechaAplicacion) }</APPLICATION_DATE>
                }
                {
                    for $infoProceso in $consultarLoteResponse/respuestaConsultaLote/detalleRespuesta/lote/infoProceso
                    return
                        <PROCESS_INFO>{ data($infoProceso) }</PROCESS_INFO>
                }
        </ns0:consultaEstadoLoteResponse>
};

declare variable $consultarLoteResponse as element(ns1:consultarLoteResponse) external;

xf:consultaEstadoLoteGTOut($consultarLoteResponse)