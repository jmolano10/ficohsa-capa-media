xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/conListadoPrestamos";
(:: import schema at "../../../../ProviderServices/XSD/GetCustomerLiabilities/GetLiabilitiesList_BS.xsd" ::)

declare namespace ns1="http://www.ficohsa.hn/middleware.services/getLiabilitiesList";

declare variable $customerId as xs:string external;
declare variable $countryCode as xs:string external;

declare function ns1:getLiabilitiesList($customerId as xs:string, 
                                        $countryCode as xs:string) 
                                        as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:Pais>{fn:data($countryCode)}</ns2:Pais>
        <ns2:NumeroB>{fn:data($customerId)}</ns2:NumeroB>
        <ns2:Tipo>2</ns2:Tipo>
    </ns2:InputParameters>
};

ns1:getLiabilitiesList($customerId, $countryCode)