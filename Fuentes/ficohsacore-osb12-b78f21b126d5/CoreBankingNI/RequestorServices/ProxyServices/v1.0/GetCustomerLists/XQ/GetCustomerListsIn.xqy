xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCustomerLists";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerLists/GetCustomerLists_sp.xsd" ::)

declare variable $customerId as xs:string external;

declare function local:func($customerId as xs:string) as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:i_CUSTOMER_ID>{fn:data($customerId)}</ns1:i_CUSTOMER_ID>
    </ns1:InputParameters>
};

local:func($customerId)