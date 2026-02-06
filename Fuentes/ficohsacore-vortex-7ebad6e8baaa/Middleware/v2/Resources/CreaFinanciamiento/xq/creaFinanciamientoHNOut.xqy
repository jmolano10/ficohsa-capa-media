xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$addLoanPlanL8V1Response" element="ns0:AddLoanPlanL8V1Response" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:global-element-return element="ns1:creaFinanciamientoResponse" location="../xsd/creaFinanciamientoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/creaFinanciamientoTypes";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaFinanciamiento/xq/creaFinanciamientoHNOut/";

declare function xf:creaFinanciamientoHNOut($addLoanPlanL8V1Response as element(ns0:AddLoanPlanL8V1Response))
    as element(ns1:creaFinanciamientoResponse) {
        <ns1:creaFinanciamientoResponse>
            <LOGO>{ data($addLoanPlanL8V1Response/ARXLPO-LOGO) }</LOGO>
            <ORG>{ data($addLoanPlanL8V1Response/ARXLPO-ORG) }</ORG>
            <ACCOUNT_NUMBER>{ data($addLoanPlanL8V1Response/ARXLPO-ACCT-NBR) }</ACCOUNT_NUMBER>
            <PLAN_NUMBER>{ data($addLoanPlanL8V1Response/ARXLPO-PLAN-NBR) }</PLAN_NUMBER>
            <REFERENCE_NUMBER>{ data($addLoanPlanL8V1Response/ARXLPO-REF-NBR) }</REFERENCE_NUMBER>
            <PLAN_SEQUENCE>{ data($addLoanPlanL8V1Response/ARXLPO-PLAN-SEQ) }</PLAN_SEQUENCE>
        </ns1:creaFinanciamientoResponse>
};

declare variable $addLoanPlanL8V1Response as element(ns0:AddLoanPlanL8V1Response) external;

xf:creaFinanciamientoHNOut($addLoanPlanL8V1Response)