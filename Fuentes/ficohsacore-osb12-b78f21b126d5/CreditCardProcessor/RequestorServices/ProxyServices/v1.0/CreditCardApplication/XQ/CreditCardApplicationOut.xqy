xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/creditCardApplicationTypes";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/creditCardApplicationTypes.xsd" ::)
declare namespace ns1="http://www.procesa.com/fdcs";
(:: import schema at "../../../../../ProviderServices/XSD/visionPlus/XMLSchema_769155616.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $EmbosserAddL8VBResponse as element() (:: schema-element(ns1:EmbosserAddL8VBResponse) ::) external;

declare function local:func($uuid as xs:string, 
                            $EmbosserAddL8VBResponse as element() (:: schema-element(ns1:EmbosserAddL8VBResponse) ::)) 
                            as element() (:: schema-element(ns2:creditCardApplicationResponse) ::) {
    <ns2:creditCardApplicationResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
         <ns2:LcyOrg>{fn:data($EmbosserAddL8VBResponse/AZXAPO-ORG)}</ns2:LcyOrg>
        <ns2:FcyOrg>{fn:data($EmbosserAddL8VBResponse/AZXAPO-FOREIGN-ORG)}</ns2:FcyOrg>
        <ns2:Logo>{fn:data($EmbosserAddL8VBResponse/AZXAPO-LOGO)}</ns2:Logo>
        <ns2:AccountNumber>{fn:data($EmbosserAddL8VBResponse/AZXAPO-ACCT)}</ns2:AccountNumber>
        <ns2:CardNumber>{fn:data($EmbosserAddL8VBResponse/AZXAPO-CARD-NBR)}</ns2:CardNumber>
        <ns2:CardSequence>{fn:data($EmbosserAddL8VBResponse/AZXAPO-CARD-SEQ)}</ns2:CardSequence>
        <ns2:ChipSequence>{fn:data($EmbosserAddL8VBResponse/AZXAPO-CURR-CHIP-SEQ)}</ns2:ChipSequence>
    </ns2:creditCardApplicationResponse>
};

local:func($uuid, $EmbosserAddL8VBResponse)