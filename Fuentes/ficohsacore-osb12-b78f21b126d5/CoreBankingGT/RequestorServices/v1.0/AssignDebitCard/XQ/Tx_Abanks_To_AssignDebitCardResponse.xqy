xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/debitCardsTypes";
(:: import schema at "../../../../../MWBanking/DebitCards/RequestorServices/XSD/debitCardsTypes.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/AssignDebitCardGT_BS";
(:: import schema at "../../../../ProviderServices/XSD/AssignDebitCard/AssignDebitCardGT_BS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $input as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $uuid as xs:string external;

declare function xq:Tx_Abanks_To_AssignDebitCardResponse($input as element() (:: schema-element(ns1:OutputParameters) ::), 
                                                         $uuid as xs:string) 
                                                         as element() (:: schema-element(ns2:assignDebitCardResponse) ::) {
    <ns2:assignDebitCardResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:TransactionId></com:TransactionId>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
        {
            if ($input/ns1:PV_NO_TARJETA)
            then <ns2:CardNumber>{fn:data($input/ns1:PV_NO_TARJETA)}</ns2:CardNumber>
            else ()
        }
    </ns2:assignDebitCardResponse>
};

xq:Tx_Abanks_To_AssignDebitCardResponse($input, $uuid)