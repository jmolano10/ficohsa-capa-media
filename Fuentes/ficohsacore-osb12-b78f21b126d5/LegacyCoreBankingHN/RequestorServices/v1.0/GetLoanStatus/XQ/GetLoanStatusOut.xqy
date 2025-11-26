xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/loansTypes";
(:: import schema at "../../../../../MWBanking/Loans/RequestorServices/XSD/loansTypes.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetLoanStatus_BS";
(:: import schema at "../../../../ProviderServices/XSD/GetLoanStatus/GetLoanStatus_BS_sp.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $getLoanStatusResponse as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $transactionId as xs:string external;
declare variable $uuid as xs:string external;

declare function local:func($getLoanStatusResponse as element() (:: schema-element(ns1:OutputParameters) ::), 
                            $transactionId as xs:string,
                            $uuid as xs:string) 
                            as element() (:: schema-element(ns2:getLoanStatusResponse) ::) {
                            
    <ns2:getLoanStatusResponse>
      <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
      </ns2:StatusInfo>
      <ns2:LoanDetails>
          {
              if ($getLoanStatusResponse/ns1:LOAN_ID) then (
                  <ns2:LoanId>{fn:data($getLoanStatusResponse/ns1:LOAN_ID)}</ns2:LoanId>
              ) 
              else ()
          }
          {
              if($transactionId != '' ) then (
                  <ns2:LoanStatus>CREDITED</ns2:LoanStatus>,
                  <ns2:TransactionReference>{fn:data($transactionId)}</ns2:TransactionReference>
              ) else (
                  <ns2:LoanStatus>{fn:data($getLoanStatusResponse/ns1:STATUS)}</ns2:LoanStatus>
              )
          }     
      </ns2:LoanDetails>
    </ns2:getLoanStatusResponse>
};

local:func($getLoanStatusResponse, $transactionId, $uuid)