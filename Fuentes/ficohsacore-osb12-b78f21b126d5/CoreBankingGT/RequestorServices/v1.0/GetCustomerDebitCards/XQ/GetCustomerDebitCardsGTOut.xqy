<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/consultaTDCliente";
(:: import schema at "../../../../../MWBanking/Customers/RequestorServices/XSD/getCustomerDebitCards.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCustomerDebitCardsGT_BS";
(:: import schema at "../../../../ProviderServices/XSD/GetCustomerDebitCards/GetCustomerDebitCardsGT_BS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $outputParameters as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $uuid as xs:string external;
declare variable $customerId as xs:string external;

declare function xq:GetCustomerDebitCardsGTOut($outputParameters as element() (:: schema-element(ns1:OutputParameters) ::),$uuid as xs:string,
                                              $customerId as xs:string) as element() (:: schema-element(ns2:getCustomerDebitCardsResponse) ::) {
    <ns2:getCustomerDebitCardsResponse>
        <ns2:StatusInfo>
            {
                if ($outputParameters/ns1:ERROR_CODE)
                then <com:Status>{fn:data($outputParameters/ns1:ERROR_CODE)}</com:Status>
                else ()
            }
            <com:TransactionId></com:TransactionId>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
        <ns2:CustomerId>{fn:data($customerId)}</ns2:CustomerId>
            {
           
                for $i in (1 to max( (	count($outputParameters/ns1:CARD_NUMBER/ns1:CARD_NUMBER_ITEM),
                						count($outputParameters/ns1:CARD_HOLDER_NAME/ns1:CARD_HOLDER_NAME_ITEM),
                						count($outputParameters/ns1:CARD_CATEGORY/ns1:CARD_NUMBER_ITEM),
                                        count($outputParameters/ns1:CARD_TYPE/ns1:CARD_NUMBER_ITEM),
                                        count($outputParameters/ns1:CARD_ISSUE_DATE/ns1:CARD_NUMBER_ITEM),
                                        count($outputParameters/ns1:PRIMARY_ACCOUNT/ns1:CARD_NUMBER_ITEM),
                                        count($outputParameters/ns1:PRIMARY_ACCOUNT_CURRENCY/ns1:CARD_NUMBER_ITEM)
                						)))
                return        
        <ns2:DebitCards>
            <ns2:CardNumber>{ data($outputParameters/ns1:CARD_NUMBER/ns1:CARD_NUMBER_ITEM[$i]) }</ns2:CardNumber>
            <ns2:CardHolderName>{ data($outputParameters/ns1:CARD_HOLDER_NAME/ns1:CARD_HOLDER_NAME_ITEM[$i]) }</ns2:CardHolderName>
            <ns2:Category>{ data($outputParameters/ns1:CARD_CATEGORY/ns1:CARD_NUMBER_ITEM[$i]) }</ns2:Category>
            <ns2:Type>{ data($outputParameters/ns1:CARD_TYPE/ns1:CARD_NUMBER_ITEM[$i]) }</ns2:Type>
            <ns2:IssuedDate>{ data($outputParameters/ns1:CARD_ISSUE_DATE/ns1:CARD_NUMBER_ITEM[$i]) }</ns2:IssuedDate>
            <ns2:PrimaryAccount>{ data($outputParameters/ns1:PRIMARY_ACCOUNT/ns1:CARD_NUMBER_ITEM[$i]) }</ns2:PrimaryAccount>
            <ns2:PrimaryAccountCurrency>{ data($outputParameters/ns1:PRIMARY_ACCOUNT_CURRENCY/ns1:CARD_NUMBER_ITEM[$i]) }</ns2:PrimaryAccountCurrency>
        </ns2:DebitCards>
        }
    </ns2:getCustomerDebitCardsResponse>
};

xq:GetCustomerDebitCardsGTOut($outputParameters,$uuid,$customerId)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../../../../MWBanking/Customers/RequestorServices/XSD/getCustomerDebitCards.xsd">
            <con:schema ref="MWBanking/Customers/RequestorServices/XSD/getCustomerDebitCards"/>
        </con:importSchema>
        <con:importSchema location="../../../../ProviderServices/XSD/GetCustomerDebitCards/GetCustomerDebitCardsGT_BS_sp.xsd">
            <con:schema ref="CoreBankingGT/ProviderServices/XSD/GetCustomerDebitCards/GetCustomerDebitCardsGT_BS_sp"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>