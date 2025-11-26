<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[(:: pragma bea:global-element-parameter parameter="$opConsultaDetalleCuentaRespuesta1" element="ns2:opConsultaDetalleCuentaRespuesta" location="../../../BusinessServices/CTS/cuenta/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetallesCuentaResponse" location="../xsd/consultaDetallesCuentaTypes.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://service.srvaplcobiscuenta.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetallesCuenta/xq/consultaDetCuentaNIOut/";

declare function xf:consultaDetCuentaNIOut($opConsultaDetalleCuentaRespuesta1 as element(ns2:opConsultaDetalleCuentaRespuesta))
    as element(ns1:consultaDetallesCuentaResponse) {
        <ns1:consultaDetallesCuentaResponse>
            <ns1:consultaDetallesCuentaResponseType>
                <ns1:consultaDetallesCuentaResponseRecordType>
                    <ACCOUNT_NUMBER>{ data($opConsultaDetalleCuentaRespuesta1/ns0:cuenta/ns0:codCuentaHabiente) }</ACCOUNT_NUMBER>
                    <CUSTOMER_ID>{ data($opConsultaDetalleCuentaRespuesta1/ns0:cuenta/ns0:cliente/ns0:codCliente) }</CUSTOMER_ID>
                    <ACCOUNT_NAME>{ data($opConsultaDetalleCuentaRespuesta1/ns0:cuenta/ns0:valCuentaHabiente) }</ACCOUNT_NAME>
                    <CATEGORY>{ data($opConsultaDetalleCuentaRespuesta1/ns0:cuenta/ns0:codTipoProducto) }</CATEGORY>
                    <CURRENCY>{ data($opConsultaDetalleCuentaRespuesta1/ns0:cuenta/ns0:moneda/ns0:valTipoMoneda) }</CURRENCY>
                    <RESTRICTIONS>{ data($opConsultaDetalleCuentaRespuesta1/ns0:cuenta/ns0:productoResumen/ns0:valActividadEconomica) }</RESTRICTIONS>
                    <OPERATION_TYPE>{ data($opConsultaDetalleCuentaRespuesta1/ns0:cuenta/ns0:productoResumen/ns0:codTipoOperacion) }</OPERATION_TYPE>
                    <ACCOUNT_OFFICER>{ data($opConsultaDetalleCuentaRespuesta1/ns0:cuenta/ns0:productoResumen/ns0:valContador) }</ACCOUNT_OFFICER>
                    <BRANCH_CODE>{ data($opConsultaDetalleCuentaRespuesta1/ns0:cuenta/ns0:oficina/ns0:codOficina) }</BRANCH_CODE>
                    <REQUIRED_SIGNATURES>{ data($opConsultaDetalleCuentaRespuesta1/ns0:cuenta/ns0:productoResumen/ns0:valFirmasRequeridas) }</REQUIRED_SIGNATURES>
                    <INTERNATIONAL_ACCOUNT_NUMBER>{ data($opConsultaDetalleCuentaRespuesta1/ns0:cuenta/ns0:codigoIBAN) }</INTERNATIONAL_ACCOUNT_NUMBER>
                </ns1:consultaDetallesCuentaResponseRecordType>
            </ns1:consultaDetallesCuentaResponseType>
        </ns1:consultaDetallesCuentaResponse>
};

declare variable $opConsultaDetalleCuentaRespuesta1 as element(ns2:opConsultaDetalleCuentaRespuesta) external;

xf:consultaDetCuentaNIOut($opConsultaDetalleCuentaRespuesta1)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/CTS/cuenta/xsd/services.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CTS/cuenta/xsd/services"/>
    </con:dependency>
    <con:dependency location="../xsd/consultaDetallesCuentaTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaDetallesCuenta/xsd/consultaDetallesCuentaTypes"/>
    </con:dependency>
</con:xqueryEntry>