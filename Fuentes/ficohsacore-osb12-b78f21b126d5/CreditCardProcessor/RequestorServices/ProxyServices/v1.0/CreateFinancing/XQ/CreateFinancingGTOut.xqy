xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/createFinancingTypes";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/createFinancingTypes.xsd" ::)
declare namespace ns2="http://www.procesa.com/fdcs";
(:: import schema at "../../../../../ProviderServices/XSD/visionPlus/XMLSchema_769155616.xsd" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/createFinancingGTOut";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $addLoanPlanL8V1Response as element() (:: schema-element(ns2:AddLoanPlanL8V1Response) ::) external;

declare function ns1:createFinancingGTOut($uuid as xs:string, 
                                          $addLoanPlanL8V1Response as element() (:: schema-element(ns2:AddLoanPlanL8V1Response) ::)) 
                                          as element() (:: schema-element(ns3:createFinancingResponse) ::) {
    <ns3:createFinancingResponse>
        <StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </StatusInfo>
        <Logo>{fn:data($addLoanPlanL8V1Response/ARXLPO-LOGO)}</Logo>
        <Org>{fn:data($addLoanPlanL8V1Response/ARXLPO-ORG)}</Org>
        <AccountNumber>{fn:data($addLoanPlanL8V1Response/ARXLPO-ACCT-NBR)}</AccountNumber>
        <PlanNumber>{fn:data($addLoanPlanL8V1Response/ARXLPO-PLAN-NBR)}</PlanNumber>
        <ReferenceNumber>{fn:data($addLoanPlanL8V1Response/ARXLPO-REF-NBR)}</ReferenceNumber>
        <PlanSequence>{fn:data($addLoanPlanL8V1Response/ARXLPO-PLAN-SEQ)}</PlanSequence>
    </ns3:createFinancingResponse>
};

ns1:createFinancingGTOut($uuid, $addLoanPlanL8V1Response)