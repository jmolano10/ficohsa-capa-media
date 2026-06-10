<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$cancelaFinanciamiento" element="ns1:cancelaFinanciamiento" location="../xsd/cancelaFinanciamientoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:PlanLevelSettlementQuoteRequest" location="../../../../v2/BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cancelaFinanciamientoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/CancelaFinanciamiento/xq/PlanLevelSettlementQuoteIn/";

declare function xf:PlanLevelSettlementQuoteIn($cancelaFinanciamiento as element(ns1:cancelaFinanciamiento))
    as element(ns0:PlanLevelSettlementQuoteRequest) {
        <ns0:PlanLevelSettlementQuoteRequest>
            <ARXPQI-ORG>{ data($cancelaFinanciamiento/ORG) }</ARXPQI-ORG>
            <ARXPQI-ACCT-CARD-NBR>{ data($cancelaFinanciamiento/ACCOUNT_NUMBER) }</ARXPQI-ACCT-CARD-NBR>
            <ARXPQI-PLAN-NBR>{ data($cancelaFinanciamiento/PLAN_NUMBER) }</ARXPQI-PLAN-NBR>
            <ARXPQI-REC-NBR>{ data($cancelaFinanciamiento/SECUENCE_NUMBER) }</ARXPQI-REC-NBR>
            <ARXPQI-REF-NBR>{ data($cancelaFinanciamiento/REFERENCE_NUMBER) }</ARXPQI-REF-NBR>
            <ARXPQI-PAYOFF-BY-DATE>{ data($cancelaFinanciamiento/CANCELLATION_DATE) }</ARXPQI-PAYOFF-BY-DATE>
            <ARXPQI-SD-PRJ-STTLMT-TYPE>P</ARXPQI-SD-PRJ-STTLMT-TYPE>
        </ns0:PlanLevelSettlementQuoteRequest>
};

declare variable $cancelaFinanciamiento as element(ns1:cancelaFinanciamiento) external;

xf:PlanLevelSettlementQuoteIn($cancelaFinanciamiento)]]></con:xquery>
    <con:dependency location="../xsd/cancelaFinanciamientoTypes.xsd">
        <con:schema ref="Middleware/v3/Resources/CancelaFinanciamiento/xsd/cancelaFinanciamientoTypes"/>
    </con:dependency>
    <con:dependency location="../../../../v2/BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616"/>
    </con:dependency>
</con:xqueryEntry>