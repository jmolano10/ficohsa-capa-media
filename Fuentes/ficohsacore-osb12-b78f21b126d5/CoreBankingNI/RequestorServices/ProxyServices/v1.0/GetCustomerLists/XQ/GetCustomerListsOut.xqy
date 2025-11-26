xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/consultaListasCliente";
(:: import schema at "../../../../../../MWBanking/Compliances/RequestorServices/XSD/getCustomerLists.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCustomerLists";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerLists/GetCustomerLists_sp.xsd" ::)
declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $customerId as xs:string external;
declare variable $GetCustomerListsResponse as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare function local:func($uuid as xs:string,
                            $customerId as xs:string,
                            $GetCustomerListsResponse as element() (:: schema-element(ns1:OutputParameters) ::)) 
                            as element() (:: schema-element(ns2:getCustomerListsResponse) ::) {
    <ns2:getCustomerListsResponse>
      <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
        <ns2:CustomerId>{fn:data($customerId)}</ns2:CustomerId>
        <ns2:AssociationsList>
          {
            for $Row in $GetCustomerListsResponse/ns1:RowSet/ns1:Row
            return(
                <ns2:Association>
                  <ns2:AssociationName>{fn:data($Row/ns1:Column[@name = 'association_name'])}</ns2:AssociationName>
                  <ns2:CustomerStatus>{fn:data($Row/ns1:Column[@name = 'customer_status'])}</ns2:CustomerStatus>
                </ns2:Association>
            )
          }
        </ns2:AssociationsList> 
    </ns2:getCustomerListsResponse>
};

local:func($uuid, $customerId, $GetCustomerListsResponse)