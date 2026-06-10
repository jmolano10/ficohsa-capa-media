<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../consultarRecaudoReferenciadoEnLinea/xsd/FLINK_OSB_K_RECAUDOS_REF_ONLINE_OSB_CONSULTAR_REF_ONLINE.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleContratoRecaudosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_K_RECAUDOS_REF_ONLINE/OSB_CONSULTAR_REF_ONLINE/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleContratoRecaudos/xq/consultaReferenciadoEnLineaIn/";

declare function xf:consultaReferenciadoEnLineaIn($contractId as xs:string)
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:CODIGO_CONTRATO>{ $contractId }&lt;/ns1:CODIGO_CONTRATO>
        &lt;/ns1:InputParameters>
};

declare variable $contractId as xs:string external;

xf:consultaReferenciadoEnLineaIn($contractId)</con:xquery>
    <con:dependency location="../../../consultarRecaudoReferenciadoEnLinea/xsd/FLINK_OSB_K_RECAUDOS_REF_ONLINE_OSB_CONSULTAR_REF_ONLINE.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/consultarRecaudoReferenciadoEnLinea/xsd/FLINK_OSB_K_RECAUDOS_REF_ONLINE_OSB_CONSULTAR_REF_ONLINE"/>
    </con:dependency>
</con:xqueryEntry>