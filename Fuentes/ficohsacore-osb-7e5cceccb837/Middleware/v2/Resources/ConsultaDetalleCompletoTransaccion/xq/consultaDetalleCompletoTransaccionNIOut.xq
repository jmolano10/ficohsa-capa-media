(:: pragma bea:global-element-parameter parameter="$opConsultarDetalleTransaccionRespuesta" element="ns4:opConsultarDetalleTransaccionRespuesta" location="../../../BusinessServices/CTS/transacciones/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDetalleCompletoTransaccionResponse" location="../xsd/consultaDetalleCompletoTransaccionTypes.xsd" ::)

declare namespace ns2 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns1 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns4 = "http://service.srvaplcobistransacciones.ecobis.cobiscorp";
declare namespace ns3 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleCompletoTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleCompletoTransaccion/xq/consultaDetalleCompletoTransaccionNIOut/";

declare function xf:consultaDetalleCompletoTransaccionNIOut($opConsultarDetalleTransaccionRespuesta as element(ns4:opConsultarDetalleTransaccionRespuesta),
    $numeroTransaccion as xs:string)
    as element(ns0:consultaDetalleCompletoTransaccionResponse) {
        <ns0:consultaDetalleCompletoTransaccionResponse>
            {
                for $codTipoProducto in $opConsultarDetalleTransaccionRespuesta/ns2:transaccion/ns2:producto/ns2:codTipoProducto
                return
                    <TYPE>{ data($codTipoProducto) }</TYPE>
            }
            {
                for $transaccion in $opConsultarDetalleTransaccionRespuesta/ns2:transaccion
                return
                    <TRANSACTION_CODE>{ data($numeroTransaccion) }</TRANSACTION_CODE>
            }
            {
                for $descripcionTransac in $opConsultarDetalleTransaccionRespuesta/ns2:transaccion/ns2:descripcionTransac
                return
                    <TRANSACTION_DESCRIPTION>{ data($descripcionTransac) }</TRANSACTION_DESCRIPTION>
            }
            {
                for $valTipoCliente in $opConsultarDetalleTransaccionRespuesta/ns2:transaccion/ns2:cuentaDebito/ns2:cliente/ns2:valTipoCliente
                return
                    <CUSTOMER_DESCRIPTION>{ data($valTipoCliente) }</CUSTOMER_DESCRIPTION>
            }
            {
                for $fechaTransac in $opConsultarDetalleTransaccionRespuesta/ns2:transaccion/ns2:fechaTransac
                return
                    <BOOKING_DATE>
	                    {
	                    	if (data($fechaTransac) != "") then (
	                    		fn-bea:dateTime-to-string-with-format("yyyyMMdd", data($fechaTransac))
	                    	) else (
	                        	""
	                        )
	                	}
                	</BOOKING_DATE>
            }
			{
                for $fechaTransacCore in $opConsultarDetalleTransaccionRespuesta/ns2:transaccion/ns2:fechaTransacCore
                return
                    <VALUE_DATE>
	                    {
	                    	if (data($fechaTransacCore) != "") then (
	                    		fn-bea:dateTime-to-string-with-format("yyyyMMdd", data($fechaTransacCore))
	                    	) else (
	                        	""
	                        )
	                	}
                	</VALUE_DATE>
            }
            {
                for $numeroCheque in $opConsultarDetalleTransaccionRespuesta/ns2:transaccion/ns2:numeroCheque
                return
                    <CHEQUE_NUMBER>{ data($numeroCheque) }</CHEQUE_NUMBER>
            }
            {
                for $codCuentaHabiente in $opConsultarDetalleTransaccionRespuesta/ns2:transaccion/ns2:cuentaDebito/ns2:codCuentaHabiente
                return
                    <DEBIT_ACCOUNT>{ data($codCuentaHabiente) }</DEBIT_ACCOUNT>
            }
            {
                for $valDebito in $opConsultarDetalleTransaccionRespuesta/ns2:transaccion/ns2:valDebito
                return
                	<DEBIT_AMOUNT>
	                	{
		                	if(data($valDebito) != '') then (
		                    	 fn:round-half-to-even(xs:decimal(data($valDebito)), 2)
		                    ) else(
		                    	""
		                    )
		                 }
	                 </DEBIT_AMOUNT>
            }
            {
                for $valTipoMoneda in $opConsultarDetalleTransaccionRespuesta/ns2:transaccion/ns2:cuentaDebito/ns2:moneda/ns2:valTipoMoneda
                return
                    <DEBIT_CURRENCY>{ data($valTipoMoneda) }</DEBIT_CURRENCY>
            }
            {
                for $codCuentaHabiente in $opConsultarDetalleTransaccionRespuesta/ns2:transaccion/ns2:cuentaCredito/ns2:codCuentaHabiente
                return
                    <CREDIT_ACCOUNT>{ data($codCuentaHabiente) }</CREDIT_ACCOUNT>
            }
            {
                for $valCredito in $opConsultarDetalleTransaccionRespuesta/ns2:transaccion/ns2:valCredito
                return
                	<CREDIT_AMOUNT>
	                	{
		                	if(data($valCredito) != '') then(
		                    	fn:round-half-to-even(xs:decimal(data($valCredito)), 2)
		                    ) else (
		                    	""
		                    )
		                }
	                 </CREDIT_AMOUNT>
            }
            {
                for $valTipoMoneda in $opConsultarDetalleTransaccionRespuesta/ns2:transaccion/ns2:cuentaCredito/ns2:moneda/ns2:valTipoMoneda
                return
                    <CREDIT_CURRENCY>{ data($valTipoMoneda) }</CREDIT_CURRENCY>
            }
            {
                for $usuarioTransac in $opConsultarDetalleTransaccionRespuesta/ns2:transaccion/ns2:usuarioTransac
                return
                    <INPUTTER>{ data($usuarioTransac) }</INPUTTER>
            }
            {
                for $idAutorizacion in $opConsultarDetalleTransaccionRespuesta/ns2:transaccion/ns2:idAutorizacion
                return
                    <AUTHORIZER>{ data($idAutorizacion) }</AUTHORIZER>
            }
            {
                for $cuentaExterna in $opConsultarDetalleTransaccionRespuesta/ns2:transaccion/ns2:cuentaExterna
                return
                    <EXTERNAL_BEN_ACCOUNT>{ data($cuentaExterna) }</EXTERNAL_BEN_ACCOUNT>
            }
            {
                for $idContrato in $opConsultarDetalleTransaccionRespuesta/ns2:transaccion/ns2:idContrato
                return
                    <CONTRACT_ID>{ data($idContrato) }</CONTRACT_ID>
            }
            {
                for $valMonto in $opConsultarDetalleTransaccionRespuesta/ns2:transaccion/ns2:valMonto
                return
                	<TRANSACTION_AMOUNT>
                		{
		                	if(data($valMonto) != '') then(
		                    	fn:round-half-to-even(xs:decimal(data($valMonto)), 2)
		                    ) else(
		                    	""
		                    )
		                }
		            </TRANSACTION_AMOUNT>
            }
            {
                for $valComision in $opConsultarDetalleTransaccionRespuesta/ns2:transaccion/ns2:valComision
                return
                	<COMMISSION_AMOUNT>
                		{
		                	if(data($valComision) != '') then(
		                    	fn:round-half-to-even(xs:decimal(data($valComision)), 2)
		                    ) else(
		                    	""
		                    )
		              	}
		            </COMMISSION_AMOUNT>
            }
            {
                for $idEnvio in $opConsultarDetalleTransaccionRespuesta/ns2:transaccion/ns2:idEnvio
                return
                    <REMITTANCE_ID>{ data($idEnvio) }</REMITTANCE_ID>
            }
            {
                for $codigoPago in $opConsultarDetalleTransaccionRespuesta/ns2:transaccion/ns2:codigoPago
                return
                    <COLL_PAY_CODE>{ data($codigoPago) }</COLL_PAY_CODE>
            }
            {
                for $numTarjetaCredito in $opConsultarDetalleTransaccionRespuesta/ns2:transaccion/ns2:numTarjetaCredito
                return
                    <CREDIT_CARD_NUMBER>{ data($numTarjetaCredito) }</CREDIT_CARD_NUMBER>
            }
            {
                for $valNumeroProducto in $opConsultarDetalleTransaccionRespuesta/ns2:transaccion/ns2:prestamo/ns2:producto/ns2:valNumeroProducto
                return
                    <LOAN_NUMBER>{ data($valNumeroProducto) }</LOAN_NUMBER>
            }
        </ns0:consultaDetalleCompletoTransaccionResponse>
};

declare variable $opConsultarDetalleTransaccionRespuesta as element(ns4:opConsultarDetalleTransaccionRespuesta) external;
declare variable $numeroTransaccion as xs:string external;

xf:consultaDetalleCompletoTransaccionNIOut($opConsultarDetalleTransaccionRespuesta,
    $numeroTransaccion)