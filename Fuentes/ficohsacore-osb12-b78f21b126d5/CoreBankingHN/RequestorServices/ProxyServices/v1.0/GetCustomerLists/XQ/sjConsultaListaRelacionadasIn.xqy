xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getCustomerListsHN_SJ";
(:: import schema at "../XSD/GetCustomerListsHN_SJ.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCustomerRelatedList";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerRelatedList/GetCustomerRelatedList_sp.xsd" ::)

declare variable $getCustomerListsHN_SJRequest as element() (:: schema-element(ns1:getCustomerListsHN_SJRequest) ::) external;

declare function local:func($getCustomerListsHN_SJRequest as element() (:: schema-element(ns1:getCustomerListsHN_SJRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:PV_INDETIDAD>{fn:data($getCustomerListsHN_SJRequest/ns1:CUSTOMER_LEGAL_ID)}</ns2:PV_INDETIDAD>
    </ns2:InputParameters>
};

local:func($getCustomerListsHN_SJRequest)