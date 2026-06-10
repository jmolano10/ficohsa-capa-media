<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opBuscarSaldoReservadoRespuesta1" element="ns1:opBuscarSaldoReservadoRespuesta" location="../../../BusinessServices/CTS/cuenta/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns2:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://service.srvaplcobiscuenta.ecobis.cobiscorp";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleSaldosPignorados/xq/consultaDetSaldosPignoradosNIHeaderOut/";

declare function xf:consultaDetSaldosPignoradosNIHeaderOut($opBuscarSaldoReservadoRespuesta1 as element(ns1:opBuscarSaldoReservadoRespuesta))
    as element(ns2:ResponseHeader) {
        <ns2:ResponseHeader>
            {
            	let $successIndicator := fn:string($opBuscarSaldoReservadoRespuesta1/ns0:contextoRespuesta/ns0:codTipoRespuesta/text())
            	let $message := fn:string($opBuscarSaldoReservadoRespuesta1/ns0:contextoRespuesta/ns0:valDescripcionRespuesta/text())
            	return 
	            	if ($successIndicator  = "0") then (
	            		<successIndicator>Success</successIndicator>
	            	) else (
	            		<successIndicator>{ $successIndicator }</successIndicator>,
	            		<messages>{ $message }</messages>
	            	) 
            }
        </ns2:ResponseHeader>
};

declare variable $opBuscarSaldoReservadoRespuesta1 as element(ns1:opBuscarSaldoReservadoRespuesta) external;

xf:consultaDetSaldosPignoradosNIHeaderOut($opBuscarSaldoReservadoRespuesta1)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/CTS/cuenta/xsd/services.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CTS/cuenta/xsd/services"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>