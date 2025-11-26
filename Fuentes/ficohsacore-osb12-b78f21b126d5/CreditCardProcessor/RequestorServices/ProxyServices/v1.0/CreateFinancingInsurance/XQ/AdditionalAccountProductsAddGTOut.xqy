xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/createFinancingInsuranceTypes";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/createFinancingInsuranceTypes.xsd" ::)
declare namespace ns1="http://www.procesa.com/fdcs";
(:: import schema at "../../../../../ProviderServices/XSD/visionPlus/XMLSchema_769155616.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $AdditionalAccountProductsAddResponse as element() (:: schema-element(ns1:AdditionalAccountProductsAddResponse) ::) external;

declare function local:func($uuid as xs:string, $AdditionalAccountProductsAddResponse as element() (:: schema-element(ns1:AdditionalAccountProductsAddResponse) ::)) as element() (:: schema-element(ns2:createFinancingInsuranceResponse) ::) {
    <ns2:createFinancingInsuranceResponse>
        <StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </StatusInfo>
        {
            if ($AdditionalAccountProductsAddResponse/ARXINO-DUAL-IND)
            then <CURRENCY_INDICATOR>{fn:data($AdditionalAccountProductsAddResponse/ARXINO-DUAL-IND)}</CURRENCY_INDICATOR>
            else ()
        }
        {
            if ($AdditionalAccountProductsAddResponse/ARXINO-ORG)
            then <ORG>{fn:data($AdditionalAccountProductsAddResponse/ARXINO-ORG)}</ORG>
            else ()
        }
        {
            if ($AdditionalAccountProductsAddResponse/ARXINO-ACCT-NBR)
            then <ACCOUNT_NUMBER>{fn:data($AdditionalAccountProductsAddResponse/ARXINO-ACCT-NBR)}</ACCOUNT_NUMBER>
            else ()
        }
        {
            if ($AdditionalAccountProductsAddResponse/ARXINO-LOGO)
            then <LOGO>{fn:data($AdditionalAccountProductsAddResponse/ARXINO-LOGO)}</LOGO>
            else ()
        }
        {
            if ($AdditionalAccountProductsAddResponse/ARXINO-INS-PROD-CODE)
            then <INSURANCE_CODE>{fn:data($AdditionalAccountProductsAddResponse/ARXINO-INS-PROD-CODE)}</INSURANCE_CODE>
            else ()
        }
        {
            if ($AdditionalAccountProductsAddResponse/ARXINO-INS-STATUS-CODE)
            then <INSURANCE_STATUS>{fn:data($AdditionalAccountProductsAddResponse/ARXINO-INS-STATUS-CODE)}</INSURANCE_STATUS>
            else ()
        }
    </ns2:createFinancingInsuranceResponse>
};

local:func($uuid, $AdditionalAccountProductsAddResponse)