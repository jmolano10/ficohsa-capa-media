<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$addLoanPlanL8V1Response1" element="ns0:AddLoanPlanL8V1Response" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:global-element-return element="ns1:creaFinanciamientoResponse" location="../xsd/creaFinanciamientoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/creaFinanciamientoTypes";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaFinanciamiento/xq/creaFinanciamientoPAGTOut/";

declare function xf:creaFinanciamientoPAGTOut($addLoanPlanL8V1Response1 as element(ns0:AddLoanPlanL8V1Response))
    as element(ns1:creaFinanciamientoResponse) {
        <ns1:creaFinanciamientoResponse>
            <LOGO>{ data($addLoanPlanL8V1Response1/ARXLPO-LOGO) }</LOGO>
            <ORG>{ data($addLoanPlanL8V1Response1/ARXLPO-ORG) }</ORG>
            <ACCOUNT_NUMBER>{ data($addLoanPlanL8V1Response1/ARXLPO-ACCT-NBR) }</ACCOUNT_NUMBER>
            <PLAN_NUMBER>{ data($addLoanPlanL8V1Response1/ARXLPO-PLAN-NBR) }</PLAN_NUMBER>
            <REFERENCE_NUMBER>{ data($addLoanPlanL8V1Response1/ARXLPO-REF-NBR) }</REFERENCE_NUMBER>
            <PLAN_SEQUENCE>{ data($addLoanPlanL8V1Response1/ARXLPO-PLAN-SEQ) }</PLAN_SEQUENCE>
        </ns1:creaFinanciamientoResponse>
};

declare variable $addLoanPlanL8V1Response1 as element(ns0:AddLoanPlanL8V1Response) external;

xf:creaFinanciamientoPAGTOut($addLoanPlanL8V1Response1)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616"/>
    </con:dependency>
    <con:dependency location="../xsd/creaFinanciamientoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/CreaFinanciamiento/xsd/creaFinanciamientoTypes"/>
    </con:dependency>
</con:xqueryEntry>