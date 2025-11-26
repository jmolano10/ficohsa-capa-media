xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/getAccountDetails";
(:: import schema at "../../../../../MWBanking/Accounts/RequestorServices/XSD/getAccountDetails.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetAccountDetails_BS";
(:: import schema at "../../../../ProviderServices/XSD/GetAccountDetails/GetAccountDetails_BS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";
declare namespace functx = "http://www.functx.com";

declare variable $uuid as xs:string external;
declare variable $abanksResponse as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare function functx:capitalize-first
  ( $arg as xs:string? )  as xs:string? {

   concat(upper-case(substring($arg,1,1)),
             substring($arg,2))
 } ;


declare function xq:Tx_Abanks_To_GetAccountDetailsResponse($abanksResponse as element() (:: schema-element(ns1:OutputParameters) ::),$uuid as xs:string) as element() (:: schema-element(ns2:getAccountDetailsResponse) ::) {
    <ns2:getAccountDetailsResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
        <ns2:AccountDetails>
            {
                if ($abanksResponse/ns1:ACCOUNT_NUMBER)
                then <ns2:AccountNumber>{fn:data($abanksResponse/ns1:ACCOUNT_NUMBER)}</ns2:AccountNumber>
                else ()
            }
            {
                if ($abanksResponse/ns1:CUSTOMER_ID)
                then <ns2:CustomerId>{fn:data($abanksResponse/ns1:CUSTOMER_ID)}</ns2:CustomerId>
                else ()
            }
            {
                if ($abanksResponse/ns1:ACCOUNT_NAME)
                then <ns2:AccountName>{fn:data($abanksResponse/ns1:ACCOUNT_NAME)}</ns2:AccountName>
                else ()
            }
            {
                if ($abanksResponse/ns1:CATEGORY='AHO')
                then <ns2:Category>Savings</ns2:Category>
                else
                if ($abanksResponse/ns1:CATEGORY='CHQ')
                then <ns2:Category>Currents</ns2:Category>
                else
                <ns2:Category>{fn:data($abanksResponse/ns1:CATEGORY)}</ns2:Category>                
            }
            {
                if ($abanksResponse/ns1:CURRENCY)
                then <ns2:Currency>{fn:data($abanksResponse/ns1:CURRENCY)}</ns2:Currency>
                else ()
            }
            {
                if ($abanksResponse/ns1:LIMIT_REF)
                then <ns2:LimitRef>{fn:data($abanksResponse/ns1:LIMIT_REF)}</ns2:LimitRef>
                else ()
            }
            {
                if ($abanksResponse/ns1:RESTRICTIONS)
                then <ns2:Restrictions>{fn:data($abanksResponse/ns1:RESTRICTIONS)}</ns2:Restrictions>
                else ()
            }
            {
                if ($abanksResponse/ns1:ALT_ACCOUNT)
                then <ns2:AltAccount>{fn:data($abanksResponse/ns1:ALT_ACCOUNT)}</ns2:AltAccount>
                else ()
            }
            {
                if ($abanksResponse/ns1:OPENING_DATE)
                then <ns2:OpeningDate>{
                fn:concat(fn:substring(fn:data($abanksResponse/ns1:OPENING_DATE),0,5),'-',fn:substring(fn:data($abanksResponse/ns1:OPENING_DATE),5,2),'-',fn:substring(fn:data($abanksResponse/ns1:OPENING_DATE),7,2))
                }</ns2:OpeningDate>
                else ()
            }
            {
                if ($abanksResponse/ns1:OPERATION_TYPE)
                then <ns2:OperationType>{functx:capitalize-first(fn:data(fn:lower-case($abanksResponse/ns1:OPERATION_TYPE)))}</ns2:OperationType>
                else ()
            }
            {
                if ($abanksResponse/ns1:ACCOUNT_OFFICER)
                then <ns2:AccountOfficer>{fn:data($abanksResponse/ns1:ACCOUNT_OFFICER)}</ns2:AccountOfficer>
                else ()
            }
            {
                if ($abanksResponse/ns1:BRANCH_CODE)
                then <ns2:BranchCode>{fn:data($abanksResponse/ns1:BRANCH_CODE)}</ns2:BranchCode>
                else ()
            }
            {
                if ($abanksResponse/ns1:LEGAL_ID)
                then <ns2:LegalId>{fn:data($abanksResponse/ns1:LEGAL_ID)}</ns2:LegalId>
                else ()
            }
            {
                if ($abanksResponse/ns1:REQUIRED_SIGNATURES)
                then <ns2:RequiredSignatures>{fn:data($abanksResponse/ns1:REQUIRED_SIGNATURES)}</ns2:RequiredSignatures>
                else ()
            }
            {
                if ($abanksResponse/ns1:SIGNATURE_DESC)
                then <ns2:SignaturesDesc>{fn:data($abanksResponse/ns1:SIGNATURE_DESC)}</ns2:SignaturesDesc>
                else ()
            }
            {
                if ($abanksResponse/ns1:INACTIVE_MARKER='1')
                then <ns2:InactiveMarker>Y</ns2:InactiveMarker>
                else
                if ($abanksResponse/ns1:INACTIVE_MARKER='0')
                then <ns2:InactiveMarker>N</ns2:InactiveMarker>
                else
                     <ns2:InactiveMarker></ns2:InactiveMarker>                
            }
        </ns2:AccountDetails>
    </ns2:getAccountDetailsResponse>
};

xq:Tx_Abanks_To_GetAccountDetailsResponse($abanksResponse,$uuid)
