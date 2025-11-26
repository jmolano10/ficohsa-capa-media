xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="urn:tailored.icbanking.services.sara";
(:: import schema at "../../../../ProviderServices/WSDL/SaraService/SaraService.wsdl" ::)

declare variable $searchItem as xs:string external;

declare function local:func($searchItem as xs:string) as element() (:: schema-element(ns2:GetServicePaymentEntitiesWithTagsForSaraMessageIn) ::) {
    <ns2:GetServicePaymentEntitiesWithTagsForSaraMessageIn>
        <ns2:searchTerm>{fn:data($searchItem)}</ns2:searchTerm>
    </ns2:GetServicePaymentEntitiesWithTagsForSaraMessageIn>
};

local:func($searchItem)