xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/getLoanDetailsHN_SJ";
(:: import schema at "../XSD/GetLoanDetailsHN_SJ.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midlleware.services/sjGetLoanDetailsHN";

declare variable $getLoanDetailsHN_SJRequest as element() (:: schema-element(ns2:getLoanDetailsHN_SJRequest) ::) external;
declare variable $counter as xs:int external;

declare function ns1:sjGetLoanDetailsHN($getLoanDetailsHN_SJRequest as element() (:: schema-element(ns2:getLoanDetailsHN_SJRequest) ::), 
                                        $counter as xs:int) 
                                        as element(*) {
    <get:getLoanDetails_params xmlns:get="http://xmlns.oracle.com/Dynamo/MWBanking/GetLoanDetails_PS">
        <get:loanId>{fn:data($getLoanDetailsHN_SJRequest/ns2:LOANS/ns2:LOAN_ID[$counter])}</get:loanId>
        <get:SourceBank>{fn:data($getLoanDetailsHN_SJRequest/ns2:SOURCE_BANK)}</get:SourceBank>
        <get:DestinationBank>{fn:data($getLoanDetailsHN_SJRequest/ns2:DESTINATION_BANK)}</get:DestinationBank>
        <get:ApplicationId>{fn:data($getLoanDetailsHN_SJRequest/ns2:APPLICATION_ID)}</get:ApplicationId>
        <get:Language>{fn:data($getLoanDetailsHN_SJRequest/ns2:LANGUAGE)}</get:Language>
    </get:getLoanDetails_params>
};

ns1:sjGetLoanDetailsHN($getLoanDetailsHN_SJRequest, $counter)