xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaPasivosCliente";
(:: import schema at "../../../../ProviderServices/XSD/GetCustomerLiabilities/GetCustomerLiabilities_BS.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/getCustomerLiabilitiesIn";

declare variable $customerId as xs:string external;
declare variable $liabilityType as xs:string external;

declare function ns1:getCustomerLiabilitiesIn($customerId as xs:string, 
                                              $liabilityType as xs:string) 
                                              as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:CUSTOMER_ID>{fn:data($customerId)}</ns2:CUSTOMER_ID>
        <ns2:LIABILITY_TYPE>{fn:data($liabilityType)}</ns2:LIABILITY_TYPE>
    </ns2:InputParameters>
};

ns1:getCustomerLiabilitiesIn($customerId, $liabilityType)