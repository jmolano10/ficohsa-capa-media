xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCustomerDebitCardsPA_BS";
(:: import schema at "../../../../ProviderServices/XSD/GetCustomerDebitCards/GetCustomerDebitCardsPA_BS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $customerId as xs:string external;
declare variable $cardStatus as xs:string external;

declare function xq:GetCustomerDebitCardsGTIn($customerId as xs:string, 
                                              $cardStatus as xs:string) 
                                              as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:CUSTOMER_ID>{fn:data($customerId)}</ns1:CUSTOMER_ID>
        <ns1:CARD_STATUS>{fn:data($cardStatus)}</ns1:CARD_STATUS>
    </ns1:InputParameters>
};

xq:GetCustomerDebitCardsGTIn($customerId, $cardStatus)