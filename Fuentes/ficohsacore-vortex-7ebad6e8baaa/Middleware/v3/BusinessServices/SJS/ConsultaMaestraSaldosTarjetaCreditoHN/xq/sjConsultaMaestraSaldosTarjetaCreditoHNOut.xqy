xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaMaestraSaldosTarjetaCredito" element="ns0:sjConsultaMaestraSaldosTarjetaCredito" location="../../ConsultaMaestraSaldosTarjetaCredito/xsd/sjConsultaMaestraSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma  parameter="$resultGroup" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:sjConsultaMaestraSaldosTarjetaCreditoResponse" location="../../ConsultaMaestraSaldosTarjetaCredito/xsd/sjConsultaMaestraSaldosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMaestraSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/BusinessServices/SJS/ConsultaMaestraSaldosTarjetaCreditoHN/xq/sjConsultaMaestraSaldosTarjetaCreditoHNOut/";
declare namespace ns3 = "http://www.procesa.com/fdcs";
declare namespace ns4 = "http://www.procesa.com/fdcs/ot";
declare namespace ns5 = "http://schemas.datacontract.org/2004/07/Business.Entities";

declare function xf:sjConsultaMaestraSaldosTarjetaCreditoHNOut($sjConsultaMaestraSaldosTarjetaCredito as element(ns0:sjConsultaMaestraSaldosTarjetaCredito),
    $resultGroup as element(*))
    as element(ns0:sjConsultaMaestraSaldosTarjetaCreditoResponse) {
        <ns0:sjConsultaMaestraSaldosTarjetaCreditoResponse>
        {
            let $valFechaPagoMaximo := (
	        	for $item in $resultGroup/ACCOUNT_INQUIRY_RESPONSES/ns3:AccountInquiryL8VLResponse/AZXAIO-DATE-PMT-DUE
	        	where not($item = ('','00000000'))
					return $item
			) return
				if(exists($valFechaPagoMaximo)) then (
					<MAX_PAYMENT_DATE>{fn-bea:date-to-string-with-format('dd/MM/yyyy',fn-bea:date-from-string-with-format('yyyyMMdd', replace(string($valFechaPagoMaximo[1]), '-', '')))}</MAX_PAYMENT_DATE>
				) else(),
				
        	 for $valfechaCorte in string($resultGroup/ACCOUNT_INQUIRY_RESPONSES/ns3:AccountInquiryL8VLResponse[1]/AZXAIO-DATE-LAST-STMT/text())
			 return
			 	if($valfechaCorte != '')then(
			 		<CUTOFF_DATE>{fn-bea:date-to-string-with-format('dd/MM/yyyy',fn-bea:date-from-string-with-format('yyyy-MM-dd', $valfechaCorte))}</CUTOFF_DATE>	
			 	)else(),
			 	for $rowconSaldosCTS at $i in $sjConsultaMaestraSaldosTarjetaCredito/CARD_INFORMATION
			 	let $org := data($rowconSaldosCTS/ORG)
			 	let $currencyCode := data($rowconSaldosCTS/CURRENCY)
	        	let $accountInquiryL8VLResponse := $resultGroup/ACCOUNT_INQUIRY_RESPONSES/ns3:AccountInquiryL8VLResponse[ AZXAIO-ORG = $org ]
	        	(:let $balanceInquiryVAResponse := $resultGroup/BALANCE_INQUIRY_RESPONSES/ns3:BalanceInquiryResponse[ ARXBIO-ORG = $org ]:)
	        	(:let $OnlineInformationResponse := $resultGroup/ONLINE_INFORMATION_RESPONSES/ns4:OnlineInformationResponse[$i]:)
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
		        	 		for $valLimiteCredito in string($accountInquiryL8VLResponse/AZXAIO-CRLIM/text())
		        	 		return
		        	 			if($valLimiteCredito != '')then(
		        	 				<CREDIT_LIMIT>{ $valLimiteCredito }</CREDIT_LIMIT>
		        	 			)else()
		        	 	}
			 			{
		        	 		for $avaliableCredit in string($accountInquiryL8VLResponse/AZXAIO-AVAIL-CREDIT/text())
		        	 		return
		        	 			if($avaliableCredit != '')then(
		        	 				<PURCHASE_AVAILABLE_AMOUNT>{ $avaliableCredit }</PURCHASE_AVAILABLE_AMOUNT>
		        	 			)else(
		        	 				<PURCHASE_AVAILABLE_AMOUNT>0</PURCHASE_AVAILABLE_AMOUNT>
		        	 			)
		        	 	}
		        	 	{
		        	 		for $valRetiroDisponible in string($accountInquiryL8VLResponse/AZXAIO-CASH-AVAIL-CREDIT/text())
		        	 		return
		        	 			if($valRetiroDisponible != '')then(
		        	 				<AVAILABLE_WITHDRAWAL>{ $valRetiroDisponible }</AVAILABLE_WITHDRAWAL>
		        	 			)else()
		        	 	}
			 			{	
			 				for $valPagoMinimo in xs:string($accountInquiryL8VLResponse/AZXAIO-PMT-TOT-AMT-DUE/text())
		        	 		let $ARXBIO-PMT-TOT-AMT-DUE := xs:decimal($accountInquiryL8VLResponse/AZXAIO-PMT-TOT-AMT-DUE)
		        	 		let $AZXAIO-AMT-MEMO-CR := xs:decimal($accountInquiryL8VLResponse/AZXAIO-AMT-MEMO-CR)
		        	 		let $valPagoMinimoTotal := $ARXBIO-PMT-TOT-AMT-DUE - $AZXAIO-AMT-MEMO-CR
		        	 		return(
		        	 			<MIN_PAYMENT>
        	 					{ 
        	 						if($valPagoMinimoTotal > 0 )then(
        	 							$valPagoMinimoTotal
        	 						)else(0)
        	 					}
        	 					</MIN_PAYMENT>
		        	 		)
			 			}
			 			{
		        	 		for $valUltimaFechaPago in string($accountInquiryL8VLResponse/AZXAIO-DATE-LAST-PMT/text())
		        	 		return
		        	 			if($valUltimaFechaPago != '')then(
		        	 				<LAST_CUTOFF_DATE>{fn-bea:date-to-string-with-format('dd/MM/yyyy',fn-bea:date-from-string-with-format('yyyy-MM-dd', $valUltimaFechaPago))}</LAST_CUTOFF_DATE>
		        	 			)else()
		        	 	}
		        	 	{
		        	 		for $valUltimoMontoPago in $accountInquiryL8VLResponse/AZXAIO-PMT-LAST-AMT
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
		        	 	{
		        	 		let $AZXAIO-PMT-PAST-DUE:= xs:decimal($accountInquiryL8VLResponse/AZXAIO-PMT-PAST-DUE/text())
		        	 		let $AZXAIO-PMT-30DAYS:= xs:decimal($accountInquiryL8VLResponse/AZXAIO-PMT-30DAYS/text())
		        	 		let $AZXAIO-PMT-60DAYS:= xs:decimal($accountInquiryL8VLResponse/AZXAIO-PMT-60DAYS/text())
		        	 		let $AZXAIO-PMT-90DAYS:= xs:decimal($accountInquiryL8VLResponse/AZXAIO-PMT-90DAYS/text())
		        	 		let $AZXAIO-PMT-120DAYS:=xs:decimal($accountInquiryL8VLResponse/AZXAIO-PMT-120DAYS/text())
		        	 		let $AZXAIO-PMT-150DAYS:= xs:decimal($accountInquiryL8VLResponse/AZXAIO-PMT-150DAYS/text())
		        	 		let $AZXAIO-PMT-180DAYS:= xs:decimal($accountInquiryL8VLResponse/AZXAIO-PMT-180DAYS/text())
		        	 		let $AZXAIO-PMT-210DAYS:= xs:decimal($accountInquiryL8VLResponse/AZXAIO-PMT-210DAYS/text())
		        	 		
		        	 		let $valDeudaVigenteVencido:= ($AZXAIO-PMT-PAST-DUE + $AZXAIO-PMT-30DAYS + $AZXAIO-PMT-60DAYS + $AZXAIO-PMT-90DAYS + $AZXAIO-PMT-120DAYS + $AZXAIO-PMT-150DAYS + $AZXAIO-PMT-180DAYS + $AZXAIO-PMT-210DAYS)	 	
								return
		        	 				<TOTAL_OVERDUE_BALANCE>{$valDeudaVigenteVencido}</TOTAL_OVERDUE_BALANCE>
		        	 			
		        	 	}
			 		</CREDIT_CARD_BALANCE_INFO>
			 	),
		 		let $org := data($sjConsultaMaestraSaldosTarjetaCredito/CARD_INFORMATION[1]/ORG)
		 		let $accountInquiryL8VLResponse := $resultGroup/ACCOUNT_INQUIRY_RESPONSES/ns3:AccountInquiryL8VLResponse[ AZXAIO-ORG = $org ]
	        	(:let $balanceInquiryVAResponse := $resultGroup/BALANCE_INQUIRY_RESPONSES/ns3:BalanceInquiryResponse[ ARXBIO-ORG = $org ]:)
	        	let $AZXAIO-PMT-CTD := xs:decimal($accountInquiryL8VLResponse/AZXAIO-PMT-CTD)
	        	let $AZXAIO-AMT-MEMO-CR := xs:decimal($accountInquiryL8VLResponse/AZXAIO-AMT-MEMO-CR)
	        	(:let $valPagoContadoTotal := ($AZXAIO-PMT-CTD + $AZXAIO-AMT-MEMO-CR):)
	        	let $valPagoContadoTotal := $AZXAIO-PMT-CTD
		 		return(
		 			<TOTAL_PAYMENT>{ $valPagoContadoTotal }</TOTAL_PAYMENT>
		 		)
			 
		}
        </ns0:sjConsultaMaestraSaldosTarjetaCreditoResponse>
};

declare variable $sjConsultaMaestraSaldosTarjetaCredito as element(ns0:sjConsultaMaestraSaldosTarjetaCredito) external;
declare variable $resultGroup as element(*) external;

xf:sjConsultaMaestraSaldosTarjetaCreditoHNOut($sjConsultaMaestraSaldosTarjetaCredito,
    $resultGroup)