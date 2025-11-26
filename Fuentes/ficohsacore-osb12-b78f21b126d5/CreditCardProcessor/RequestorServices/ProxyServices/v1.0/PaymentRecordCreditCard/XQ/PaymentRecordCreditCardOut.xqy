xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/PaymentRecordCreditCard";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/paymentRecordCreditCardTypes.xsd" ::)
declare namespace ns1="http://www.procesa.com/fdcs/ot";
(:: import schema at "../../../../../ProviderServices/WSDL/visionPlus/onlineTransactionsV4.wsdl" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $OnlinePaymentV4Response as element() (:: schema-element(ns1:OnlinePaymentV4Response) ::) external;
declare variable $ORG as xs:string external;
declare variable $sequenceValue as xs:string external;
declare variable $uuid as xs:string external;

declare function local:func($OnlinePaymentV4Response as element() (:: schema-element(ns1:OnlinePaymentV4Response) ::), 
                            $ORG as xs:string, 
                            $sequenceValue as xs:string,
                            $uuid as xs:string) 
                            as element() (:: schema-element(ns2:PaymentRecordCreditCardResponse) ::) {
    <ns2:PaymentRecordCreditCardResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
        <ns2:SecuencialNumber>{fn:data($sequenceValue)}</ns2:SecuencialNumber>
        <ns2:AuthorizationCode>{fn:data($OnlinePaymentV4Response/AuthorizationCode)}</ns2:AuthorizationCode>
        <ns2:Org>{fn:data($ORG)}</ns2:Org>
    </ns2:PaymentRecordCreditCardResponse>
};

local:func($OnlinePaymentV4Response, $ORG, $sequenceValue, $uuid)