(:: pragma bea:global-element-parameter parameter="$opConsultaSaldosTarjetaCreditoRespuesta" element="ns3:opConsultaSaldosTarjetaCreditoRespuesta" location="../../../BusinessServices/CTS/tarjetaCredito/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaSaldosTarjetaCreditoResponse" location="../../../../Business_Resources/tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf =  "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/consultaSaldosTCNIOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://service.srvaplcobistarjetacredito.ecobis.cobiscorp";

declare function formatearFecha($entrada as xs:string?)
	as xs:string? {
	let $fecha := fn-bea:date-from-string-with-format("dd/MM/yyyy", $entrada )
	return
		fn-bea:date-to-string-with-format("yyyyMMdd", $fecha)
};

declare function nvl( $arg as item()? , $value as item()* )  
	as item()* {
	if (string($arg) != '') then 
		data($arg)
  	else 
  		$value
};

declare function xf:consultaSaldosTCNIOut($opConsultaSaldosTarjetaCreditoRespuesta as element(ns3:opConsultaSaldosTarjetaCreditoRespuesta))
    as element(ns0:consultaSaldosTarjetaCreditoResponse) {
        <ns0:consultaSaldosTarjetaCreditoResponse>
            {
                for $codTipoProducto in $opConsultaSaldosTarjetaCreditoRespuesta/ns1:tarjetaCredito[1]/ns1:valNumeroTC/ns1:codTipoProducto
                return
                    <CARD_NUMBER>{ data($codTipoProducto) }</CARD_NUMBER>
            }
            {
                for $valNombreTitular in $opConsultaSaldosTarjetaCreditoRespuesta/ns1:tarjetaCredito[1]/ns1:valNombreTitular
                return
                    <CARD_HOLDER_NAME>{ data($valNombreTitular) }</CARD_HOLDER_NAME>
            }
            {
                let $saldoLocal := $opConsultaSaldosTarjetaCreditoRespuesta/ns1:saldosTarjetaCredito[ns1:valMoneda/ns1:valSimboloMoneda = 'NIO']
                let $saldoExtranjero := $opConsultaSaldosTarjetaCreditoRespuesta/ns1:saldosTarjetaCredito[ns1:valMoneda/ns1:valSimboloMoneda = 'USD']
                let $cont:= count($opConsultaSaldosTarjetaCreditoRespuesta/ns1:saldosTarjetaCredito)
                return (
	            	<LCY_MIN_PAYMENT>{ nvl(data($saldoLocal/ns1:valPagoMinimo), 0) }</LCY_MIN_PAYMENT>,
	                <LCY_TOTAL_PAYMENT>{ nvl(data($saldoLocal/ns1:valSaldoCorte), 0) }</LCY_TOTAL_PAYMENT>,
	                <FCY_MIN_PAYMENT>{ nvl(data($saldoExtranjero/ns1:valPagoMinimo), 0) }</FCY_MIN_PAYMENT>,
	                <FCY_TOTAL_PAYMENT>{ nvl(data($saldoExtranjero/ns1:valSaldoCorte), 0) }</FCY_TOTAL_PAYMENT>,
					
					if ($cont > 1) then (
			   			<CREDIT_LIMIT>{ nvl(data($saldoExtranjero/ns1:valLimiteCredito), 0) }</CREDIT_LIMIT>,
			            <CREDIT_LIMIT_CCY>{ data($saldoExtranjero/ns1:valMoneda/ns1:valSimboloMoneda) }</CREDIT_LIMIT_CCY>
					) else (
						<CREDIT_LIMIT>{ nvl(data($opConsultaSaldosTarjetaCreditoRespuesta/ns1:saldosTarjetaCredito[1]/ns1:valLimiteCredito), 0) }</CREDIT_LIMIT>,
		                <CREDIT_LIMIT_CCY>{ data($opConsultaSaldosTarjetaCreditoRespuesta/ns1:saldosTarjetaCredito[1]/ns1:valMoneda/ns1:valSimboloMoneda) }</CREDIT_LIMIT_CCY>
		            )
				)
            }
            {
                for $valSaldoActual in $opConsultaSaldosTarjetaCreditoRespuesta/ns1:puntosTarjetaCredito[1]/ns1:valSaldoActual
                return
                    <POINTS_EARNED>{ data($valSaldoActual) }</POINTS_EARNED>
            }
            {
                for $valFechaPagoMaximo in $opConsultaSaldosTarjetaCreditoRespuesta/ns1:tarjetaCredito[1]/ns1:valFechaPagoMaximo
                return
                    <MAX_PAYMENT_DATE>{ formatearFecha(data($valFechaPagoMaximo)) }</MAX_PAYMENT_DATE>
            }
            {
				for $valFechaCorte in $opConsultaSaldosTarjetaCreditoRespuesta/ns1:tarjetaCredito[1]/ns1:valFechaCorte
              	return 	
					<LAST_CUTOFF_DATE>{ formatearFecha(data($valFechaCorte)) }</LAST_CUTOFF_DATE>
            }
            <ns0:consultaSaldosTarjetaCreditoResponseType>
                {
                    for $saldosTarjetaCredito in $opConsultaSaldosTarjetaCreditoRespuesta/ns1:saldosTarjetaCredito
                    return
                        <ns0:consultaSaldosTarjetaCreditoResponseRecordType>
                            {
                                for $valSimboloMoneda in $saldosTarjetaCredito/ns1:valMoneda/ns1:valSimboloMoneda
                                return
                                    <CURRENCY>{ data($valSimboloMoneda) }</CURRENCY>
                            }
                            {
                                for $valDeudaVigenteVencida in $saldosTarjetaCredito/ns1:valDeudaVigenteVencida
                                return
                                    <OVERDUE_BALANCE>{ data($valDeudaVigenteVencida) }</OVERDUE_BALANCE>
                            }
                            {
                                for $valSaldoRetencionTrn in $saldosTarjetaCredito/ns1:valSaldoRetencionTrn
                                return
                                    <FLOATING_BALANCE>{ data($valSaldoRetencionTrn) }</FLOATING_BALANCE>
                            }
                            {
                                for $valSaldoActual in $saldosTarjetaCredito/ns1:valSaldoActual
                                return
                                    <CURRENT_BALANCE>{ data($valSaldoActual) }</CURRENT_BALANCE>
                            }
                            {
                                for $valDisponibleCompras in $saldosTarjetaCredito/ns1:valDisponibleCompras
                                return
                                    <PURCHASES_LIMIT>{ data($valDisponibleCompras) }</PURCHASES_LIMIT>
                            }
                            {
                                for $valRetiroDisponible in $saldosTarjetaCredito/ns1:valRetiroDisponible
                                return
                                    <WITHDRAWAL_LIMIT>{ data($valRetiroDisponible) }</WITHDRAWAL_LIMIT>
                            }
                        </ns0:consultaSaldosTarjetaCreditoResponseRecordType>
                }
            </ns0:consultaSaldosTarjetaCreditoResponseType>
        </ns0:consultaSaldosTarjetaCreditoResponse>
};


declare variable $opConsultaSaldosTarjetaCreditoRespuesta as element(ns3:opConsultaSaldosTarjetaCreditoRespuesta) external;

xf:consultaSaldosTCNIOut($opConsultaSaldosTarjetaCreditoRespuesta)