xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/consultaTDCliente";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/getCustomerDebitCards.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCustomerDebitCards";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerDebitCards/GetCustomerDebitCards_sp.xsd" ::)
declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $customerId as xs:string external;
declare variable $uuid as xs:string external;
declare variable $GetCustomerDebitCardsResponse as element() (:: schema-element(ns2:OutputParameters) ::) external;

declare function local:func($customerId as xs:string,
                            $uuid as xs:string,
                            $GetCustomerDebitCardsResponse as element() (:: schema-element(ns2:OutputParameters) ::)) 
                            as element() (:: schema-element(ns1:getCustomerDebitCardsResponse) ::) {
    <ns1:getCustomerDebitCardsResponse>
        <ns1:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns1:StatusInfo>
        <ns1:CustomerId>{fn:data($customerId)}</ns1:CustomerId>
          {
            for $Row in $GetCustomerDebitCardsResponse/ns2:RowSet/ns2:Row
            return(
                <ns1:DebitCards>
                    <ns2:CardNumber>{fn:data($Row/ns2:Column[@name = 'CardNumber'])}</ns2:CardNumber>
                    <ns2:CardHolderName>{fn:data($Row/ns2:Column[@name = 'CardHolderName'])}</ns2:CardHolderName>
                    <ns2:Category>{fn:data($Row/ns2:Column[@name = 'Category'])}</ns2:Category>
                    <ns2:Type>{fn:data($Row/ns2:Column[@name = 'Type'])}</ns2:Type>
                    <ns2:IssuedDate>{fn:data($Row/ns2:Column[@name = 'IssuedDate'])}</ns2:IssuedDate> 
                </ns1:DebitCards>
            )
          }  
    </ns1:getCustomerDebitCardsResponse>
};

local:func($customerId, $uuid, $GetCustomerDebitCardsResponse)