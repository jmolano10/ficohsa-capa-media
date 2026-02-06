xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns3:GetServicePaymentEntitiesWithTagsForSaraMessageIn" location="../wsdl/consultaListaServiciosPS.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/ICB/SaraService/xq/ConsultaListaServiciosSaraIN";
declare namespace ns2 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns1 = "urn:infocorp.framework.businessentities.security";
declare namespace ns4 = "urn:infocorp.framework.businessentities.common";
declare namespace ns3 = "urn:tailored.icbanking.services.sara";
declare namespace ns0 = "urn:infocorp.framework.services.common";

declare function xf:ConsultaListaServiciosSaraIN($searchTerm as xs:string)
    as element(ns3:GetServicePaymentEntitiesWithTagsForSaraMessageIn) {
        <ns3:GetServicePaymentEntitiesWithTagsForSaraMessageIn>
         <ns3:searchTerm>{ data($searchTerm) }</ns3:searchTerm>
      </ns3:GetServicePaymentEntitiesWithTagsForSaraMessageIn>
};

declare variable $searchTerm as xs:string external;

xf:ConsultaListaServiciosSaraIN($searchTerm)