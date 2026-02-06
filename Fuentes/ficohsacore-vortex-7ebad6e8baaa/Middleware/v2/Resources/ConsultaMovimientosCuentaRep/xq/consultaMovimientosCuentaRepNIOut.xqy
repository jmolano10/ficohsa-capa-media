xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opConsultaMovimientoCuentaRespuesta" element="ns4:opConsultaMovimientoCuentaRespuesta" location="../../../BusinessServices/CTS/cuenta/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns3:consultaMovimientosCuentaRepResponse" location="../xsd/ConsultaMovimientosCuentaRep.xsd" ::)

declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns4 = "http://service.srvaplcobiscuenta.ecobis.cobiscorp";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/ConsultaMovimientosCuentaRepType";
declare namespace ns0 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosCuentaRep/xq/consultaMovimientosCuentaRepNIOut/";

declare function xf:consultaMovimientosCuentaRepNIOut($opConsultaMovimientoCuentaRespuesta as element(ns4:opConsultaMovimientoCuentaRespuesta))
    as element(ns3:consultaMovimientosCuentaRepResponse) {
        <ns3:consultaMovimientosCuentaRepResponse>
            {
                for $codCuentaHabiente in $opConsultaMovimientoCuentaRespuesta/ns1:movimientoResumen/ns1:cuenta/ns1:codCuentaHabiente
                return
                    <ACCOUNT_NUMBER>{ data($codCuentaHabiente) }</ACCOUNT_NUMBER>
            }
            {
                for $valCuentaHabiente in $opConsultaMovimientoCuentaRespuesta/ns1:movimientoResumen/ns1:cuenta/ns1:valCuentaHabiente
                return
                    <ACCOUNT_NAME>{ data($valCuentaHabiente) }</ACCOUNT_NAME>
            }
            {
                for $valTipoMoneda in $opConsultaMovimientoCuentaRespuesta/ns1:movimientoResumen/ns1:cuenta/ns1:moneda/ns1:valTipoMoneda
                return
                    <CURRENCY>{ data($valTipoMoneda) }</CURRENCY>
            }
            <STARTING_BALANCE>{ fn:round-half-to-even(xs:decimal(data($opConsultaMovimientoCuentaRespuesta/ns1:movimientoResumen/ns1:valBalanceInicial)),2) }</STARTING_BALANCE>
            <ENDING_BALANCE>{ fn:round-half-to-even(xs:decimal(data($opConsultaMovimientoCuentaRespuesta/ns1:movimientoResumen/ns1:valBalanceFinal)),2) }</ENDING_BALANCE>
            <START_DATE>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd",data($opConsultaMovimientoCuentaRespuesta/ns1:movimientoResumen/ns1:valFecInicio)) }</START_DATE>
            <END_DATE>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd",data($opConsultaMovimientoCuentaRespuesta/ns1:movimientoResumen/ns1:valFecFin)) }</END_DATE>
            <DEBIT_COUNT>{ data($opConsultaMovimientoCuentaRespuesta/ns1:movimientoResumen/ns1:valCantidadDebitos) }</DEBIT_COUNT>
            <CREDIT_COUNT>{ data($opConsultaMovimientoCuentaRespuesta/ns1:movimientoResumen/ns1:valCantidadCreditos) }</CREDIT_COUNT>
            <DEBIT_TOTAL_AMOUNT>{ fn:round-half-to-even(xs:decimal(data($opConsultaMovimientoCuentaRespuesta/ns1:movimientoResumen/ns1:valTotalMontoDebitos)),2) }</DEBIT_TOTAL_AMOUNT>
            <CREDIT_TOTAL_AMOUNT>{ fn:round-half-to-even(xs:decimal(data($opConsultaMovimientoCuentaRespuesta/ns1:movimientoResumen/ns1:valTotalMontoCreditos)),2) }</CREDIT_TOTAL_AMOUNT>
            <RECORDS_INFO>
                <INITIAL_RECORD>{ data($opConsultaMovimientoCuentaRespuesta/ns1:movimientoResumen/ns1:valRegistroInicial) }</INITIAL_RECORD>
                <RECORDS_RETURNED>{ data($opConsultaMovimientoCuentaRespuesta/ns1:movimientoResumen/ns1:valRegistrosRetornados) }</RECORDS_RETURNED>
                <RECORDS_TOTAL>{ data($opConsultaMovimientoCuentaRespuesta/ns1:movimientoResumen/ns1:valTotalRegistros) }</RECORDS_TOTAL>
                {
                    for $valTicket in $opConsultaMovimientoCuentaRespuesta/ns1:movimientoResumen/ns1:valTicket
                    return
                        <TICKET>{ data($valTicket) }</TICKET>
                }
            </RECORDS_INFO>
            <ns3:consultaMovimientosCuentaRepResponseType>
                {
                	let $totalMovimientos := data($opConsultaMovimientoCuentaRespuesta/ns1:movimientoResumen/ns1:valRegistrosRetornados)
                	return
                    for $i  in (1 to $totalMovimientos)
                    return
                    (
                    	<ns3:consultaMovimientosCuentaRepResponseRecordType>
                    		<REF_NO>{ fn:string(data($opConsultaMovimientoCuentaRespuesta/ns1:movimiento[$i]/ns1:valReferenciaTransaccion)) }</REF_NO>                    		
                    		<VALUE_DATE>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd",data($opConsultaMovimientoCuentaRespuesta/ns1:movimiento[$i]/ns1:fechaMovimiento)) }</VALUE_DATE>
                    		<DESCRIPTION>{ fn:string(data($opConsultaMovimientoCuentaRespuesta/ns1:movimiento[$i]/ns1:valDescripcion)) }</DESCRIPTION>
                    		<TXN_DESCRIPTION_ALL>{data($opConsultaMovimientoCuentaRespuesta/ns1:movimiento[$i]/ns1:valConceptoIngresadoTransaccion)}</TXN_DESCRIPTION_ALL>
                    		<DOCUMENT_NUMBER>{ data($opConsultaMovimientoCuentaRespuesta/ns1:movimiento[$i]/ns1:valNumeroDocumento) }</DOCUMENT_NUMBER>
                    		<AMOUNT>{ fn:round-half-to-even(xs:decimal(data($opConsultaMovimientoCuentaRespuesta/ns1:movimiento[$i]/ns1:valMonto)),2) }</AMOUNT>
                    		<CAUSE>{ data($opConsultaMovimientoCuentaRespuesta/ns1:movimiento[$i]/ns1:causa) }</CAUSE>
                    		<TXN_CODE>{ data($opConsultaMovimientoCuentaRespuesta/ns1:movimiento[$i]/ns1:codTransaccion) }</TXN_CODE>
                    		<TXN_AGN_CODE>{ data($opConsultaMovimientoCuentaRespuesta/ns1:movimiento[$i]/ns1:oficina/ns1:codOficina) }</TXN_AGN_CODE>
                    		<TXN_AGN_NAME>{ data($opConsultaMovimientoCuentaRespuesta/ns1:movimiento[$i]/ns1:oficina/ns1:valOficina) }</TXN_AGN_NAME>                    		                    		
                    		<COUNTABLE_BALANCE>{ fn:round-half-to-even(xs:decimal(data($opConsultaMovimientoCuentaRespuesta/ns1:movimiento[$i]/ns1:valSaldoContable)),2) }</COUNTABLE_BALANCE>
                    		<INITIAL_BALANCE_SIGN>{ data($opConsultaMovimientoCuentaRespuesta/ns1:movimiento[$i]/ns1:signoSaldoInicial) }</INITIAL_BALANCE_SIGN>
                    		<DEPOSITOR>{ data($opConsultaMovimientoCuentaRespuesta/ns1:movimiento[$i]/ns1:depositante) }</DEPOSITOR>
                    		<REFERENCE>{ data($opConsultaMovimientoCuentaRespuesta/ns1:movimiento[$i]/ns1:referencia2) }</REFERENCE>
                    		<RUNNING_BALANCE>{ fn:round-half-to-even(xs:decimal(data($opConsultaMovimientoCuentaRespuesta/ns1:movimiento[$i]/ns1:valSaldoDisponible)),2) }</RUNNING_BALANCE>
                    		<SIGN>{ data($opConsultaMovimientoCuentaRespuesta/ns1:movimiento[$i]/ns1:signoSaldoContable) }</SIGN>                    		
                    		<SSN_BRANCH>{ fn:string(data($opConsultaMovimientoCuentaRespuesta/ns1:movimiento[$i]/ns1:ssnBranch)) }</SSN_BRANCH>
                    	</ns3:consultaMovimientosCuentaRepResponseRecordType>
                    )
                }
			</ns3:consultaMovimientosCuentaRepResponseType>
        </ns3:consultaMovimientosCuentaRepResponse>
};

declare variable $opConsultaMovimientoCuentaRespuesta as element(ns4:opConsultaMovimientoCuentaRespuesta) external;

xf:consultaMovimientosCuentaRepNIOut($opConsultaMovimientoCuentaRespuesta)