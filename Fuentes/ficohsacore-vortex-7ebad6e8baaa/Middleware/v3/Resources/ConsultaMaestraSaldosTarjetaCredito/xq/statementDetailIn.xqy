xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:StatementDetailRequest" location="../../../../v2/BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMaestraSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaMaestraSaldosTarjetaCredito/xq/statementDetailIn/";

declare function xf:statementDetailIn($accountNumber as xs:string,
    $org as xs:string,
    $type as xs:string,
    $dualIndicator as xs:string,
    $date as xs:string)
    as element(ns0:StatementDetailRequest) {
        <ns0:StatementDetailRequest>
            <ARXSDI-ACCT-ORG>{ data($org) }</ARXSDI-ACCT-ORG>
            <ARXSDI-ACCT-NBR>{ data($accountNumber) }</ARXSDI-ACCT-NBR>
            <ARXSDI-SVC-TYPE>{ data($type) }</ARXSDI-SVC-TYPE>
            <ARXSDI-DUAL-IND>{ data($dualIndicator) }</ARXSDI-DUAL-IND>
            <ARXSDI-STATEMENT-DATE>{ data($date)}</ARXSDI-STATEMENT-DATE>
        </ns0:StatementDetailRequest>
};

declare variable $accountNumber as xs:string external;
declare variable $org as xs:string external;
declare variable $type as xs:string external;
declare variable $dualIndicator as xs:string external;
declare variable $date as xs:string external;

xf:statementDetailIn($accountNumber,
    $org,
    $type,
    $dualIndicator,
    $date)