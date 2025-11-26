xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCustomerDetailsNI";
(:: import schema at "../../../../ProviderServices/XSD/GetCustomerDetails/GetCustomerDetailsNI_sp.xsd" ::)

declare variable $customerId as xs:string external;
declare variable $QueryType as xs:string external;

declare function local:func($customerId as xs:string, $QueryType as xs:string) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:i_CUSTOMER_ID>{fn:data($customerId)}</ns2:i_CUSTOMER_ID>
        <ns2:i_LEGAL_ID>{fn:data($QueryType)}</ns2:i_LEGAL_ID>
    </ns2:InputParameters>
};

local:func($customerId, $QueryType)