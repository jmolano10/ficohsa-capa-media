xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$confirmacionPrecalificacionCliente1" element="ns1:confirmacionPrecalificacionCliente" location="../../GestionesSolicitudCredito/xsd/gestionesSolicitudCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:precualifyResult" location="../../../BusinessServices/SALESFORCE/recepEvalCreditos/wsdl/WS_NIC_Recepcion_Eval_Creditos.wsdl" ::)

declare namespace ns0 = "http://soap.sforce.com/schemas/class/WS_NIC_Recepcion_Eval_Creditos";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionesSolicitudCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConfirmacionPrecalificacionCliente/xq/precualifyResultIn2/";

declare function xf:precualifyResultIn2($confirmacionPrecalificacionCliente1 as element(ns1:confirmacionPrecalificacionCliente))
    as element(ns0:precualifyResult) {
        <ns0:precualifyResult>
            <ns0:idProspecto>{ data($confirmacionPrecalificacionCliente1/REQUEST_ID) }</ns0:idProspecto>
            <ns0:requestStatus>{ data($confirmacionPrecalificacionCliente1/REQUEST_STATUS) }</ns0:requestStatus>
            <ns0:requestSubStatus>{ data($confirmacionPrecalificacionCliente1/REQUEST_SUB_STATUS) }</ns0:requestSubStatus>
            <ns0:dentificationType>{ data($confirmacionPrecalificacionCliente1/LEGAL_ID_TYPE) }</ns0:dentificationType>
            <ns0:identification>{ data($confirmacionPrecalificacionCliente1/LEGAL_ID) }</ns0:identification>
            <ns0:firstName>{ data($confirmacionPrecalificacionCliente1/FIRST_NAME) }</ns0:firstName>
            <ns0:secondName>{ data($confirmacionPrecalificacionCliente1/SECOND_NAME) }</ns0:secondName>
            <ns0:surname>{ data($confirmacionPrecalificacionCliente1/SURNAME) }</ns0:surname>
            <ns0:secondSurname>{ data($confirmacionPrecalificacionCliente1/SECOND_SURENAME) }</ns0:secondSurname>
            <ns0:income>{ data($confirmacionPrecalificacionCliente1/INCOME) }</ns0:income>
            <ns0:birthDate>{ data($confirmacionPrecalificacionCliente1/BIRTH_DATE) }</ns0:birthDate>
            <ns0:totalSiboifFees>{ data($confirmacionPrecalificacionCliente1/TOTAL_SIBOIF_FEES) }</ns0:totalSiboifFees>
            <ns0:totalTucaFees>{ data($confirmacionPrecalificacionCliente1/TOTAL_TUCA_FEES) }</ns0:totalTucaFees>
            <ns0:usedMue>{ data($confirmacionPrecalificacionCliente1/USED_MUE) }</ns0:usedMue>
            <ns0:netIncome>{ data($confirmacionPrecalificacionCliente1/NET_INCOME) }</ns0:netIncome>
            {
                for $LOAN_SCENARIOS_INFO in $confirmacionPrecalificacionCliente1/LOAN_SCENARIOS_INFO
                return
                    <ns0:generatedLoanScenarios>
                    	{
                    		for $AMOUNT in $LOAN_SCENARIOS_INFO/AMOUNT
                    		return
                    		if(string($AMOUNT/text()) != "")then(
                    			<ns0:Amount>{ data($AMOUNT) }</ns0:Amount>
                    		)else()
                    	}
                        <ns0:CampaignType>{ data($LOAN_SCENARIOS_INFO/CAMPAIGN_TYPE) }</ns0:CampaignType>
                        {
                        	for $FEE in $LOAN_SCENARIOS_INFO/FEE
                        	return
                        	if(string($FEE/text()) != "")then(
                        		<ns0:Cuota>{ data($FEE) }</ns0:Cuota>
                        	)else()
                        }
                        {
                        	for $RATE in $LOAN_SCENARIOS_INFO/RATE
                        	return
                        	if(string($RATE/text()) != "")then(
                        		<ns0:Rate>{ data($RATE) }</ns0:Rate>
                        	)else()
                        }
                        <ns0:SourceCode>{ data($LOAN_SCENARIOS_INFO/SOURCE_CODE) }</ns0:SourceCode>
                        {
                        	for $TERM in $LOAN_SCENARIOS_INFO/TERM
                        	return
                        	if(string($TERM/text()) != "")then(
                        		<ns0:Term>{ data($TERM) }</ns0:Term>
                        	)else()
                        }
                    </ns0:generatedLoanScenarios>
            }
            {
                for $CREDIT_CARD_SCENARIOS_INFO in $confirmacionPrecalificacionCliente1/CREDIT_CARD_SCENARIOS_INFO
                return
                    <ns0:generatedCreditCardScenarios>
                        <ns0:campaignType>{ data($CREDIT_CARD_SCENARIOS_INFO/CAMPAIGN_TYPE) }</ns0:campaignType>
                        {
                        	for $SUGGESTED_CREDIT_CARD_FEE in $CREDIT_CARD_SCENARIOS_INFO/SUGGESTED_CREDIT_CARD_FEE
                        	return
                        	if(string($SUGGESTED_CREDIT_CARD_FEE/text()) != "")then(
                        		<ns0:suggestedCreditCardFee>{ data($SUGGESTED_CREDIT_CARD_FEE) }</ns0:suggestedCreditCardFee>
                        	)else()
                        }
                        {
                        	for $SUGGESTED_LIMIT_CREDIT_CARD in $CREDIT_CARD_SCENARIOS_INFO/SUGGESTED_LIMIT_CREDIT_CARD
                        	return
                        	if(string($SUGGESTED_LIMIT_CREDIT_CARD/text()) != "") then(
                        		<ns0:suggestedLimitCreditCard>{ data($SUGGESTED_LIMIT_CREDIT_CARD) }</ns0:suggestedLimitCreditCard>
                        	)else()
                        }
                    </ns0:generatedCreditCardScenarios>
            }
        </ns0:precualifyResult>
};

declare variable $confirmacionPrecalificacionCliente1 as element(ns1:confirmacionPrecalificacionCliente) external;

xf:precualifyResultIn2($confirmacionPrecalificacionCliente1)