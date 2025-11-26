xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/UpdateCustomer_BS";
(:: import schema at "../../../../ProviderServices/XSD/UpdateCustomer/UpdateCustomer_BS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $outputParameters as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $uuid as xs:string external;
declare variable $customerId as xs:string external;

declare function xq:updateCustomerOut($outputParameters as element() (:: schema-element(ns1:OutputParameters) ::), 
                                      $uuid as xs:string,$customerId as xs:string) 
                                      as element() (:: schema-element(ns2:updateCustomerResponse) ::) {
    <ns2:updateCustomerResponse>
        <ns2:StatusInfo>
            {
                if ($outputParameters/ns1:PV_RETURN_CODE)
                then <com:Status>{fn:data($outputParameters/ns1:PV_RETURN_CODE)}</com:Status>
                else ()
            }
            <com:TransactionId></com:TransactionId>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
        <ns2:CustomerId>{$customerId}</ns2:CustomerId>
    </ns2:updateCustomerResponse>
};

xq:updateCustomerOut($outputParameters, $uuid,$customerId)