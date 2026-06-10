<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opConsultaSaldosTarjetaCreditoRespuesta" element="ns3:opConsultaSaldosTarjetaCreditoRespuesta" location="../../../BusinessServices/CTS/tarjetaCredito/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/consultaSaldosTCNIHeaderOut/";
declare namespace ns3 = "http://service.srvaplcobistarjetacredito.ecobis.cobiscorp";

declare function xf:consultaSaldosTCNIHeaderOut($opConsultaSaldosTarjetaCreditoRespuesta as element(ns3:opConsultaSaldosTarjetaCreditoRespuesta))
    as element(ns0:ResponseHeader) {
 		<ns0:ResponseHeader>
            {
            	let $successIndicator := fn:string($opConsultaSaldosTarjetaCreditoRespuesta/ns1:contextoRespuesta/ns1:codTipoRespuesta/text())
            	let $message := fn:string($opConsultaSaldosTarjetaCreditoRespuesta/ns1:contextoRespuesta/ns1:valDescripcionRespuesta/text())
            	return 
	            	if ($successIndicator  = "0") then (
	            		<successIndicator>Success</successIndicator>
	            	) else (
	            		<successIndicator>{ $successIndicator }</successIndicator>,
	            		<messages>{ $message }</messages>
	            	) 
            }
        </ns0:ResponseHeader>
};

declare variable $opConsultaSaldosTarjetaCreditoRespuesta as element(ns3:opConsultaSaldosTarjetaCreditoRespuesta) external;

xf:consultaSaldosTCNIHeaderOut($opConsultaSaldosTarjetaCreditoRespuesta)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/CTS/tarjetaCredito/xsd/services.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CTS/tarjetaCredito/xsd/services"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>