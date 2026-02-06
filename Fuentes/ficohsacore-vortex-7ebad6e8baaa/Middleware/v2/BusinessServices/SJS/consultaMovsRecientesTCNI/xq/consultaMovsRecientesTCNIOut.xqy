xquery version "2004-draft";
(:Actualización del día 20180816:)
(:Se modificó el bloque en el que se asigna el valor para <ORIGINAL_AMOUNT> ya que se estaba concatenando $valMontoOriginal y $valDecimalOriginal. Fátima Zapata confirmó el día 20180815 que:)
(:el valor de <ORIGINAL_AMOUNT> debe ser únicamente el contenido de $valMontoOriginal:)
(:Se cambió de <ORIGINAL_AMOUNT>{ concat($valMontoOriginal , '.', $valDecimalOriginal) }</ORIGINAL_AMOUNT>:)
(:a <ORIGINAL_AMOUNT>{ data($valMontoOriginal) }</ORIGINAL_AMOUNT>:)

(:: pragma bea:global-element-parameter parameter="$opConsultaMovimientosTarjetaCreditoRespuesta" element="ns3:opConsultaMovimientosTarjetaCreditoRespuesta" location="../../../CTS/tarjetaCredito/xsd/services.xsd" ::)
(:: pragma bea:local-element-return type="ns4:sjConsultaMovsRecientesTCNIResponse/MOVS" location="../xsd/sjConsultaMovsRecientesTCNI.xsd" ::)

declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns4 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMovsRecientesTCNI";
declare namespace ns3 = "http://service.srvaplcobistarjetacredito.ecobis.cobiscorp";
declare namespace ns0 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMovsRecientesTC/xq/consultaMovsRecientesTCNIOut/";


declare function formatearFecha($entrada as xs:string?){
		let $fechaDateFormat := fn-bea:date-from-string-with-format("dd/MM/yyyy", $entrada) 
         return 
         fn-bea:date-to-string-with-format("yyyyMMdd", $fechaDateFormat)
};

declare function xf:consultaMovsRecientesTCNIOut($opConsultaMovimientosTarjetaCreditoRespuesta as element(ns3:opConsultaMovimientosTarjetaCreditoRespuesta))
    as element() {
        <MOVS>
            {
                for $transaccionTarjetaCredito in $opConsultaMovimientosTarjetaCreditoRespuesta/ns1:transaccionTarjetaCredito
                return
                    <MOV>
                        {
                            for $codTipoProducto in $transaccionTarjetaCredito/ns1:valNumeroOriginal/ns1:codTipoProducto
                            return
                                <CARD_NUMBER>{ data($codTipoProducto) }</CARD_NUMBER>
                        }
                        {
                            for $valNombreTitular in $transaccionTarjetaCredito/ns1:valNombreTitular
                            return
                                <CARD_HOLDER_NAME>{ data($valNombreTitular) }</CARD_HOLDER_NAME>
                        }
                        {
                            for $valFechaTransaccion in $transaccionTarjetaCredito/ns1:valFechaTransaccion
                            return
                                <TRANSACTION_DATE>{ formatearFecha(data($valFechaTransaccion)) }</TRANSACTION_DATE>
                        }
                        {
                            for $descripcion in $transaccionTarjetaCredito/ns1:descripcion
                            return
                                <DESCRIPTION>{ data($descripcion) }</DESCRIPTION>
                        }
                        {
                            for $valMonto in $transaccionTarjetaCredito/ns1:valMonto
                            return
                                <AMOUNT>{ data($valMonto) }</AMOUNT>
                        }
                        {
                            for $valSimboloMoneda in $transaccionTarjetaCredito/ns1:valMoneda/ns1:valSimboloMoneda
                            return
                                <CURRENCY>{ data($valSimboloMoneda) }</CURRENCY>
                        }
                        {
                            for $valMontoOriginal in $transaccionTarjetaCredito/ns1:valMontoOriginal
                            return
                                <ORIGINAL_AMOUNT>{ data($valMontoOriginal) }</ORIGINAL_AMOUNT>
                        }
                        {
                            for $valCodigoOriginalMoneda in $transaccionTarjetaCredito/ns1:valCodigoOriginalMoneda
                            return
                                <ORIGINAL_CURRENCY>{ data($valCodigoOriginalMoneda) }</ORIGINAL_CURRENCY>
                        }
                        {
                            for $valTipoTransaccion in $transaccionTarjetaCredito/ns1:valTipoTransaccion
                            return
                                <TYPE_OF_TRANSACTION>{ data($valTipoTransaccion) }</TYPE_OF_TRANSACTION>
                        }
                    </MOV>
            }
        </MOVS>
};

declare variable $opConsultaMovimientosTarjetaCreditoRespuesta as element(ns3:opConsultaMovimientosTarjetaCreditoRespuesta) external;

xf:consultaMovsRecientesTCNIOut($opConsultaMovimientosTarjetaCreditoRespuesta)