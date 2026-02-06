xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$accountLevelSettlementQuoteResponse1" element="ns0:AccountLevelSettlementQuoteResponse" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:global-element-return element="ns1:cancelaFinanciamientoResponse" location="../xsd/cancelaFinanciamientoTypes.xsd" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cancelaFinanciamientoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelaFinanciamiento/xq/cancelaFinanciamientoNIOut/";

declare function xf:cancelaFinanciamientoNIOut($accountLevelSettlementQuoteResponse1 as element(ns0:AccountLevelSettlementQuoteResponse))
    as element(ns1:cancelaFinanciamientoResponse) {
        <ns1:cancelaFinanciamientoResponse>
            {
                for $ARXAQO-CURR-CODE in $accountLevelSettlementQuoteResponse1/ARXAQO-CURR-CODE
                return
                if(string($ARXAQO-CURR-CODE/text()) != '')then(
                    <CURRENCY_CODE>{ data($ARXAQO-CURR-CODE) }</CURRENCY_CODE>
                )else()
            }
            {
                for $ARXAQO-FOREIGN-USE in $accountLevelSettlementQuoteResponse1/ARXAQO-FOREIGN-USE
                return
                    <FOREING_USE>{ data($ARXAQO-FOREIGN-USE) }</FOREING_USE>
            }
            {
                for $ARXAQO-ORG in $accountLevelSettlementQuoteResponse1/ARXAQO-ORG
                return
                if(string($ARXAQO-ORG/text()) != '')then(
                    <ORG>{ data($ARXAQO-ORG) }</ORG>
                )else()
            }
            {
                for $ARXAQO-FOREIGN-ORG in $accountLevelSettlementQuoteResponse1/ARXAQO-FOREIGN-ORG
                return
                if(string($ARXAQO-FOREIGN-ORG/text()) != '')then(
                    <FOREING_ORG>{ data($ARXAQO-FOREIGN-ORG) }</FOREING_ORG>
                )else()
            }
            {
                for $ARXAQO-LOGO in $accountLevelSettlementQuoteResponse1/ARXAQO-LOGO
                return
                if(string($ARXAQO-LOGO/text()) != '')then(
                    <LOGO>{ data($ARXAQO-LOGO) }</LOGO>
                )else()
            }
            {
                for $ARXAQO-ACCT-NBR in $accountLevelSettlementQuoteResponse1/ARXAQO-ACCT-NBR
                return
                    <ACCOUNT_NUMBER>{ data($ARXAQO-ACCT-NBR) }</ACCOUNT_NUMBER>
            }
            {
                for $ARXAQO-CARD-NBR in $accountLevelSettlementQuoteResponse1/ARXAQO-CARD-NBR
                return
                    <CARD_NUMBER>{ data($ARXAQO-CARD-NBR) }</CARD_NUMBER>
            }
            {
                for $ARXAQO-ACCT-LEVEL-QUOTE in $accountLevelSettlementQuoteResponse1/ARXAQO-ACCT-LEVEL-QUOTE
                return
                    <ACCOUNT_LEVEL>{ data($ARXAQO-ACCT-LEVEL-QUOTE) }</ACCOUNT_LEVEL>
            }
            {
                for $ARXAQO-PAYOFF-BY-DATE in $accountLevelSettlementQuoteResponse1/ARXAQO-PAYOFF-BY-DATE
                return
                if(string($ARXAQO-PAYOFF-BY-DATE/text()) != '')then(
                    <START_DATE>{ data($ARXAQO-PAYOFF-BY-DATE) }</START_DATE>
                )else()
            }
            {
                for $ARXAQO-ACCT-LEVEL-PAYOFF in $accountLevelSettlementQuoteResponse1/ARXAQO-ACCT-LEVEL-PAYOFF
                return
                    <TOTAL_CANCELATION_AMOUNT>{ data($ARXAQO-ACCT-LEVEL-PAYOFF) }</TOTAL_CANCELATION_AMOUNT>
            }
        </ns1:cancelaFinanciamientoResponse>
};

declare variable $accountLevelSettlementQuoteResponse1 as element(ns0:AccountLevelSettlementQuoteResponse) external;

xf:cancelaFinanciamientoNIOut($accountLevelSettlementQuoteResponse1)