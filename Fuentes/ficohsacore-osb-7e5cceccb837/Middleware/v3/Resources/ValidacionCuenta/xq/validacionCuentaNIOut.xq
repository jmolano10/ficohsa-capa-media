<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[(:: pragma bea:global-element-parameter parameter="$opConsultaDetalleCuentaRespuesta" element="ns0:opConsultaDetalleCuentaRespuesta" location="../../../../v2/BusinessServices/CTS/cuenta/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns2:validacionCuentaResponse" location="../xsd/validacionCuentaType.xsd" ::)

declare namespace ns0 = "http://service.srvaplcobiscuenta.ecobis.cobiscorp";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaType";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ValidacionCuenta/xq/validacionCuentaNIOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://dto2.commons.ecobis.cobiscorp";

declare function xf:validacionCuentaNIOut($opConsultaDetalleCuentaRespuesta as element(ns0:opConsultaDetalleCuentaRespuesta))
    as element(ns2:validacionCuentaResponse) {
        <ns2:validacionCuentaResponse>
             {
                for $codCuentaHabiente in $opConsultaDetalleCuentaRespuesta/ns1:cuenta/ns1:codCuentaHabiente
                return
                    <ACCOUNT_NUMBER>{ data($codCuentaHabiente) }</ACCOUNT_NUMBER>
            }
            {
                for $valCuentaHabiente in $opConsultaDetalleCuentaRespuesta/ns1:cuenta/ns1:valCuentaHabiente
                return
                    <ACCOUNT_NAME>{ data($valCuentaHabiente) }</ACCOUNT_NAME>
            }
            {
                for $valTipoMoneda in $opConsultaDetalleCuentaRespuesta/ns1:cuenta/ns1:moneda/ns1:valTipoMoneda
                return
                    <CURRENCY>{ data($valTipoMoneda) }</CURRENCY>
            }
            {
            	let $estado := data($opConsultaDetalleCuentaRespuesta/ns1:cuenta/ns1:productoResumen/ns1:codEstado)
            	return
            	(
            		if($estado = "I") then(
            			<ACCOUNT_STATUS>INACTIVE</ACCOUNT_STATUS>
            		)
            		else (
            			<ACCOUNT_STATUS>ACTIVE</ACCOUNT_STATUS>
            		)
            	)
            }
            {
            	let $tipo := data($opConsultaDetalleCuentaRespuesta/ns1:cuenta/ns1:codTipoProducto)
            	return
            	(
            		if($tipo = "CTE") then(
            			<PRODUCT_TYPE>CHQ</PRODUCT_TYPE>
            		)
            		else (
            			<PRODUCT_TYPE>AHO</PRODUCT_TYPE>
            		)
            	)
            }   
            <CUSTOMER_ID>{ data($opConsultaDetalleCuentaRespuesta/ns1:cuenta/ns1:cliente/ns1:codCliente) }</CUSTOMER_ID>
            {
                for $codigoIBAN in $opConsultaDetalleCuentaRespuesta/ns1:cuenta/ns1:codigoIBAN
                return
                    <INTERNATIONAL_ACCOUNT_NUMBER>{ data($codigoIBAN) }</INTERNATIONAL_ACCOUNT_NUMBER>
            }
        </ns2:validacionCuentaResponse>
};

declare variable $opConsultaDetalleCuentaRespuesta as element(ns0:opConsultaDetalleCuentaRespuesta) external;

xf:validacionCuentaNIOut($opConsultaDetalleCuentaRespuesta)]]></con:xquery>
    <con:dependency location="../../../../v2/BusinessServices/CTS/cuenta/xsd/services.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CTS/cuenta/xsd/services"/>
    </con:dependency>
    <con:dependency location="../xsd/validacionCuentaType.xsd">
        <con:schema ref="Middleware/v3/Resources/ValidacionCuenta/xsd/validacionCuentaType"/>
    </con:dependency>
</con:xqueryEntry>