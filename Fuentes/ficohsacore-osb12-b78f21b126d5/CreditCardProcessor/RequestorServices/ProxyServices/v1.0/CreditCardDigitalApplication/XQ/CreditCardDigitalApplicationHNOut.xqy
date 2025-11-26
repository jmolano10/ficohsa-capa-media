xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/creditCardDigitalApplicationTypes";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/creditCardDigitalApplicationTypes.xsd" ::)
declare namespace ns1="http://www.procesa.com/fdcs";
(:: import schema at "../../../../../ProviderServices/WSDL/visionPlus/visionPlusService.wsdl" ::)
declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $rspInstantCardAddL8V7 as element() (:: schema-element(ns1:InstantCardAddL8V7Response) ::) external;

declare variable $uuid as xs:string external;
declare function local:func($uuid as xs:string,
                            $rspInstantCardAddL8V7 as element() (:: schema-element(ns1:InstantCardAddL8V7Response) ::)) as element() (:: schema-element(ns2:creditCardDigitalApplicationResponse) ::) {
    <ns2:creditCardDigitalApplicationResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
        <ns2:Org>{fn:data($rspInstantCardAddL8V7/AZXICO-ORG)}</ns2:Org>
        <ns2:Logo>{fn:data($rspInstantCardAddL8V7/AZXICO-LOGO)}</ns2:Logo>
        <ns2:CustomerNumber>{fn:data($rspInstantCardAddL8V7/AZXICO-CUST-NBR)}</ns2:CustomerNumber>
        <ns2:AccountNumber>{fn:data($rspInstantCardAddL8V7/AZXICO-ACCT-NBR)}</ns2:AccountNumber>
        <ns2:CardNumber>{fn:data($rspInstantCardAddL8V7/AZXICO-CARD-NBR)}</ns2:CardNumber>
        <ns2:CardSequenceNumber>{fn:data($rspInstantCardAddL8V7/AZXICO-CARD-SEQ-NBR)}</ns2:CardSequenceNumber>
        <ns2:CreditLimit>{fn:data($rspInstantCardAddL8V7/AZXICO-CRLIM)}</ns2:CreditLimit>
        <ns2:CardExpiryDate>{fn:data($rspInstantCardAddL8V7/AZXICO-CARD-DATE-EXPIRE)}</ns2:CardExpiryDate>
    </ns2:creditCardDigitalApplicationResponse>
};

local:func($uuid, $rspInstantCardAddL8V7)
