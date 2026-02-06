xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaMaestraSaldosTarjetaCredito" element="ns0:sjConsultaMaestraSaldosTarjetaCredito" location="../../ConsultaMaestraSaldosTarjetaCredito/xsd/sjConsultaMaestraSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma  parameter="$resultGroup" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:sjConsultaMaestraSaldosTarjetaCreditoResponse" location="../../ConsultaMaestraSaldosTarjetaCredito/xsd/sjConsultaMaestraSaldosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMaestraSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/BusinessServices/SJS/ConsultaMaestraSaldosTarjetaCreditoNI/xq/sjConsultaMaestraSaldosTarjetaCreditoNIOut/";
declare namespace ns3 = "http://www.procesa.com/fdcs";

declare function xf:sjConsultaMaestraSaldosTarjetaCreditoNIOut($sjConsultaMaestraSaldosTarjetaCredito as element(ns0:sjConsultaMaestraSaldosTarjetaCredito),
    $resultGroup as element(*))
    as element(ns0:sjConsultaMaestraSaldosTarjetaCreditoResponse) {
        <ns0:sjConsultaMaestraSaldosTarjetaCreditoResponse>
            {
                let $valFechaPagoMaximo := (
	        	for $item in $resultGroup/BALANCE_INQUIRY_RESPONSES/ns3:BalanceInquiryResponse/ARXBIO-DATE-PMT-DUE
	        	where not($item = ('','00000000'))
					return $item
				) return
					if(exists($valFechaPagoMaximo)) then (
						<MAX_PAYMENT_DATE>{fn-bea:date-to-string-with-format('dd/MM/yyyy',fn-bea:date-from-string-with-format('yyyyMMdd', $valFechaPagoMaximo[1]))}</MAX_PAYMENT_DATE>
					) else(),
					
	        	 for $valfechaCorte in string($resultGroup/ACCOUNT_INQUIRY_RESPONSES/ns3:AccountInquiryL8VLResponse[1]/AZXAIO-DATE-LAST-STMT/text())
				 return
				 	if($valfechaCorte != '')then(
				 		<CUTOFF_DATE>{fn-bea:date-to-string-with-format('dd/MM/yyyy',fn-bea:date-from-string-with-format('yyyy-MM-dd', $valfechaCorte))}</CUTOFF_DATE>	
				 	)else(),
				 	for $rowconSaldosCTS at $i in $sjConsultaMaestraSaldosTarjetaCredito/CARD_INFORMATION
		 			let $org := data($rowconSaldosCTS/ORG)
		 			let $accountInquiryL8VLResponse := $resultGroup/ACCOUNT_INQUIRY_RESPONSES/ns3:AccountInquiryL8VLResponse[ AZXAIO-ORG = $org ]
        	 		let $balanceInquiryVAResponse := $resultGroup/BALANCE_INQUIRY_RESPONSES/ns3:BalanceInquiryResponse[ ARXBIO-ORG = $org ]
        	 		let $cashOTBResponse := $resultGroup/CASH_OTB_INQUIRY_RESPONSES/ns3:OTBResponse[$i]
		 			return(
		 				<CREDIT_CARD_BALANCE_INFO>
			 				<ORG>{ $org }</ORG>
			 				{
			        	 		for $valCodigoBloqueo1 in string($accountInquiryL8VLResponse/AZXAIO-BLOCK-CODE-1/text())
			        	 		return
			        	 			<BLOCK_CODE_1>{ $valCodigoBloqueo1 }</BLOCK_CODE_1>
		        	 		}
		        	 		{
		        	 			for $valCodigoBloqueo2 in string($accountInquiryL8VLResponse/AZXAIO-BLOCK-CODE-2/text())
			        	 		return
			        	 			<BLOCK_CODE_2>{ $valCodigoBloqueo2 }</BLOCK_CODE_2>
			        	 	}
		        	 		{
			        	 		for $valLimiteCredito in string($balanceInquiryVAResponse/ARXBIO-CREDIT-LIMIT/text())
			        	 		return
			        	 			if($valLimiteCredito != '')then(
			        	 				<CREDIT_LIMIT>{ $valLimiteCredito }</CREDIT_LIMIT>
			        	 			)else()
		        	 		}
		        	 		{
			        	 		for $valSaldoActual in string($accountInquiryL8VLResponse/AZXAIO-CURR-BAL/text() - $accountInquiryL8VLResponse/AZXAIO-AMT-MEMO-CR/text() )
			        	 		return
			        	 			if($valSaldoActual != '')then(
			        	 				<CURRENT_BALANCE>{ fn-bea:decimal-round(xs:decimal($valSaldoActual), 2) }</CURRENT_BALANCE>
			        	 			)else()
			        	 	}
			        	 	{
			        	 		for $valDisponibleCompras in string($accountInquiryL8VLResponse/AZXAIO-AVAIL-CREDIT/text())
			        	 		return
			        	 			if($valDisponibleCompras != '')then(
			        	 				<PURCHASE_AVAILABLE_AMOUNT>{ $valDisponibleCompras }</PURCHASE_AVAILABLE_AMOUNT>
			        	 			)else()
			        	 	}
			        	 	{
			        	 		for $valRetiroDisponible in string($accountInquiryL8VLResponse/AZXAIO-AVAIL-CREDIT-WO-OVL/text())
			        	 		return
			        	 			if($valRetiroDisponible != '')then(
			        	 				<AVAILABLE_WITHDRAWAL>{ $valRetiroDisponible }</AVAILABLE_WITHDRAWAL>
			        	 			)else()
			        	 	}
			        	 	{
			        	 		for $valPagoMinimo in string($balanceInquiryVAResponse/ARXBIO-PMT-TOT-AMT-DUE/text())
			        	 		return
			        	 			if($valPagoMinimo != '')then(
			        	 				<MIN_PAYMENT>{ $valPagoMinimo }</MIN_PAYMENT>
			        	 			)else()
			        	 	}
			        	 	{
			        	 		for $valUltimaFechaPago in string($accountInquiryL8VLResponse/AZXAIO-DATE-LAST-PMT/text())
			        	 		return
			        	 			if($valUltimaFechaPago != '')then(
			        	 				<LAST_CUTOFF_DATE>{fn-bea:date-to-string-with-format('dd/MM/yyyy',fn-bea:date-from-string-with-format('yyyy-MM-dd', $valUltimaFechaPago))}</LAST_CUTOFF_DATE>
			        	 			)else()
			        	 	}
			        	 	{
		        	 			for $valUltimoMontoPago in $balanceInquiryVAResponse/ARXBIO-LAST-PMT-AMOUNT
			        	 		return
			        	 			if(string($valUltimoMontoPago/text()) != '')then(
			        	 				<LAST_CUTOFF_PAYMENT>{ data($valUltimoMontoPago) }</LAST_CUTOFF_PAYMENT>
			        	 			)else()
			        	 	}
			        	 	{
			        	 		for $valDiasPago in string($accountInquiryL8VLResponse/AZXAIO-PMT-CYCLE-DUE/text())
			        	 		return
			       	 			if($valDiasPago != '')then(
			        	 				<CICLE_DUE>{ $valDiasPago }</CICLE_DUE>
			        	 			)else()
			        	 	}
			 			</CREDIT_CARD_BALANCE_INFO>
		 			)
            }
        </ns0:sjConsultaMaestraSaldosTarjetaCreditoResponse>
};

declare variable $sjConsultaMaestraSaldosTarjetaCredito as element(ns0:sjConsultaMaestraSaldosTarjetaCredito) external;
declare variable $resultGroup as element(*) external;

xf:sjConsultaMaestraSaldosTarjetaCreditoNIOut($sjConsultaMaestraSaldosTarjetaCredito,
    $resultGroup)