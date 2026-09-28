xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns3:GetServicePaymentEntitiesWithTagsForSaraMessageIn" location="../wsdl/consultaDetalleServicioPS.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/ICB/SaraService/xq/ConsultaDetalleServicioSaraIN";
declare namespace ns2 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns1 = "urn:infocorp.framework.businessentities.security";
declare namespace ns4 = "urn:infocorp.framework.businessentities.common";
declare namespace ns3 = "urn:tailored.icbanking.services.sara";
declare namespace ns0 = "urn:infocorp.framework.services.common";

declare function xf:ConsultaDetalleServicioSaraIN($paymentEntity as xs:string)
    as element(ns3:GetServicePaymentEntityForSaraByIdMessageIn) {
        <ns3:GetServicePaymentEntityForSaraByIdMessageIn>
         <ns3:ServicePaymentEntityId>{ data($paymentEntity) }</ns3:ServicePaymentEntityId>
      </ns3:GetServicePaymentEntityForSaraByIdMessageIn>
};

declare variable $paymentEntity as xs:string external;

xf:ConsultaDetalleServicioSaraIN($paymentEntity)