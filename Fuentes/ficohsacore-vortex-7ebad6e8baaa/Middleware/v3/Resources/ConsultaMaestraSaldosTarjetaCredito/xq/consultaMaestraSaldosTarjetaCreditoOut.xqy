xquery version "2004-draft" encoding "Cp1252";
(:: pragma  parameter="$resultGroup" type="xs:anyType" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../../v2/BusinessServices/MasterData/conSaldosCTS/xsd/consultaSaldosCTS_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaMaestraSaldosTarjetaCredito" location="../xsd/consultaMaestraSaldosTarjetaCreditoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaMaestraSaldosTarjetaCredito/xq/consultaMaestraSaldosTarjetaCreditoOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMaestraSaldosTarjetaCreditoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaSaldosCTS";
declare namespace ns3 = "http://www.procesa.com/fdcs";

declare function xf:consultaMaestraSaldosTarjetaCreditoOut($resultGroup as element(*),
    $outputParameters as element(ns1:OutputParameters),
    $valSaldoActualPuntos as  xs:string?)
    as element(ns0:consultaMaestraSaldosTarjetaCreditoResponse) {
    	<ns0:consultaMaestraSaldosTarjetaCreditoResponse>
		{
			for  $rows in $outputParameters/ns1:RowSet/ns1:Row[1]
			where $rows/ns1:Column[@name = 'TipoOrg'] = 'BASE'
				let $institutionId := string($rows/ns1:Column[@name = 'org']/text())
			return 	
        		<INSTITUTION_ID>{$institutionId}</INSTITUTION_ID>,
			<COUNTRY_CODE></COUNTRY_CODE>,
        	for $nombreTitular in string($outputParameters/ns1:RowSet/ns1:Row[1]/ns1:Column[@name = 'nombre_1']/text())
			return 	
        		<CARD_HOLDER_NAME>{$nombreTitular}</CARD_HOLDER_NAME>,
        	for $fechaNacimiento in $outputParameters/ns1:RowSet/ns1:Row[1]/ns1:Column[@name = 'fec_nac']
			return
				if(string($fechaNacimiento/text()) != '')then(
					<BIRTHDATE>{fn-bea:dateTime-to-string-with-format('dd/MM/yyyy',data($fechaNacimiento))}</BIRTHDATE>        		
        		)else(),
        	for $codTipoProducto in string($outputParameters/ns1:RowSet/ns1:Row[1]/ns1:Column[@name = 'numtarjeta']/text())
			return 	
        		<PRODUCT_TYPE_CODE>{$codTipoProducto}</PRODUCT_TYPE_CODE>,
        		<REGISTERED_SIGNATURES>0</REGISTERED_SIGNATURES>,
        	for $valPlan in string($outputParameters/ns1:RowSet/ns1:Row[1]/ns1:Column[@name = 'logo']/text())
			return 	
        		<LOGO>{$valPlan}</LOGO>,
        		<BLOCK_CODE></BLOCK_CODE>,
        		<ACTIVE_IDENTIFIER></ACTIVE_IDENTIFIER>,
        	for $valIndicador in string($outputParameters/ns1:RowSet/ns1:Row[1]/ns1:Column[@name = 'cardholder_type']/text())
			return 	
        		<CARD_HOLDER_TYPE>{$valIndicador}</CARD_HOLDER_TYPE>,
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
        	 for $rowconSaldosCTS at $i in $outputParameters/ns1:RowSet/ns1:Row
        	 let $org := data($rowconSaldosCTS/ns1:Column[upper-case(@name) = 'ORG'])
        	 let $AccountInquiryL8VLResponse := $resultGroup/ACCOUNT_INQUIRY_RESPONSES/ns3:AccountInquiryL8VLResponse[ AZXAIO-ORG = $org ]
        	 let $balanceInquiryVAResponse := $resultGroup/BALANCE_INQUIRY_RESPONSES/ns3:BalanceInquiryResponse[ ARXBIO-ORG = $org ]
        	 let $cashOTBResponse := $resultGroup/CASH_OTB_INQUIRY_RESPONSES/ns3:OTBResponse[$i]
        	 return(
        		<CREDIT_CARD_BALANCE_INFO>
        		{
        			for $org in string($rowconSaldosCTS/ns1:Column[@name = 'org']/text())
        			return
        				<ORG>{ $org }</ORG>
        	 	}
        	 	{
        	 		for $valSimboloMoneda in string($rowconSaldosCTS/ns1:Column[@name = 'moneda']/text())
        	 		return
        	 			<CURRENCY>{ $valSimboloMoneda }</CURRENCY>
        	 	}
        	 	{
        	 		for $valCodigoBloqueo1 in string($AccountInquiryL8VLResponse/AZXAIO-BLOCK-CODE-1/text())
        	 		return
        	 			<BLOCK_CODE_1>{ $valCodigoBloqueo1 }</BLOCK_CODE_1>
        	 	}
        	 	{
        	 		for $valCodigoBloqueo2 in string($AccountInquiryL8VLResponse/AZXAIO-BLOCK-CODE-2/text())
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
        	 		for $valSaldoActual in string($balanceInquiryVAResponse/ARXBIO-CURR-BAL/text())
        	 		return
        	 			if($valSaldoActual != '')then(
        	 				<CURRENT_BALANCE>{ $valSaldoActual }</CURRENT_BALANCE>
        	 			)else()
        	 	}
        	 	{
        	 		for $valDisponibleCompras in string($cashOTBResponse/OpenToBuy/text())
        	 		return
        	 			if($valDisponibleCompras != '')then(
        	 				<PURCHASE_AVAILABLE_AMOUNT>{ $valDisponibleCompras }</PURCHASE_AVAILABLE_AMOUNT>
        	 			)else()
        	 	}
        	 	{
        	 		for $valRetiroDisponible in string($AccountInquiryL8VLResponse/AZXAIO-CASH-AVAIL-CREDIT/text())
        	 		return
        	 			if($valRetiroDisponible != '')then(
        	 				<AVAILABLE_WITHDRAWAL>{ $valRetiroDisponible }</AVAILABLE_WITHDRAWAL>
        	 			)else()
        	 	}
        	 	{
        	 		for $valSaldoCorte in string($rowconSaldosCTS/ns1:Column[@name = 'totbalactual']/text())
        	 		return        	 			    
        	 			if($valSaldoCorte != '')then(
        	 				<CUTOFF_BALANCE>{ $valSaldoCorte }</CUTOFF_BALANCE>
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
        	 		for $valUltimaFechaPago in string($AccountInquiryL8VLResponse/AZXAIO-DATE-LAST-PMT/text())
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
        	 		for $valDiasPago in string($AccountInquiryL8VLResponse/AZXAIO-PMT-CYCLE-DUE/text())
        	 		return
        	 			if($valDiasPago != '')then(
        	 				<CICLE_DUE>{ $valDiasPago }</CICLE_DUE>
        	 			)else()
        	 	}
        	 	{
        	 		for $valTotalVencido in   string($rowconSaldosCTS/ns1:Column[@name = 'cantotaldue']/text())
        	 		return
        	 			if($valTotalVencido != '')then(
        	 				<OVERDUE_BALANCE>{ $valTotalVencido }</OVERDUE_BALANCE>
        	 			)else()	
        	 	}        	 		
        	 		<RETAINED_BALANCE>0</RETAINED_BALANCE>
        	 		<DISPUTED_BALANCE>0</DISPUTED_BALANCE>
        	 		<TOTAL_DEBIT>0</TOTAL_DEBIT>
        	 		<TOTAL_CREDIT>0</TOTAL_CREDIT>
        	 		<OVERDRAFT_LIMIT>0</OVERDRAFT_LIMIT>
        	 	{
        	 		let $AZXAIO-PMT-PAST-DUE:= xs:decimal($AccountInquiryL8VLResponse/AZXAIO-PMT-PAST-DUE/text())
        	 		let $AZXAIO-PMT-30DAYS:= xs:decimal($AccountInquiryL8VLResponse/AZXAIO-PMT-30DAYS/text())
        	 		let $AZXAIO-PMT-60DAYS:= xs:decimal($AccountInquiryL8VLResponse/AZXAIO-PMT-60DAYS/text())
        	 		let $AZXAIO-PMT-90DAYS:= xs:decimal($AccountInquiryL8VLResponse/AZXAIO-PMT-90DAYS/text())
        	 		let $AZXAIO-PMT-120DAYS:=xs:decimal($AccountInquiryL8VLResponse/AZXAIO-PMT-120DAYS/text())
        	 		let $AZXAIO-PMT-150DAYS:= xs:decimal($AccountInquiryL8VLResponse/AZXAIO-PMT-150DAYS/text())
        	 		let $AZXAIO-PMT-180DAYS:= xs:decimal($AccountInquiryL8VLResponse/AZXAIO-PMT-180DAYS/text())
        	 		let $AZXAIO-PMT-210DAYS:= xs:decimal($AccountInquiryL8VLResponse/AZXAIO-PMT-210DAYS/text())
        	 		
        	 		let $valDeudaVigenteVencido:= ($AZXAIO-PMT-PAST-DUE + $AZXAIO-PMT-30DAYS + $AZXAIO-PMT-60DAYS + $AZXAIO-PMT-90DAYS + $AZXAIO-PMT-120DAYS + $AZXAIO-PMT-150DAYS + $AZXAIO-PMT-180DAYS + $AZXAIO-PMT-210DAYS)	 	
						return
        	 				<TOTAL_OVERDUE_BALANCE>{$valDeudaVigenteVencido}</TOTAL_OVERDUE_BALANCE>
        	 			
        	 	}
	        	 	<EXTRA_FINANCING_INFO>
	        	   	{
	        	 		for $valDisponible in string($rowconSaldosCTS/ns1:Column[@name = 'monto_Extra']/text())
	        	 		return
	        	 			if($valDisponible != '')then(
        	 					<AVAILABLE_AMOUNT>{ $valDisponible }</AVAILABLE_AMOUNT>
        	 				)else()		
	        	 	}
	        	 	{
	        	 		for $valFechaVencimiento in $rowconSaldosCTS/ns1:Column[@name = 'fecha_vigencia']
	        	 		return
	        	 			if(string($valFechaVencimiento/text()) != '')then(
        	 					<EXPIRATION_DATE>{fn-bea:dateTime-to-string-with-format('dd/MM/yyyy',data($valFechaVencimiento))}</EXPIRATION_DATE>
        	 				)else()
	        	 	}
	        	 	{
	        	 		for $valEstado in string($rowconSaldosCTS/ns1:Column[@name = 'EstadoOfertaExtra']/text())
	        	 		return
        	 				<STATUS>{ $valEstado }</STATUS>
	        	 	}
	        	 			<CREDIT_CARD_PROGRAM>0</CREDIT_CARD_PROGRAM>
	        	 			<ID></ID>
	        	 			<LEVEL></LEVEL> 	 				
	        	 	</EXTRA_FINANCING_INFO>  		
        		</CREDIT_CARD_BALANCE_INFO>      	
        	),
        	<CREDIT_CARD_POINTS_INFO>
        	{
        		if($valSaldoActualPuntos != '')then(
        	 		<CURRENT_BALANCE>{$valSaldoActualPuntos}</CURRENT_BALANCE>
        	 	)else()	
        	}		
        	{
	        	 for $valSaldoAnterior in string($outputParameters/ns1:RowSet/ns1:Row[1]/ns1:Column[@name = 'ptosgan_aaf']/text())
	        	 return
	        	 	if($valSaldoAnterior != '')then(
	        	 		<PREVIOUS_BALANCE>{$valSaldoAnterior}</PREVIOUS_BALANCE>
	        	 	)else()
	        }
		        <EARNED_POINTS>0</EARNED_POINTS>
		        <USED_POINTS>0</USED_POINTS>
		        <OVERDUE_POINTS>0</OVERDUE_POINTS>
        	</CREDIT_CARD_POINTS_INFO>
    	}
        </ns0:consultaMaestraSaldosTarjetaCreditoResponse>
};
declare variable $resultGroup as element(*) external;
declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $valSaldoActualPuntos as xs:string? external;

xf:consultaMaestraSaldosTarjetaCreditoOut($resultGroup,
    $outputParameters, $valSaldoActualPuntos)