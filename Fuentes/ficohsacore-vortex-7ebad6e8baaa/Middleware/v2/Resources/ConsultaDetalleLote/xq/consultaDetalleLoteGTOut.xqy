xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultarDetalleLoteResponse" element="ns1:consultarDetalleLoteResponse" location="../../../BusinessServices/MTR/consultorDetalleLote/wsdl/consultorDetalleLoteEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns2:consultaDetalleLoteResponse" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns1 = "http://servicio.consultadetallelotepmsws.mtrpmsv.cidenet.com.co/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/PagingTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleLote/xq/consultaDetalleLoteGTOut/";

declare function xf:consultaDetalleLoteGTOut($consultarDetalleLoteResponse as element(ns1:consultarDetalleLoteResponse))
    as element(ns2:consultaDetalleLoteResponse) {
        <ns2:consultaDetalleLoteResponse>
            {
                for $codigoCliente in $consultarDetalleLoteResponse/respuestaConsultaDetalleLote/detalleRespuesta/codigoCliente
                return
                    <CUSTOMER_ID>{ data($codigoCliente) }</CUSTOMER_ID>
            }
            <BANK_BATCH_ID>{ data($consultarDetalleLoteResponse/respuestaConsultaDetalleLote/detalleRespuesta/idLote) }</BANK_BATCH_ID>
            {
                for $nombreCliente in $consultarDetalleLoteResponse/respuestaConsultaDetalleLote/detalleRespuesta/nombreCliente
                return
                    <CUSTOMER_NAME>{ data($nombreCliente) }</CUSTOMER_NAME>
            }
            <BATCH_TYPE>{ data($consultarDetalleLoteResponse/respuestaConsultaDetalleLote/detalleRespuesta/tipoOperacion) }</BATCH_TYPE>
            {
                for $descripcionTipoOperacion in $consultarDetalleLoteResponse/respuestaConsultaDetalleLote/detalleRespuesta/descripcionTipoOperacion
                return
                    <BATCH_TYPE_DESC>{ data($descripcionTipoOperacion) }</BATCH_TYPE_DESC>
            }
            {
                for $fechaCreacion in $consultarDetalleLoteResponse/respuestaConsultaDetalleLote/detalleRespuesta/fechaCreacion
                return
                    <UPLOAD_DATE>{ fn:adjust-date-to-timezone(fn-bea:date-from-dateTime (data($fechaCreacion)),()) }</UPLOAD_DATE>
            }
            {
                for $fechaAplicacion in $consultarDetalleLoteResponse/respuestaConsultaDetalleLote/detalleRespuesta/fechaAplicacion
                return
                    <APPLICATION_DATE>{ fn:adjust-dateTime-to-timezone(data($fechaAplicacion),()) }</APPLICATION_DATE>
            }
            <NUMBER_OF_TRANSACTIONS>{ data($consultarDetalleLoteResponse/respuestaConsultaDetalleLote/detalleRespuesta/cantidadTransacciones) }</NUMBER_OF_TRANSACTIONS>
            <NUMBER_OF_TRANSACTIONS_SUCCESS>{ data($consultarDetalleLoteResponse/respuestaConsultaDetalleLote/detalleRespuesta/cantidadTransaccionesExito) }</NUMBER_OF_TRANSACTIONS_SUCCESS>
            <NUMBER_OF_TRANSACTIONS_ERROR>{ data($consultarDetalleLoteResponse/respuestaConsultaDetalleLote/detalleRespuesta/cantidadTransaccionesError) }</NUMBER_OF_TRANSACTIONS_ERROR>
            {
                for $montoTotal in $consultarDetalleLoteResponse/respuestaConsultaDetalleLote/detalleRespuesta/montoTotal
                return
                    <TOTAL_AMOUNT>{ round-half-to-even(xs:decimal(data($montoTotal)),2) }</TOTAL_AMOUNT>
            }
            {
                for $montoTotalError in $consultarDetalleLoteResponse/respuestaConsultaDetalleLote/detalleRespuesta/montoTotalError
                return
                    <TOTAL_AMOUNT_ERROR>{ round-half-to-even(xs:decimal(data($montoTotalError)),2) }</TOTAL_AMOUNT_ERROR>
            }
            <STATUS>{ data($consultarDetalleLoteResponse/respuestaConsultaDetalleLote/detalleRespuesta/idEstado) }</STATUS>
            {
                for $nombreEstado in $consultarDetalleLoteResponse/respuestaConsultaDetalleLote/detalleRespuesta/nombreEstado
                return
                    <STATUS_DESC>{ data($nombreEstado) }</STATUS_DESC>
            }
            {
                for $detallePaginacion in $consultarDetalleLoteResponse/respuestaConsultaDetalleLote/detalleRespuesta/detallePaginacion
                return
                    <RECORDS_INFO>
                        <INITIAL_RECORD>{ data($detallePaginacion/registroInicial) }</INITIAL_RECORD>
                        <RECORDS_RETURNED>{ data($detallePaginacion/registrosObtenidos) }</RECORDS_RETURNED>
                        <RECORD_TOTAL>{ data($detallePaginacion/registrosTotales) }</RECORD_TOTAL>
                    </RECORDS_INFO>
            }
            {
                for $transacciones in $consultarDetalleLoteResponse/respuestaConsultaDetalleLote/detalleRespuesta/transacciones
                return
                    <TRANSACTIONS>
                        {
                            for $transaccion in $transacciones/transaccion
                            return
                                <TRANSACTION>
                                    <ID>{ data($transaccion/idTransaccion) }</ID>
                                    {
                                        for $idTipoPago in $transaccion/idTipoPago
                                        return
                                            <PAYMENT_TYPE>{ data($idTipoPago) }</PAYMENT_TYPE>
                                    }
                                    {
                                        for $nombreTipoPago in $transaccion/nombreTipoPago
                                        return
                                            <PAYMENT_TYPE_DESC>{ data($nombreTipoPago) }</PAYMENT_TYPE_DESC>
                                    }
                                    {
                                        for $idTransaccionCore in $transaccion/idTransaccionCore
                                        return
                                            <TXN_REFERENCE>{ data($idTransaccionCore) }</TXN_REFERENCE>
                                    }
                                    {
                                        for $idProductoDebito in $transaccion/idProductoDebito
                                        return
                                            <DEBIT_ACCOUNT>{ data($idProductoDebito) }</DEBIT_ACCOUNT>
                                    }
                                    {
                                        for $idProductoCredito in $transaccion/idProductoCredito
                                        return
                                            <CREDIT_ACCOUNT>{ data($idProductoCredito) }</CREDIT_ACCOUNT>
                                    }
                                    {
                                        for $idEntidadCredito in $transaccion/idEntidadCredito
                                        return
                                            <DESTINATION_BANK>{ data($idEntidadCredito) }</DESTINATION_BANK>
                                    }
                                    {
                                        for $nombreBanco in $transaccion/nombreBanco
                                        return
                                            <DESTINATION_BANK_NAME>{ data($nombreBanco) }</DESTINATION_BANK_NAME>
                                    }
                                    {
                                        for $idMonedaCredito in $transaccion/idMonedaCredito
                                        return
                                            <CREDIT_CURRENCY>{ data($idMonedaCredito) }</CREDIT_CURRENCY>
                                    }
                                    {
                                        for $idMonedaTransaccion in $transaccion/idMonedaTransaccion
                                        return
                                            <CURRENCY>{ data($idMonedaTransaccion) }</CURRENCY>
                                    }
                                    {
                                        for $monto in $transaccion/monto
                                        return
                                            <AMOUNT>{ round-half-to-even(xs:decimal(data($monto)),2) }</AMOUNT>
                                    }
                                    {
                                        for $idTipoProductoCredito in $transaccion/idTipoProductoCredito
                                        return
                                            <CREDIT_ACCOUNT_TYPE>{ data($idTipoProductoCredito) }</CREDIT_ACCOUNT_TYPE>
                                    }
                                    {
                                        for $nombreBeneficiario in $transaccion/nombreBeneficiario
                                        return
                                            <BENEFICIARY>{ data($nombreBeneficiario) }</BENEFICIARY>
                                    }
                                    {
                                        for $numeroCheque in $transaccion/numeroCheque
                                        return
                                            <DOCUMENT_NUMBER>{ data($numeroCheque) }</DOCUMENT_NUMBER>
                                    }
                                    {
                                        for $idProveedor in $transaccion/idProveedor
                                        return
                                            <SUPPLIER_ID>{ data($idProveedor) }</SUPPLIER_ID>
                                    }
                                    <STATUS>{ data($transaccion/idEstado) }</STATUS>
                                    {
                                        for $nombreEstado in $transaccion/nombreEstado
                                        return
                                            <STATUS_DESC>{ data($nombreEstado) }</STATUS_DESC>
                                    }
                                    {
                                        for $descripcionTransaccion in $transaccion/descripcionTransaccion
                                        return
                                            <DESCRIPTION>{ data($descripcionTransaccion) }</DESCRIPTION>
                                    }
                                    {
                                        for $idAgenciaDestino in $transaccion/idAgenciaDestino
                                        return
                                            <WITHDRAWAL_BRANCH>{ data($idAgenciaDestino) }</WITHDRAWAL_BRANCH>
                                    }
                                    {
                                        for $nombreAgenciaDestino in $transaccion/nombreAgenciaDestino
                                        return
                                            <WITHDRAWAL_BRANCH_NAME>{ data($nombreAgenciaDestino) }</WITHDRAWAL_BRANCH_NAME>
                                    }
                                    {
                                        for $idSegunEmpresa in $transaccion/idSegunEmpresa
                                        return
                                            <EXTERNAL_REFERENCE>{ data($idSegunEmpresa) }</EXTERNAL_REFERENCE>
                                    }
                                    {
                                        for $codigoError in $transaccion/codigoError
                                        return
                                            <ERROR_CODE>{ data($codigoError) }</ERROR_CODE>
                                    }
                                    {
                                        for $mensajeError in $transaccion/mensajeError
                                        return
                                            <ERROR_MESSAGE>{ data($mensajeError) }</ERROR_MESSAGE>
                                    }
                                </TRANSACTION>
                        }
                    </TRANSACTIONS>
            }
        </ns2:consultaDetalleLoteResponse>
};

declare variable $consultarDetalleLoteResponse as element(ns1:consultarDetalleLoteResponse) external;

xf:consultaDetalleLoteGTOut($consultarDetalleLoteResponse)