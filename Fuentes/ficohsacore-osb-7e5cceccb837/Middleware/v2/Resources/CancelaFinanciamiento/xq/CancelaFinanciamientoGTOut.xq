(:: pragma bea:global-element-parameter parameter="$accountLevelSettlementQuoteResponse" element="ns0:AccountLevelSettlementQuoteResponse" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:global-element-return element="ns1:cancelaFinanciamientoResponse" location="../xsd/cancelaFinanciamientoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cancelaFinanciamientoTypes";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelaFinanciamiento/xq/CancelaFinanciamientoGTOut/";

declare function xf:CancelaFinanciamientoGTOut($accountLevelSettlementQuoteResponse as element(ns0:AccountLevelSettlementQuoteResponse))
    as element(ns1:cancelaFinanciamientoResponse) {
        <ns1:cancelaFinanciamientoResponse>
        	{
        		for $ARXAQO-CURR-CODE in $accountLevelSettlementQuoteResponse/ARXAQO-CURR-CODE
        		return
        			if(string($ARXAQO-CURR-CODE/text()) != '')then(
        				<CURRENCY_CODE>{ data($ARXAQO-CURR-CODE) }</CURRENCY_CODE>
        			)else()
        	}
            
            {
                for $ARXAQO-FOREIGN-USE in $accountLevelSettlementQuoteResponse/ARXAQO-FOREIGN-USE
                return
                    <FOREING_USE>{ data($ARXAQO-FOREIGN-USE) }</FOREING_USE>
            }
            {
            	for $ARXAQO-ORG in $accountLevelSettlementQuoteResponse/ARXAQO-ORG
            	return
            		if(string($ARXAQO-ORG/text()) != '')then(
            			<ORG>{ data($ARXAQO-ORG) }</ORG>
            		)else()
            }
            {
            	for $ARXAQO-FOREIGN-ORG in $accountLevelSettlementQuoteResponse/ARXAQO-FOREIGN-ORG
            	return
            	if(string($ARXAQO-FOREIGN-ORG/text()) != '')then(
            		<FOREING_ORG>{ data($ARXAQO-FOREIGN-ORG) }</FOREING_ORG>
            	)else()
            }
            {
            	for $ARXAQO-LOGO in $accountLevelSettlementQuoteResponse/ARXAQO-LOGO
            	return
            		if(string($ARXAQO-LOGO/text()) != '')then(
            			<LOGO>{ data($ARXAQO-LOGO) }</LOGO>
            		)else()
            }                                    
            {
                for $ARXAQO-ACCT-NBR in $accountLevelSettlementQuoteResponse/ARXAQO-ACCT-NBR
                return
                    <ACCOUNT_NUMBER>{ data($ARXAQO-ACCT-NBR) }</ACCOUNT_NUMBER>
            }
            {
                for $ARXAQO-CARD-NBR in $accountLevelSettlementQuoteResponse/ARXAQO-CARD-NBR
                return
                    <CARD_NUMBER>{ data($ARXAQO-CARD-NBR) }</CARD_NUMBER>
            }
            {
                for $ARXAQO-ACCT-LEVEL-QUOTE in $accountLevelSettlementQuoteResponse/ARXAQO-ACCT-LEVEL-QUOTE
                return
                    <ACCOUNT_LEVEL>{ data($ARXAQO-ACCT-LEVEL-QUOTE) }</ACCOUNT_LEVEL>
            }
            {
                for $ARXAQO-PAYOFF-BY-DATE in $accountLevelSettlementQuoteResponse/ARXAQO-PAYOFF-BY-DATE
                return
                	if(string($ARXAQO-PAYOFF-BY-DATE/text()) != '')then(
                		<START_DATE>{ data($ARXAQO-PAYOFF-BY-DATE) }</START_DATE>
                	)else()                    
            }
            {
                for $ARXAQO-ACCT-LEVEL-PAYOFF in $accountLevelSettlementQuoteResponse/ARXAQO-ACCT-LEVEL-PAYOFF
                return
                    <TOTAL_CANCELATION_AMOUNT>{ data($ARXAQO-ACCT-LEVEL-PAYOFF) }</TOTAL_CANCELATION_AMOUNT>
            }
        </ns1:cancelaFinanciamientoResponse>
};

declare variable $accountLevelSettlementQuoteResponse as element(ns0:AccountLevelSettlementQuoteResponse) external;

xf:CancelaFinanciamientoGTOut($accountLevelSettlementQuoteResponse)
