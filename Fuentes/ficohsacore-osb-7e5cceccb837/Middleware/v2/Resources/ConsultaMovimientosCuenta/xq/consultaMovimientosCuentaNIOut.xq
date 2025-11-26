(:: pragma bea:global-element-parameter parameter="$opConsultaMovimientoCuentaRespuesta" element="ns1:opConsultaMovimientoCuentaRespuesta" location="../../../BusinessServices/CTS/cuenta/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaMovimientosCuentaResponse" location="../xsd/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns2 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns1 = "http://service.srvaplcobiscuenta.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosCuenta/xq/consultaMovimientosCuentaNIOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://dto2.commons.ecobis.cobiscorp";

declare function xf:consultaMovimientosCuentaNIOut($opConsultaMovimientoCuentaRespuesta as element(ns1:opConsultaMovimientoCuentaRespuesta))
    as element(ns0:consultaMovimientosCuentaResponse) {
        <ns0:consultaMovimientosCuentaResponse>
            {
                for $codCuentaHabiente in $opConsultaMovimientoCuentaRespuesta/ns2:movimientoResumen/ns2:cuenta/ns2:codCuentaHabiente
                return
                    <ACCOUNT_NUMBER>{ data($codCuentaHabiente) }</ACCOUNT_NUMBER>
            }
            {
                for $valCuentaHabiente in $opConsultaMovimientoCuentaRespuesta/ns2:movimientoResumen/ns2:cuenta/ns2:valCuentaHabiente
                return
                    <ACCOUNT_NAME>{ data($valCuentaHabiente) }</ACCOUNT_NAME>
            }
            {
                for $valTipoMoneda in $opConsultaMovimientoCuentaRespuesta/ns2:movimientoResumen/ns2:cuenta/ns2:moneda/ns2:valTipoMoneda
                return
                    <CURRENCY>{ data($valTipoMoneda) }</CURRENCY>
            }
            <STARTING_BALANCE>{ fn:round-half-to-even(data($opConsultaMovimientoCuentaRespuesta/ns2:movimientoResumen/ns2:valBalanceInicial),2) }</STARTING_BALANCE>
            <ENDING_BALANCE>{ fn:round-half-to-even(data($opConsultaMovimientoCuentaRespuesta/ns2:movimientoResumen/ns2:valBalanceFinal),2) }</ENDING_BALANCE>
            <START_DATE>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd",data($opConsultaMovimientoCuentaRespuesta/ns2:movimientoResumen/ns2:valFecInicio)) }</START_DATE>
            <END_DATE>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd",data($opConsultaMovimientoCuentaRespuesta/ns2:movimientoResumen/ns2:valFecFin)) }</END_DATE>
            <DEBIT_COUNT>{ data($opConsultaMovimientoCuentaRespuesta/ns2:movimientoResumen/ns2:valCantidadDebitos) }</DEBIT_COUNT>
            <CREDIT_COUNT>{ data($opConsultaMovimientoCuentaRespuesta/ns2:movimientoResumen/ns2:valCantidadCreditos) }</CREDIT_COUNT>
            <DEBIT_TOTAL_AMOUNT>{ fn:round-half-to-even(data($opConsultaMovimientoCuentaRespuesta/ns2:movimientoResumen/ns2:valTotalMontoDebitos),2) }</DEBIT_TOTAL_AMOUNT>
            <CREDIT_TOTAL_AMOUNT>{ fn:round-half-to-even(data($opConsultaMovimientoCuentaRespuesta/ns2:movimientoResumen/ns2:valTotalMontoCreditos),2) }</CREDIT_TOTAL_AMOUNT>
            <RECORDS_INFO>
                <INITIAL_RECORD>{ data($opConsultaMovimientoCuentaRespuesta/ns2:movimientoResumen/ns2:valRegistroInicial) }</INITIAL_RECORD>
                <RECORDS_RETURNED>{ data($opConsultaMovimientoCuentaRespuesta/ns2:movimientoResumen/ns2:valRegistrosRetornados) }</RECORDS_RETURNED>
                <RECORDS_TOTAL>{ data($opConsultaMovimientoCuentaRespuesta/ns2:movimientoResumen/ns2:valTotalRegistros) }</RECORDS_TOTAL>
                <TICKET>{ data($opConsultaMovimientoCuentaRespuesta/ns2:movimientoResumen/ns2:valTicket) }</TICKET>
            </RECORDS_INFO>
            <ns0:consultaMovimientosCuentaResponseType>
            {
                let $total  := (count($opConsultaMovimientoCuentaRespuesta/ns2:movimiento/ns2:fechaMovimiento))  
                return
                    for $i  in (1 to $total)  
                    return 
                    (
                    <ns0:consultaMovimientosCuentaResponseRecordType>
                        <VALUE_DATE>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd",data($opConsultaMovimientoCuentaRespuesta/ns2:movimiento[$i]/ns2:fechaMovimiento)) }</VALUE_DATE>
                        <DESCRIPTION>{ fn:string(data($opConsultaMovimientoCuentaRespuesta/ns2:movimiento[$i]/ns2:valDescripcion)) }</DESCRIPTION>
                        <REF_NO>{ fn:string(data($opConsultaMovimientoCuentaRespuesta/ns2:movimiento[$i]/ns2:ssnBranch)) }</REF_NO>
                        <DOCUMENT_NUMBER>{ data($opConsultaMovimientoCuentaRespuesta/ns2:movimiento[$i]/ns2:valNumeroDocumento) }</DOCUMENT_NUMBER>
                        <TXN_REFERENCE>{ data($opConsultaMovimientoCuentaRespuesta/ns2:movimiento[$i]/ns2:valSecuencial) }</TXN_REFERENCE>
                        <AMOUNT>{ fn:round-half-to-even(data($opConsultaMovimientoCuentaRespuesta/ns2:movimiento[$i]/ns2:valMonto),2) }</AMOUNT>
                        <EFFECT_ON_BALANCE>{ data($opConsultaMovimientoCuentaRespuesta/ns2:movimiento[$i]/ns2:valEfectoBalance) }</EFFECT_ON_BALANCE>
                        <INPUTTER>{data($opConsultaMovimientoCuentaRespuesta/ns2:movimiento[$i]/ns2:valUsuarioTransaccion)}</INPUTTER>
                        <TXNCODE>{data($opConsultaMovimientoCuentaRespuesta/ns2:movimiento[$i]/ns2:codTransaccion)}</TXNCODE>
                        <TXNAGNCODE>{data($opConsultaMovimientoCuentaRespuesta/ns2:movimiento[$i]/ns2:oficina/ns2:codOficina)}</TXNAGNCODE>
                        <TXNAGNNAME>{data($opConsultaMovimientoCuentaRespuesta/ns2:movimiento[$i]/ns2:oficina/ns2:valOficina)}</TXNAGNNAME>
                        <TXNDESCRIPTIONALL>{data($opConsultaMovimientoCuentaRespuesta/ns2:movimiento[$i]/ns2:valConceptoIngresadoTransaccion)}</TXNDESCRIPTIONALL>
                        <AUTHORISER>{data($opConsultaMovimientoCuentaRespuesta/ns2:movimiento[$i]/ns2:valAutorizante)}</AUTHORISER>
                        <TXNDATETIME>{fn-bea:dateTime-to-string-with-format("yyyyMMdd",data($opConsultaMovimientoCuentaRespuesta/ns2:movimiento[$i]/ns2:fechaAplicacionCore))}</TXNDATETIME>
                        <RUNNING_BALANCE>{ fn:round-half-to-even(data($opConsultaMovimientoCuentaRespuesta/ns2:movimiento[$i]/ns2:valSaldoDisponible),2) }</RUNNING_BALANCE>
                    </ns0:consultaMovimientosCuentaResponseRecordType>
                    )
            }
            </ns0:consultaMovimientosCuentaResponseType>
        </ns0:consultaMovimientosCuentaResponse>
};

declare variable $opConsultaMovimientoCuentaRespuesta as element(ns1:opConsultaMovimientoCuentaRespuesta) external;

xf:consultaMovimientosCuentaNIOut($opConsultaMovimientoCuentaRespuesta)