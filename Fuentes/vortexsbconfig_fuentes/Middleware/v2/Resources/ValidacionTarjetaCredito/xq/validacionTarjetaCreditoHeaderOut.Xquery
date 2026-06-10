<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ValidacionTarjetaCredito/xsd/ConsultaDatosTarjetaCredito_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaDatosTarjetaCredito";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidacionTarjetaCredito/xq/validacionTarjetaCreditoHeaderOut/";

declare function xf:validacionTarjetaCreditoHeaderOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $MensajeError in $outputParameters1/ns0:MensajeError
                return
                    <messages>{ data($MensajeError) }</messages>
            }
            <successIndicator>{ "ERROR" }</successIndicator>
            <messageId></messageId>
        </ns1:ResponseHeader>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:validacionTarjetaCreditoHeaderOut($outputParameters1)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ValidacionTarjetaCredito/xsd/ConsultaDatosTarjetaCredito_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ValidacionTarjetaCredito/xsd/ConsultaDatosTarjetaCredito_sp"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>