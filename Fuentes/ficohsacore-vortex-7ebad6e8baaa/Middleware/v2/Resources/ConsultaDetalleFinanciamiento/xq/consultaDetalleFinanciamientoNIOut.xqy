xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$settlementQuoteInquiryL8V2Response1" element="ns0:SettlementQuoteInquiryL8V2Response" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalleFinanciamientoResponse" location="../xsd/consultaDetalleFinanciamientoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleFinanciamiento/xq/consultaDetalleFinanciamientoNIOut/";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleFinanciamientoTypes";

declare function xf:consultaDetalleFinanciamientoNIOut($settlementQuoteInquiryL8V2Response1 as element(ns0:SettlementQuoteInquiryL8V2Response))
    as element(ns1:consultaDetalleFinanciamientoResponse) {
        <ns1:consultaDetalleFinanciamientoResponse>
            <ORG>{ data($settlementQuoteInquiryL8V2Response1/ARXQIO-ORG) }</ORG>
            <ALTERN_ORG>{ data($settlementQuoteInquiryL8V2Response1/ARXQIO-FOREIGN-ORG) }</ALTERN_ORG>
            <LOGO>{ data($settlementQuoteInquiryL8V2Response1/ARXQIO-LOGO) }</LOGO>
            <ACCOUNT_NUMBER>{ data($settlementQuoteInquiryL8V2Response1/ARXQIO-ACCT-NBR) }</ACCOUNT_NUMBER>
            <CARD_NUMBER>{ data($settlementQuoteInquiryL8V2Response1/ARXQIO-CARD-NBR) }</CARD_NUMBER>
            <ACCOUNT_PAYOFF_DATE>{ data($settlementQuoteInquiryL8V2Response1/ARXQIO-ACCT-PAYOFF-DATE) }</ACCOUNT_PAYOFF_DATE>
            <ACCOUNT_PAYOFF_AMOUNT>{ data($settlementQuoteInquiryL8V2Response1/ARXQIO-ACCT-PAYOFF-AMT) }</ACCOUNT_PAYOFF_AMOUNT>
            <PLAN-DATA>
            {
            	for $settlementQuoteInquiryL8V2 in $settlementQuoteInquiryL8V2Response1/ARXQIO-PLAN-DATA/ARXQIO-PLAN-ENTRY
    			return( 
                <PLAN-ENTRY>
                 {
				     for $planReference in data($settlementQuoteInquiryL8V2/ARXQIO-PLAN-REF)
				     return
				         if( $planReference != '')then(
				           <PLAN_REFERENCE>{ fn-bea:trim($planReference) }</PLAN_REFERENCE>
				         )else(<PLAN_REFERENCE/>)
				 }
				 {
				     for $planType in data($settlementQuoteInquiryL8V2/ARXQIO-PLAN-TYPE)
				     return
				         if( $planType != '')then(
				           <PLAN_TYPE>{ fn-bea:trim($planType) }</PLAN_TYPE>
				         )else(<PLAN_TYPE/>)
				 }
                 {
				     for $planDescription in data($settlementQuoteInquiryL8V2/ARXQIO-PLAN-DESC)
				     return
				         if( $planDescription != '')then(
				           <PLAN_DESCRIPTION>{ fn-bea:trim($planDescription) }</PLAN_DESCRIPTION>
				         )else(<PLAN_DESCRIPTION/>)
				 }  
                 {
				     for $quoteType in data($settlementQuoteInquiryL8V2/ARXQIO-QUOTE-TYPE)
				     return
				         if( $quoteType != '')then(
				           <QUOTE_TYPE>{ $quoteType }</QUOTE_TYPE>
				         )else(<QUOTE_TYPE/>)
				 }   
                 {
				     for $planPayoffDate in data($settlementQuoteInquiryL8V2/ARXQIO-PAYOFF-DATE1)
				     return
				         if( $planPayoffDate != '')then(
				           <PLAN_PAYOFF_DATE>{ $planPayoffDate }</PLAN_PAYOFF_DATE>
				         )else(<PLAN_PAYOFF_DATE/>)
				 }  
                 {
				     for $planPayoffAmount in data($settlementQuoteInquiryL8V2/ARXQIO-PLAN-PAYOFF-AMT1)
				     return
				         if( $planPayoffAmount != '')then(
				           <PLAN_PAYOFF_AMOUNT>{ $planPayoffAmount }</PLAN_PAYOFF_AMOUNT>
				         )else(<PLAN_PAYOFF_AMOUNT/>)
				 }
                 {
				     for $paymentType in data($settlementQuoteInquiryL8V2/ARXQIO-PARTIAL-SETL-TYPE)
				     return
				         if( $paymentType != '')then(
				           <PAYMENT_TYPE>{ $paymentType }</PAYMENT_TYPE>
				         )else(<PAYMENT_TYPE/>)
				 } 
                 {
				     for $methodPayment in data($settlementQuoteInquiryL8V2/ARXQIO-PS-QUOTE-TYPE)
				     return
				         if( $methodPayment != '')then(
				           <METHOD_PAYMENT>{ $methodPayment }</METHOD_PAYMENT>
				         )else(<METHOD_PAYMENT/>)
				 } 
                 {
				     for $newTerm in data($settlementQuoteInquiryL8V2/ARXQIO-PS-NEW-TERM)
				     return
				         if( $newTerm != '')then(
				           <NEW_TERM>{ $newTerm }</NEW_TERM>
				         )else(<NEW_TERM/>)
				 } 
                 {
				     for $newPaymentAmount in data($settlementQuoteInquiryL8V2/ARXQIO-PS-NEW-FIXED-PMT-AMT)
				     return
				         if( $newPaymentAmount != '')then(
				           <NEW_PAYMENT_AMOUNT>{ $newPaymentAmount }</NEW_PAYMENT_AMOUNT>
				         )else(<NEW_PAYMENT_AMOUNT/>)
				 } 				 				 				  
                </PLAN-ENTRY>
                )
                }
            </PLAN-DATA>
        </ns1:consultaDetalleFinanciamientoResponse>
};

declare variable $settlementQuoteInquiryL8V2Response1 as element(ns0:SettlementQuoteInquiryL8V2Response) external;

xf:consultaDetalleFinanciamientoNIOut($settlementQuoteInquiryL8V2Response1)