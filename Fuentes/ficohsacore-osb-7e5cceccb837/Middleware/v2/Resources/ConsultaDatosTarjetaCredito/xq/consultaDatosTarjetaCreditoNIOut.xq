(:: pragma bea:global-element-parameter parameter="$opConsultaDatosTarjetaCreditoRespuesta" element="ns3:opConsultaDatosTarjetaCreditoRespuesta" location="../../../BusinessServices/CTS/tarjetaCredito/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns2:consultaDatosTarjetaCreditoResponse" location="../../../../Business_Resources/tarjetaCredito/ConsultaDatosTarjetaCredito/consultaDatosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace ns1 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaCredito/xq/consultaDatosTarjetaCreditoOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://service.srvaplcobistarjetacredito.ecobis.cobiscorp";

declare function convertirStringFechaString($stringDate as xs:string?)
	as xs:string {
		if (fn-bea:trim($stringDate) != '') then 
			let $date := fn-bea:date-from-string-with-format("yyyy-MM-dd", $stringDate)
			return fn-bea:date-to-string-with-format("yyyyMMdd", $date)  
		else ("")
};

declare function xf:consultaDatosTarjetaCreditoOut($opConsultaDatosTarjetaCreditoRespuesta as element(ns3:opConsultaDatosTarjetaCreditoRespuesta))
    as element(ns2:consultaDatosTarjetaCreditoResponse) {
        <ns2:consultaDatosTarjetaCreditoResponse>
            <ns2:consultaDatosTarjetaCreditoResponseType>
                <ns2:consultaDatosTarjetaCreditoResponseRecordType>
                    {
                        for $codTipoProducto in $opConsultaDatosTarjetaCreditoRespuesta/ns0:datosTarjetaCredito/ns0:valNumeroTarjeta/ns0:valNumeroTC/ns0:codTipoProducto
                        return
                            <CARD_NUMBER>{ data($codTipoProducto) }</CARD_NUMBER>
                    }
                    {
                        for $valCuentaHabiente in $opConsultaDatosTarjetaCreditoRespuesta/ns0:datosTarjetaCredito/ns0:valCuenta/ns0:valCuentaHabiente
                        return
                            <ACCOUNT_HOLDER_NAME>{ data($valCuentaHabiente) }</ACCOUNT_HOLDER_NAME>
                    }
                    {
                        for $valNombreTarjetaHabiente in $opConsultaDatosTarjetaCreditoRespuesta/ns0:datosTarjetaCredito/ns0:valNumeroTarjeta/ns0:valNombreTarjetaHabiente
                        return
                            <CARD_HOLDER_NAME>{ data($valNombreTarjetaHabiente) }</CARD_HOLDER_NAME>
                    }
                    {
                        for $valTipoTarjeta in $opConsultaDatosTarjetaCreditoRespuesta/ns0:datosTarjetaCredito/ns0:valNumeroTarjeta/ns0:valTipoTarjeta
                        return
                            <CARD_TYPE>{ data($valTipoTarjeta) }</CARD_TYPE>
                    }
                    {
                        for $codCliente in $opConsultaDatosTarjetaCreditoRespuesta/ns0:datosTarjetaCredito/ns0:valCliente/ns0:codCliente
                        return
                            <CUSTOMER_ID>{ data($codCliente) }</CUSTOMER_ID>
                    }
                    {
                        for $valIdentificacionTarjetaHabiente in $opConsultaDatosTarjetaCreditoRespuesta/ns0:datosTarjetaCredito/ns0:valNumeroTarjeta/ns0:valIdentificacionTarjetaHabiente
                        return
                            <CARD_HOLDER_LEGAL_ID>{ data($valIdentificacionTarjetaHabiente) }</CARD_HOLDER_LEGAL_ID>
                    }
                    {
                        for $valIdCliente in $opConsultaDatosTarjetaCreditoRespuesta/ns0:datosTarjetaCredito/ns0:valCuenta/ns0:cliente/ns0:valIdCliente
                        return
                            <ACCOUNT_HOLDER_LEGAL_ID>{ data($valIdCliente) }</ACCOUNT_HOLDER_LEGAL_ID>
                    }
                    {
                        for $codCuentaHabiente in $opConsultaDatosTarjetaCreditoRespuesta/ns0:datosTarjetaCredito/ns0:valCuenta/ns0:codCuentaHabiente
                        return
                            <ACCOUNT_NUMBER>{ data($codCuentaHabiente) }</ACCOUNT_NUMBER>
                    }
                    {
                        for $codTipoProducto in $opConsultaDatosTarjetaCreditoRespuesta/ns0:datosTarjetaCredito/ns0:valProducto/ns0:codTipoProducto
                        return
                            <PRODUCT>{ data($codTipoProducto) }</PRODUCT>
                    }
                    {
                        for $valGrupoAfinidad in $opConsultaDatosTarjetaCreditoRespuesta/ns0:datosTarjetaCredito/ns0:valGrupoAfinidad
                        return
                            <AFINITY_GROUP>{ data($valGrupoAfinidad) }</AFINITY_GROUP>
                    }
                    {
                        for $valEstado in $opConsultaDatosTarjetaCreditoRespuesta/ns0:datosTarjetaCredito/ns0:valCuenta/ns0:productoResumen/ns0:valEstado
                        return
                            <ACCOUNT_STATUS>{ data($valEstado) }</ACCOUNT_STATUS>
                    }
                    {
                        for $valEstado in $opConsultaDatosTarjetaCreditoRespuesta/ns0:datosTarjetaCredito/ns0:valNumeroTarjeta/ns0:valNumeroTC/ns0:valEstado
                        return
                            <CARD_STATUS>{ data($valEstado) }</CARD_STATUS>
                    }
                    {
                        for $valFechaVencimiento in $opConsultaDatosTarjetaCreditoRespuesta/ns0:datosTarjetaCredito/ns0:valNumeroTarjeta/ns0:valFechaVencimiento
                        return
                            <CARD_EXPIRATION_DATE>{ convertirStringFechaString(data($valFechaVencimiento)) }</CARD_EXPIRATION_DATE>
                    }
                </ns2:consultaDatosTarjetaCreditoResponseRecordType>
            </ns2:consultaDatosTarjetaCreditoResponseType>
        </ns2:consultaDatosTarjetaCreditoResponse>
};

declare variable $opConsultaDatosTarjetaCreditoRespuesta as element(ns3:opConsultaDatosTarjetaCreditoRespuesta) external;

xf:consultaDatosTarjetaCreditoOut($opConsultaDatosTarjetaCreditoRespuesta)