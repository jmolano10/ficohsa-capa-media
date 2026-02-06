xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$settlementQuoteInquiryL8V2Response" element="ns0:SettlementQuoteInquiryL8V2Response" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalleFinanciamientoResponse" location="../xsd/consultaDetalleFinanciamientoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleFinanciamientoTypes";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleFinanciamiento/xq/consultaDetalleFinanciamientoPAOut/";

declare function xf:consultaDetalleFinanciamientoPAOut($settlementQuoteInquiryL8V2Response as element(ns0:SettlementQuoteInquiryL8V2Response))
    as element(ns1:consultaDetalleFinanciamientoResponse) {
        <ns1:consultaDetalleFinanciamientoResponse>          
            <ORG>{ data($settlementQuoteInquiryL8V2Response/ARXQIO-ORG) }</ORG>
            <ALTERN_ORG>{ data($settlementQuoteInquiryL8V2Response/ARXQIO-FOREIGN-ORG) }</ALTERN_ORG>
            <LOGO>{ data($settlementQuoteInquiryL8V2Response/ARXQIO-LOGO) }</LOGO>
            <ACCOUNT_NUMBER>{ data($settlementQuoteInquiryL8V2Response/ARXQIO-ACCT-NBR) }</ACCOUNT_NUMBER>
            <CARD_NUMBER>{ data($settlementQuoteInquiryL8V2Response/ARXQIO-CARD-NBR) }</CARD_NUMBER>
            <ACCOUNT_PAYOFF_DATE>{ data($settlementQuoteInquiryL8V2Response/ARXQIO-ACCT-PAYOFF-DATE) }</ACCOUNT_PAYOFF_DATE>
            <ACCOUNT_PAYOFF_AMOUNT>{ data($settlementQuoteInquiryL8V2Response/ARXQIO-ACCT-PAYOFF-AMT) }</ACCOUNT_PAYOFF_AMOUNT>
          	<PLAN-DATA>
                {
                    for $settlementQuoteInquiryL8V2 in $settlementQuoteInquiryL8V2Response/ARXQIO-PLAN-DATA/ARXQIO-PLAN-ENTRY
                    return(
                    <PLAN-ENTRY>
                    	{
                    		for $planReference in data($settlementQuoteInquiryL8V2/ARXQIO-PLAN-REF)
                    		return
                    			if($planReference != '')then(
                    				<PLAN_REFERENCE>{ $planReference }</PLAN_REFERENCE>
                    			)else()	
                    	}
                    	{
                    		for $planType in data($settlementQuoteInquiryL8V2/ARXQIO-PLAN-TYPE)
				     		return
				         		if( $planType != '')then(
				           			<PLAN_TYPE>{ $planType }</PLAN_TYPE>
				         		)else()
                    	}
                    	{
                    		for $planDescription in data($settlementQuoteInquiryL8V2/ARXQIO-PLAN-DESC)
				     		return
				         		if( $planDescription != '')then(
				           			<PLAN_DESCRIPTION>{ $planDescription }</PLAN_DESCRIPTION>
				         		)else()
                    	}
                    	{
                    		 for $quoteType in data($settlementQuoteInquiryL8V2/ARXQIO-QUOTE-TYPE)
						     return
						         if( $quoteType != '')then(
						           <QUOTE_TYPE>{ $quoteType }</QUOTE_TYPE>
						         )else()
                    	}
                    	{
                    		for $planPayoffDate in data($settlementQuoteInquiryL8V2/ARXQIO-PAYOFF-DATE1)
						    return
						        if( $planPayoffDate != '')then(
						          <PLAN_PAYOFF_DATE>{ $planPayoffDate }</PLAN_PAYOFF_DATE>
						        )else()
                    	}
                    	{
                    		for $planPayoffAmount in data($settlementQuoteInquiryL8V2/ARXQIO-PLAN-PAYOFF-AMT1)
						    return
						        if( $planPayoffAmount != '')then(
						          <PLAN_PAYOFF_AMOUNT>{ $planPayoffAmount }</PLAN_PAYOFF_AMOUNT>
						        )else()
                    	}
                    	{
                    		for $paymentType in data($settlementQuoteInquiryL8V2/ARXQIO-PARTIAL-SETL-TYPE)
						    return
						        if( $paymentType != '')then(
						          <PAYMENT_TYPE>{ $paymentType }</PAYMENT_TYPE>
						        )else()
                    	}
                    	{
                    		for $methodPayment in data($settlementQuoteInquiryL8V2/ARXQIO-PS-QUOTE-TYPE)
						    return
						        if( $methodPayment != '')then(
						          <METHOD_PAYMENT>{ $methodPayment }</METHOD_PAYMENT>
						        )else()
                    	}
                    	{
                    		for $newTerm in data($settlementQuoteInquiryL8V2/ARXQIO-PS-NEW-TERM)
						    return
						        if( $newTerm != '')then(
						          <NEW_TERM>{ $newTerm }</NEW_TERM>
						        )else()
                    	}
                    	{
                    		for $newPaymentAmount in data($settlementQuoteInquiryL8V2/ARXQIO-PS-NEW-FIXED-PMT-AMT)
						    return
						        if( $newPaymentAmount != '')then(
						          <NEW_PAYMENT_AMOUNT>{ $newPaymentAmount }</NEW_PAYMENT_AMOUNT>
						        )else()
                    	}
                    </PLAN-ENTRY>
                    )
                }
            </PLAN-DATA>
        </ns1:consultaDetalleFinanciamientoResponse>
};

declare variable $settlementQuoteInquiryL8V2Response as element(ns0:SettlementQuoteInquiryL8V2Response) external;

xf:consultaDetalleFinanciamientoPAOut($settlementQuoteInquiryL8V2Response)