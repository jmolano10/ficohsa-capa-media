xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getServicesDetailsTypes";
(:: import schema at "../../../../../MWBanking/Services/RequestorServices/XSD/getServicesDetailsTypes.xsd" ::)
declare namespace ns2="urn:tailored.icbanking.services.sara";
(:: import schema at "../../../../ProviderServices/WSDL/SaraService/SaraService.wsdl" ::)

declare variable $paymentEntity as xs:string external;

declare function local:func($paymentEntity as xs:string) as element() (:: schema-element(ns2:GetServicePaymentEntityForSaraByIdMessageIn) ::) {
    <ns2:GetServicePaymentEntityForSaraByIdMessageIn>
        <ns2:ServicePaymentEntityId>{fn:data($paymentEntity)}</ns2:ServicePaymentEntityId>
    </ns2:GetServicePaymentEntityForSaraByIdMessageIn>
};

local:func($paymentEntity)