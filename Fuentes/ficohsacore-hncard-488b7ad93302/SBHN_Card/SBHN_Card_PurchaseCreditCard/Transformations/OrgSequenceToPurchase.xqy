xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/osbConOrgSequence";
(:: import schema at "../Schemas/osbConOrgSequence_sp.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/card";
(:: import schema at "../Schemas/PurchaseCreditCardTypes.xsd" ::)

declare variable $dbResponse as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $globalId as xs:string external;

declare function local:funcOrgSequenceToPurchase($dbResponse as element() (:: schema-element(ns1:OutputParameters) ::),
                                                  $globalId as xs:string) as element() (:: schema-element(ns2:purchaseCreditCardResponse) ::) {
    <ns2:purchaseCreditCardResponse>
      <StatusInfo>
          <Status>Success</Status>
          {
              if ($dbResponse/ns1:SequenceValue)
              then <TransactionId>{fn:data($dbResponse/ns1:SequenceValue)}</TransactionId>
              else ()
          }
          <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
          <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
          <GlobalId>{fn:data($globalId)}</GlobalId>
      </StatusInfo>  
    </ns2:purchaseCreditCardResponse>

};

local:funcOrgSequenceToPurchase($dbResponse, $globalId)