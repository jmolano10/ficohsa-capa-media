<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opPagoTarjetaCreditoRespuesta" element="ns2:opPagoTarjetaCreditoRespuesta" location="../../../BusinessServices/CTS/pagoTarjetaCredito/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobiscanalesentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://service.srvaplcobistarjetacreditov2.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoTarjetaCredito/xq/pagoTCNIHeaderOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://dto2.commons.ecobis.cobiscorp";

declare function xf:pagoTCNIHeaderOut($opPagoTarjetaCreditoRespuesta as element(ns2:opPagoTarjetaCreditoRespuesta))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                let $successIndicator:= fn:string($opPagoTarjetaCreditoRespuesta/ns0:contextoRespuesta/ns0:codTipoRespuesta/text())
                let $messages:= fn:string($opPagoTarjetaCreditoRespuesta/ns0:contextoRespuesta/ns0:valDescripcionRespuesta/text())
                let $idTransaccion:= fn:string($opPagoTarjetaCreditoRespuesta/ns0:resulsetPagoTarjetaCredito/ns0:idTransaccion/text())
                return
                	if($successIndicator = "0")then(
                	    <transactionId>{$idTransaccion}</transactionId>,
                		<successIndicator>Success</successIndicator>	 
                	)else(
                		<successIndicator>{$successIndicator}</successIndicator>,
                		<messages>{$messages}</messages>
                	)        
            }
           
        </ns1:ResponseHeader>
};

declare variable $opPagoTarjetaCreditoRespuesta as element(ns2:opPagoTarjetaCreditoRespuesta) external;

xf:pagoTCNIHeaderOut($opPagoTarjetaCreditoRespuesta)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/CTS/pagoTarjetaCredito/xsd/services.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CTS/pagoTarjetaCredito/xsd/services"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>