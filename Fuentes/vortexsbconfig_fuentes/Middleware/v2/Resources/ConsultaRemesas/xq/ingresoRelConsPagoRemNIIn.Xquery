<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaMultipleRemesadorasNIResponse" element="ns1:sjConsultaMultipleRemesadorasNIResponse" location="../../../BusinessServices/SJS/consultaMultipleRemesadorasNI/xsd/sjConsultaMultipleRemesadorasNI.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/registraRelConsPagoRemNI/xsd/ingresoRelConsPagoRem_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleRemesadorasNI";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ingresoRelConsPagoRem";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesas/xq/ingresoRelConsPagoRemNIIn/";

declare function xf:ingresoRelConsPagoRemNIIn($sjConsultaMultipleRemesadorasNIResponse as element(ns1:sjConsultaMultipleRemesadorasNIResponse))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CODIGOCONTRATO>{ data($sjConsultaMultipleRemesadorasNIResponse/ns1:REMITTANCE/ns1:ROUTER_RESPONSE/ns1:AGREEMENT_ID) }</ns0:PV_CODIGOCONTRATO>
            <ns0:PV_CLAVEREMESA>{ data($sjConsultaMultipleRemesadorasNIResponse/ns1:REMITTANCE/ns1:ROUTER_RESPONSE/ns1:REMITTANCE_ID) }</ns0:PV_CLAVEREMESA>
            <ns0:PV_MONEDA>{ data($sjConsultaMultipleRemesadorasNIResponse/ns1:REMITTANCE/ns1:ROUTER_RESPONSE/ns1:CURRENCY) }</ns0:PV_MONEDA>
            <ns0:PD_FECHAREMESA>{ data($sjConsultaMultipleRemesadorasNIResponse/ns1:REMITTANCE/ns1:ROUTER_RESPONSE/ns1:REMITTANCE_DATE) }</ns0:PD_FECHAREMESA>
            <ns0:PN_MONTO>{ data($sjConsultaMultipleRemesadorasNIResponse/ns1:REMITTANCE/ns1:ROUTER_RESPONSE/ns1:REMITTANCE_SOURCE_AMOUNT) }</ns0:PN_MONTO>
            <ns0:PV_REMITENTE>{ data($sjConsultaMultipleRemesadorasNIResponse/ns1:REMITTANCE/ns1:ROUTER_RESPONSE/ns1:REMITTER_NAME) }</ns0:PV_REMITENTE>
            <ns0:PV_BENEFICIARIO>{ data($sjConsultaMultipleRemesadorasNIResponse/ns1:REMITTANCE/ns1:ROUTER_RESPONSE/ns1:BENEFICIARY_NAME) }</ns0:PV_BENEFICIARIO>
            <ns0:PV_PAISORIGEN>{ data($sjConsultaMultipleRemesadorasNIResponse/ns1:REMITTANCE/ns1:ROUTER_RESPONSE/ns1:ORIGIN_COUNTRY) }</ns0:PV_PAISORIGEN>
            <ns0:PV_CODIGOTRANSACCION>{ data($sjConsultaMultipleRemesadorasNIResponse/ns1:REMITTANCE/ns1:ROUTER_RESPONSE/ns1:TRANSACTION_ID) }</ns0:PV_CODIGOTRANSACCION>
            <ns0:PV_CODORDEN>{ data($sjConsultaMultipleRemesadorasNIResponse/ns1:REMITTANCE/ns1:ROUTER_RESPONSE/ns1:ORDER_ID) }</ns0:PV_CODORDEN>
        </ns0:InputParameters>
};

declare variable $sjConsultaMultipleRemesadorasNIResponse as element(ns1:sjConsultaMultipleRemesadorasNIResponse) external;

xf:ingresoRelConsPagoRemNIIn($sjConsultaMultipleRemesadorasNIResponse)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/SJS/consultaMultipleRemesadorasNI/xsd/sjConsultaMultipleRemesadorasNI.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/consultaMultipleRemesadorasNI/xsd/sjConsultaMultipleRemesadorasNI"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/registraRelConsPagoRemNI/xsd/ingresoRelConsPagoRem_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/registraRelConsPagoRemNI/xsd/ingresoRelConsPagoRem_sp"/>
    </con:dependency>
</con:xqueryEntry>