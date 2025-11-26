(:: pragma bea:global-element-return element="ns0:PlanLevelSettlementQuoteRequest" location="../../../../../../Middleware/v2/BusinessServices/VisionPlusGT/fdcs/wsdl/Fdcs.wsdl" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/CreditCardOperations/CreditCardQuery/xq/planLevelSettlementQuoteGTIn/";

declare function xf:planLevelSettlementQuoteGTIn($ORG as xs:string,
    $ACCOUNT_NUMBER as xs:string,
    $PLAN_NUMBER as xs:string,
    $SECUENCE_NUMBER as xs:string,
    $REFERENCE_NUMBER as xs:string
    )
    as element(ns0:PlanLevelSettlementQuoteRequest) {
        <ns0:PlanLevelSettlementQuoteRequest>
        	<ARXPQI-ORG>{$ORG}</ARXPQI-ORG>
            <ARXPQI-ACCT-CARD-NBR>{$ACCOUNT_NUMBER}</ARXPQI-ACCT-CARD-NBR>
            <ARXPQI-PLAN-NBR>{$PLAN_NUMBER}</ARXPQI-PLAN-NBR>
            <ARXPQI-REC-NBR>{$SECUENCE_NUMBER}</ARXPQI-REC-NBR>
            <ARXPQI-REF-NBR>{fn:replace($REFERENCE_NUMBER,' ','')}</ARXPQI-REF-NBR>
            <ARXPQI-PAYOFF-BY-DATE>{fn-bea:date-to-string-with-format("yyyy-MM-dd", fn:current-date())}</ARXPQI-PAYOFF-BY-DATE>            
            <ARXPQI-SD-PRJ-STTLMT-TYPE>P</ARXPQI-SD-PRJ-STTLMT-TYPE>
        </ns0:PlanLevelSettlementQuoteRequest>
};

declare variable $ORG as xs:string external;
declare variable $ACCOUNT_NUMBER as xs:string external;
declare variable $PLAN_NUMBER as xs:string external;
declare variable $SECUENCE_NUMBER as xs:string external;
declare variable $REFERENCE_NUMBER as xs:string external;


xf:planLevelSettlementQuoteGTIn($ORG,
    $ACCOUNT_NUMBER,
    $PLAN_NUMBER,
    $SECUENCE_NUMBER,
    $REFERENCE_NUMBER
    )