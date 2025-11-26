xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ProcesosPA/conTransaccionesSinPreQ/xsd/conTransaccionesSinPreQ_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaTransSinPreQualityResponse" location="../xsd/consultaTransSinPreQualityTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTransSinPreQuality/xq/consultaTransSinPreQualityPAOUT/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTransaccionesSinPreQ";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTransSinPreQualityTypes";

declare function xf:consultaTransSinPreQualityPAOUT($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaTransSinPreQualityResponse) {
       <ns1:consultaTransSinPreQualityResponse>
        {
       	for $detailOrg in $outputParameters/ns0:RowSet/ns0:Row[1]
       	return(
       		<DETAIL_ORG>
       		{
       			for $org in $detailOrg/ns0:Column[@name='org']
        		return
        			<ORG>{ data($org)}</ORG>
        	}
        	{
        		for $accountNumber in $detailOrg/ns0:Column[@name='numcuenta']
        		return
        			<ACCOUNT>{ data($accountNumber) }</ACCOUNT>
        	}
        	{
        		for $cardNumber in $detailOrg/ns0:Column[@name='numtarjeta']
        		return
        			<CARD_NUMBER>{ data($cardNumber) }</CARD_NUMBER>
        	}
        	{
        		for $beginingBalance in $detailOrg/ns0:Column[@name='totbalini']
        		return
        			<BEGINNING_BALANCE>{ data($beginingBalance) }</BEGINNING_BALANCE>
        	}
        	{
        		for $debitQuantity in $detailOrg/ns0:Column[@name='totnumdb']
	   			return
	   				<DEBIT_QUANTITY>{ data($debitQuantity) }</DEBIT_QUANTITY>
	   		}
	   		{
	   			for $debitAmount in $detailOrg/ns0:Column[@name='totcantdb']
	   			return
	   				<AMOUNT_DEBIT>{ data($debitAmount) }</AMOUNT_DEBIT>
	   		}
	   		{
	   			for $creditQuantity in $detailOrg/ns0:Column[@name='totnumcr']
	   			return
	   				<CREDIT_QUANTITY>{ data($creditQuantity) }</CREDIT_QUANTITY>
	   		}
	   		{
	   			for $amountCredit in $detailOrg/ns0:Column[@name='totcantcr']
	   			return
	   				<AMOUNT_CREDIT>{ data($amountCredit) }</AMOUNT_CREDIT>
	   		}
	   		{
	   			for $finalBalance in $detailOrg/ns0:Column[@name='totbalactual']
	   			return
	   				<FINAL_BALANCE>{ data($finalBalance) }</FINAL_BALANCE>
	   		}
	   		{
	   			for $maxPaymentDate in $detailOrg/ns0:Column[@name='fecpagodue']
	   			return
	   				if(string($maxPaymentDate/text())!='')then( 
	   					<MAX_PAYMENT_DATE>{fn-bea:dateTime-to-string-with-format("yyyyMMdd",fn:adjust-dateTime-to-timezone(data($maxPaymentDate),()))}</MAX_PAYMENT_DATE>
	   				)else()
	   		}
	   		{
	   			for $cutoffDate in $detailOrg/ns0:Column[@name='fechadecorte']
	   			return
	   			if(string($cutoffDate/text())!='')then( 
	   				<CUTOFF_DATE>{fn-bea:dateTime-to-string-with-format("yyyyMMdd",fn:adjust-dateTime-to-timezone(data($cutoffDate),()))}</CUTOFF_DATE>
	   			)else()
	   		}
	   		{
	   			for $minPayment in $detailOrg/ns0:Column[@name='actualdue']
	   			return
	   			<MIN_PAYMENT>{ data($minPayment) }</MIN_PAYMENT>
	   		}
	   		{
	   			for $delayCycle in $detailOrg/ns0:Column[@name='AMBS_PMT_CYCLE_DUE']
	   			return
	   			<DELAY_CYCLE>{ data($delayCycle) }</DELAY_CYCLE> 
	   		}
	   		{
	   			for $effectiveDateTrans in $detailOrg/ns0:Column[@name='fecefectiva']
	   			return
	   			if(string($effectiveDateTrans/text())!='')then( 
	   				<EFFECTIVE_DATE_TRANS>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd", fn:adjust-dateTime-to-timezone(data($effectiveDateTrans),())) }</EFFECTIVE_DATE_TRANS>
	   			)else()
	   		}
	   		{
				for $transactionDetail in $outputParameters/ns0:RowSet/ns0:Row
				return(
					<DETAIL_TRANSACTIONS>
					{
	    				for $postingDate in $transactionDetail/ns0:Column[@name='fecPosteo']
	    				return
	   						if(string($postingDate/text())!='')then( 
	   							<POSTING_DATE>{fn-bea:dateTime-to-string-with-format("yyyyMMdd",fn:adjust-dateTime-to-timezone(data($postingDate),()))}</POSTING_DATE>
	   						)else()
	   				}
	   				{
	    				for $transType in $transactionDetail/ns0:Column[@name='Tipo1']
	   					return
	   						<TRANS_TYPE>{ data($transType) }</TRANS_TYPE>
	   				}
	   				{
	    				for $transCode in $transactionDetail/ns0:Column[@name='codtxn']
	   					return
	   						<TRANS_CODE>{ data($transCode) }</TRANS_CODE>
	   				}
	   				{
	    				for $transAmount in $transactionDetail/ns0:Column[@name='monto']
	   					return
	   						<TRANS_AMOUNT>{ data($transAmount) }</TRANS_AMOUNT>
	   				}
	   				{
	    				for $descriptionTrans in $transactionDetail/ns0:Column[@name='descripcion']
	   					return
	   						<DESCRIPTION_TRANS>{ data($descriptionTrans) }</DESCRIPTION_TRANS>
	   				}
	   				{
	    				for $codeTransPlan in $transactionDetail/ns0:Column[@name='plann']
	   					return
	   						<CODE_TRANS_PLAN>{ data($codeTransPlan) }</CODE_TRANS_PLAN>				
					}					
	   				</DETAIL_TRANSACTIONS>
				)    
        	}
        	</DETAIL_ORG>
        	)
        }
        </ns1:consultaTransSinPreQualityResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaTransSinPreQualityPAOUT($outputParameters)