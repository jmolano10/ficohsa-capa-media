<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns3:GetServicePaymentEntitiesWithTagsForSaraMessageIn" location="../wsdl/consultaListaServiciosPS.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/ICB/SaraService/xq/ConsultaListaServiciosSaraIN";
declare namespace ns2 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns1 = "urn:infocorp.framework.businessentities.security";
declare namespace ns4 = "urn:infocorp.framework.businessentities.common";
declare namespace ns3 = "urn:tailored.icbanking.services.sara";
declare namespace ns0 = "urn:infocorp.framework.services.common";

declare function xf:ConsultaListaServiciosSaraIN($searchTerm as xs:string)
    as element(ns3:GetServicePaymentEntitiesWithTagsForSaraMessageIn) {
        &lt;ns3:GetServicePaymentEntitiesWithTagsForSaraMessageIn>
         &lt;ns3:searchTerm>{ data($searchTerm) }&lt;/ns3:searchTerm>
      &lt;/ns3:GetServicePaymentEntitiesWithTagsForSaraMessageIn>
};

declare variable $searchTerm as xs:string external;

xf:ConsultaListaServiciosSaraIN($searchTerm)</con:xquery>
    <con:dependency location="../wsdl/consultaListaServiciosPS.wsdl">
        <con:wsdl ref="Middleware/v2/Resources/ConsultaListaServicios/wsdl/consultaListaServiciosPS"/>
    </con:dependency>
</con:xqueryEntry>