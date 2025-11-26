(:: pragma bea:global-element-parameter parameter="$addLoanPlanResponse" element="ns1:AddLoanPlanResponse" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:global-element-return element="ns0:creaFinanciamientoResponse" location="../xsd/creaFinanciamientoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/creaFinanciamientoTypes";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaFinanciamiento/xq/creaFinanciamientoNIOut/";

declare function xf:creaFinanciamientoNIOut($addLoanPlanResponse as element(ns1:AddLoanPlanResponse),
    $activationStatus as xs:string,
    $activationDesc as xs:string)
    as element(ns0:creaFinanciamientoResponse) {
        <ns0:creaFinanciamientoResponse>
            <LOGO>{ data($addLoanPlanResponse/ARXLPO-LOGO) }</LOGO>
            <ACCOUNT_NUMBER>{ data($addLoanPlanResponse/ARXLPO-ACCT-NBR) }</ACCOUNT_NUMBER>
            <PLAN_NUMBER>{ data($addLoanPlanResponse/ARXLPO-PLAN-NBR) }</PLAN_NUMBER>
            <REFERENCE_NUMBER>{ data($addLoanPlanResponse/ARXLPO-REF-NBR) }</REFERENCE_NUMBER>
            <ACTIVATION_STATUS>{ $activationStatus }</ACTIVATION_STATUS>
            <ACTIVATION_DESC>{ $activationDesc }</ACTIVATION_DESC>
        </ns0:creaFinanciamientoResponse>
};

declare variable $addLoanPlanResponse as element(ns1:AddLoanPlanResponse) external;
declare variable $activationStatus as xs:string external;
declare variable $activationDesc as xs:string external;

xf:creaFinanciamientoNIOut($addLoanPlanResponse,
    $activationStatus,
    $activationDesc)