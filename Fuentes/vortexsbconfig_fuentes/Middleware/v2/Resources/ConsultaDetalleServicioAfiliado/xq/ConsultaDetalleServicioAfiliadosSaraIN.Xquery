<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns3:GetSiteServicePaymentEntitiesForSaraByDocumentNumberMessageIn" location="../wsdl/consultaDetalleServiciosAfiliadosPS.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ProductosAfiliados/consultaProductosAfiliados/xq/Tx_SaraServiceRequest/";
declare namespace ns2 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns1 = "urn:infocorp.framework.businessentities.security";
declare namespace ns4 = "urn:infocorp.framework.businessentities.common";
declare namespace ns3 = "urn:tailored.icbanking.services.sara";
declare namespace ns0 = "urn:infocorp.framework.services.common";

declare function xf:ConsultaDetalleServicioAfiliadosSaraIN($PaymentEntityId as xs:string)
    as element(ns3:GetSiteServicePaymentEntitiesForSaraByIdMessageIn) {
        &lt;ns3:GetSiteServicePaymentEntitiesForSaraByIdMessageIn>
         &lt;ns3:SiteServicePaymentEntityId>{ data($PaymentEntityId) }&lt;/ns3:SiteServicePaymentEntityId>
      &lt;/ns3:GetSiteServicePaymentEntitiesForSaraByIdMessageIn>
};

declare variable $PaymentEntityId as xs:string external;

xf:ConsultaDetalleServicioAfiliadosSaraIN($PaymentEntityId)</con:xquery>
    <con:dependency location="../wsdl/consultaDetalleServiciosAfiliadosPS.wsdl">
        <con:wsdl ref="Middleware/v2/Resources/ConsultaDetalleServicioAfiliado/wsdl/consultaDetalleServiciosAfiliadosPS"/>
    </con:dependency>
</con:xqueryEntry>