xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../../v2/BusinessServices/MasterDataHN/conMaestroSaldos/xsd/ConsultaMaestroSaldosTarjetaCredito_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$sjConsultaMaestraSaldosTarjetaCreditoResponse" element="ns6:sjConsultaMaestraSaldosTarjetaCreditoResponse" location="../../../BusinessServices/SJS/ConsultaMaestraSaldosTarjetaCredito/xsd/sjConsultaMaestraSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns2:OutputParameters" location="../../../BusinessServices/CLIENTDATA/consultaMaestraSaldosTC/xsd/consultaMaestraSaldosTC_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaSaldoSPMD" element="ns7:OutputParameters" location="../../../BusinessServices/MasterData/conConsultaSaldoTCRG/xsd/conConsultaSaldosCuentaTC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaMaestraSaldosTarjetaCreditoResponse" location="../xsd/consultaMaestraSaldosTarjetaCreditoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaMaestraSaldosTarjetaCredito/xq/consultaMaestraSaldosTarjetaCreditoHNOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMaestraSaldosTarjetaCreditoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaMaestroSaldosTarjetaCredito";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMaestraSaldosTC";
declare namespace ns5 = "http://schemas.datacontract.org/2004/07/Business.Entities";
declare namespace ns6 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMaestraSaldosTarjetaCreditoTypes";
declare namespace ns7 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conConsultaSaldosCuentaTC";

declare function xf:consultaMaestraSaldosTarjetaCreditoHNOut($sjConsultaMaestraSaldosTarjetaCreditoResponse as element(ns6:sjConsultaMaestraSaldosTarjetaCreditoResponse)?,
$outputParameters as element(ns1:OutputParameters)?,
$valSaldoActualPuntos as  xs:string?,
$outputParameters1 as element(ns2:OutputParameters)?,
$consultaSaldoSPMD as element(ns7:OutputParameters)?)
    as element(ns0:consultaMaestraSaldosTarjetaCreditoResponse) {
        <ns0:consultaMaestraSaldosTarjetaCreditoResponse>
           {(: Cache :)
   			if(not(empty( $outputParameters1/ns2:PT_MAESTRA_SALDOS_TC/ns2:PT_MAESTRA_SALDOS_TC_ITEM)))then(
   				let $PT_MAESTRA_SALDOS_TC_ITEM := $outputParameters1/ns2:PT_MAESTRA_SALDOS_TC/ns2:PT_MAESTRA_SALDOS_TC_ITEM[1]
        		return(
   				 	<INSTITUTION_ID>{ data($PT_MAESTRA_SALDOS_TC_ITEM/ns2:INSTITUTION_ID) }</INSTITUTION_ID>,
   					<COUNTRY_CODE>{ data($PT_MAESTRA_SALDOS_TC_ITEM/ns2:COUNTRY_CODE) }</COUNTRY_CODE>,
                    <CARD_HOLDER_NAME>{ data($PT_MAESTRA_SALDOS_TC_ITEM/ns2:CARD_HOLDER_NAME) }</CARD_HOLDER_NAME>,
                    <BIRTHDATE>{ data($PT_MAESTRA_SALDOS_TC_ITEM/ns2:BIRTHDATE) }</BIRTHDATE>,
                    <PRODUCT_TYPE_CODE>{ data($PT_MAESTRA_SALDOS_TC_ITEM/ns2:PRODUCT_TYPE_CODE) }</PRODUCT_TYPE_CODE>,
                    <REGISTERED_SIGNATURES>{ data($PT_MAESTRA_SALDOS_TC_ITEM/ns2:REGISTERED_SIGNATURES) }</REGISTERED_SIGNATURES>,
                    <LOGO>{ data($PT_MAESTRA_SALDOS_TC_ITEM/ns2:LOGO) }</LOGO>,
                    <BLOCK_CODE>{ data($PT_MAESTRA_SALDOS_TC_ITEM/ns2:BLOCK_CODE) }</BLOCK_CODE>,
                    <ACTIVE_IDENTIFIER>{ data($PT_MAESTRA_SALDOS_TC_ITEM/ns2:ACTIVE_IDENTIFIER) }</ACTIVE_IDENTIFIER>,
                    <CARD_HOLDER_TYPE>{ data($PT_MAESTRA_SALDOS_TC_ITEM/ns2:CARD_HOLDER_TYPE) }</CARD_HOLDER_TYPE>,
                    <MAX_PAYMENT_DATE>{ data($PT_MAESTRA_SALDOS_TC_ITEM/ns2:MAX_PAYMENT_DATE) }</MAX_PAYMENT_DATE>,
                    <CUTOFF_DATE>{ data($PT_MAESTRA_SALDOS_TC_ITEM/ns2:CUTOFF_DATE) }</CUTOFF_DATE>,
                    
                    let $CREDIT_CARD_BALANCE_INFO := fn-bea:inlinedXML($PT_MAESTRA_SALDOS_TC_ITEM/ns2:CREDIT_CARD_BALANCE_INFO)
                    for $CREDIT_CARD_BALANCE in $CREDIT_CARD_BALANCE_INFO
                    
                    return(
                    	<CREDIT_CARD_BALANCE_INFO>
                    		<ORG>{ string($CREDIT_CARD_BALANCE/ORG/text()) }</ORG>
                    		<CURRENCY>{ string($CREDIT_CARD_BALANCE/CURRENCY/text())  }</CURRENCY>
                    		<BLOCK_CODE_1>{ string($CREDIT_CARD_BALANCE/BLOCK_CODE_1/text())  }</BLOCK_CODE_1>
                    		<BLOCK_CODE_2>{ string($CREDIT_CARD_BALANCE/BLOCK_CODE_2/text()) }</BLOCK_CODE_2>
                    		<CREDIT_LIMIT>{ string($CREDIT_CARD_BALANCE/CREDIT_LIMIT/text()) }</CREDIT_LIMIT>
                    		<CURRENT_BALANCE>{ string($CREDIT_CARD_BALANCE/CURRENT_BALANCE/text()) }</CURRENT_BALANCE>
                    		<PURCHASE_AVAILABLE_AMOUNT>{ string($CREDIT_CARD_BALANCE/PURCHASE_AVAILABLE_AMOUNT/text()) }</PURCHASE_AVAILABLE_AMOUNT>
                    		<AVAILABLE_WITHDRAWAL>{ string($CREDIT_CARD_BALANCE/AVAILABLE_WITHDRAWAL/text()) }</AVAILABLE_WITHDRAWAL>
                    		<CUTOFF_BALANCE>{ string($CREDIT_CARD_BALANCE/CUTOFF_BALANCE/text()) }</CUTOFF_BALANCE>
                    		<MIN_PAYMENT>{ string($CREDIT_CARD_BALANCE/MIN_PAYMENT/text()) }</MIN_PAYMENT>
                    		<LAST_CUTOFF_DATE>{ string($CREDIT_CARD_BALANCE/LAST_CUTOFF_DATE/text()) }</LAST_CUTOFF_DATE>
                    		<LAST_CUTOFF_PAYMENT>{ string($CREDIT_CARD_BALANCE/LAST_CUTOFF_PAYMENT/text()) }</LAST_CUTOFF_PAYMENT>
                    		<CICLE_DUE>{ string($CREDIT_CARD_BALANCE/CICLE_DUE/text()) }</CICLE_DUE>
                    		<OVERDUE_BALANCE>{ string($CREDIT_CARD_BALANCE/OVERDUE_BALANCE/text()) }</OVERDUE_BALANCE>
                    		<RETAINED_BALANCE>0</RETAINED_BALANCE>
    	 					<DISPUTED_BALANCE>0</DISPUTED_BALANCE>
    	 					<TOTAL_DEBIT>0</TOTAL_DEBIT>
    	 					<TOTAL_CREDIT>0</TOTAL_CREDIT>
    	 					<OVERDRAFT_LIMIT>0</OVERDRAFT_LIMIT>
    	 					<TOTAL_OVERDUE_BALANCE>{ string($CREDIT_CARD_BALANCE/TOTAL_OVERDUE_BALANCE/text()) }</TOTAL_OVERDUE_BALANCE>
                    		<EXTRA_FINANCING_INFO>
                    			<AVAILABLE_AMOUNT>{ string($CREDIT_CARD_BALANCE/EXTRA_FINANCING_INFO/AVAILABLE_AMOUNT/text()) }</AVAILABLE_AMOUNT>
                    			<EXPIRATION_DATE>{ string($CREDIT_CARD_BALANCE/EXTRA_FINANCING_INFO/EXPIRATION_DATE/text()) }</EXPIRATION_DATE>
								<STATUS>{ string($CREDIT_CARD_BALANCE/EXTRA_FINANCING_INFO/STATUS/text()) }</STATUS>
								<OFFER_TYPE>{ string($CREDIT_CARD_BALANCE/EXTRA_FINANCING_INFO/OFFER_TYPE/text()) }</OFFER_TYPE>
                    		</EXTRA_FINANCING_INFO>
                    	</CREDIT_CARD_BALANCE_INFO>
                    ),
                    let $CREDIT_CARD_POINTS_INFO := fn-bea:inlinedXML($PT_MAESTRA_SALDOS_TC_ITEM/ns2:CREDIT_CARD_POINTS_INFO)
                    return(
                    	<CREDIT_CARD_POINTS_INFO>
                    		<CURRENT_BALANCE>{ string($CREDIT_CARD_POINTS_INFO/CURRENT_BALANCE/text()) }</CURRENT_BALANCE>
                    		<PREVIOUS_BALANCE>{ string($CREDIT_CARD_POINTS_INFO/PREVIOUS_BALANCE/text()) }</PREVIOUS_BALANCE>
                    		<EARNED_POINTS>0</EARNED_POINTS>
					        <USED_POINTS>0</USED_POINTS>
					        <OVERDUE_POINTS>0</OVERDUE_POINTS>
                    	</CREDIT_CARD_POINTS_INFO>
                    ),
                    <TOTAL_PAYMENT>{ data($PT_MAESTRA_SALDOS_TC_ITEM/ns2:TOTAL_PAYMENT) }</TOTAL_PAYMENT>
   				)
   			(: VisionPlus :)
   			)else(
				for  $rows in $outputParameters/ns1:RowSet/ns1:Row[1]
				where $rows/ns1:Column[@name = 'TipoOrg'] = 'BASE'
					let $institutionId := string($rows/ns1:Column[@name = 'org']/text())
				return 	
	        		<INSTITUTION_ID>{$institutionId}</INSTITUTION_ID>,
				for $pais in string($outputParameters/ns1:RowSet/ns1:Row[1]/ns1:Column[@name = 'pais']/text())
				return 
					<COUNTRY_CODE>{$pais}</COUNTRY_CODE>,
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
	        	let $valFechaPagoMaximo := string($sjConsultaMaestraSaldosTarjetaCreditoResponse/MAX_PAYMENT_DATE/text())
				return
					if($valFechaPagoMaximo != '')then(
						<MAX_PAYMENT_DATE>{$valFechaPagoMaximo}</MAX_PAYMENT_DATE>
					) else(),		
	        	 let $valfechaCorte := string($sjConsultaMaestraSaldosTarjetaCreditoResponse/CUTOFF_DATE/text())
				 return
				 	if($valfechaCorte != '')then(
				 		<CUTOFF_DATE>{ $valfechaCorte }</CUTOFF_DATE>	
				 	)else(),
				 	
	        	 for $rowconSaldosCTS at $i in $outputParameters/ns1:RowSet/ns1:Row
	        	 let $org := data($rowconSaldosCTS/ns1:Column[upper-case(@name) = 'ORG'])
	        	 let $currencyCode := data($rowconSaldosCTS/ns1:Column[upper-case(@name) = 'MONEDA'])
	        	 let $rowConsultaSaldoSPMD := $consultaSaldoSPMD/ns7:RowSet/ns7:Row[ns7:Column[@name = 'Org']/text() = $org]
	        	 let $sjConsultaMaestraSaldosTarjetaCredito :=  $sjConsultaMaestraSaldosTarjetaCreditoResponse/CREDIT_CARD_BALANCE_INFO[ORG = $org]
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
	        	 		for $valCodigoBloqueo1 in string($sjConsultaMaestraSaldosTarjetaCredito/BLOCK_CODE_1/text())
	        	 		return
	        	 			<BLOCK_CODE_1>{ $valCodigoBloqueo1 }</BLOCK_CODE_1>
	        	 	}
	        	 	<BLOCK_CODE_2>{ data($sjConsultaMaestraSaldosTarjetaCredito/BLOCK_CODE_2) }</BLOCK_CODE_2>
	        	 	<CREDIT_LIMIT>{ data($sjConsultaMaestraSaldosTarjetaCredito/CREDIT_LIMIT) }</CREDIT_LIMIT>
	        	 		
	        	 	{
	        	 		let $valSaldoActual:= $rowconSaldosCTS/ns1:Column[@name = 'billed_bal']/text() - $rowConsultaSaldoSPMD/ns7:Column[@name = 'PagosDia']/text()
	        	 		return
	        	 			if(string($valSaldoActual) != '')then(
	        	 				<CURRENT_BALANCE>{ fn-bea:decimal-round(xs:decimal($valSaldoActual), 2) }</CURRENT_BALANCE>
	        	 			)else(
	        	 				<CURRENT_BALANCE>{ string($rowconSaldosCTS/ns1:Column[@name = 'billed_bal']/text()) }</CURRENT_BALANCE>
	        	 			)
	        	 	}
	        	 	<PURCHASE_AVAILABLE_AMOUNT>{ data($sjConsultaMaestraSaldosTarjetaCredito/PURCHASE_AVAILABLE_AMOUNT) }</PURCHASE_AVAILABLE_AMOUNT>
			        <AVAILABLE_WITHDRAWAL>{ data($sjConsultaMaestraSaldosTarjetaCredito/AVAILABLE_WITHDRAWAL) }</AVAILABLE_WITHDRAWAL>
	        	 	{
	        	 		for $valSaldoCorte in string($rowconSaldosCTS/ns1:Column[@name = 'totbalactual']/text())
	        	 		return        	 			    
	        	 			if($valSaldoCorte != '')then(
	        	 				<CUTOFF_BALANCE>{ $valSaldoCorte }</CUTOFF_BALANCE>
	        	 			)else()	
	        	 	}
	        	 	<MIN_PAYMENT>{ data($sjConsultaMaestraSaldosTarjetaCredito/MIN_PAYMENT) }</MIN_PAYMENT>
	        	 	<LAST_CUTOFF_DATE>{ data($sjConsultaMaestraSaldosTarjetaCredito/LAST_CUTOFF_DATE) }</LAST_CUTOFF_DATE>
					<LAST_CUTOFF_PAYMENT>{ data($sjConsultaMaestraSaldosTarjetaCredito/LAST_CUTOFF_PAYMENT) }</LAST_CUTOFF_PAYMENT>
	        	 	<CICLE_DUE>{ data($sjConsultaMaestraSaldosTarjetaCredito/CICLE_DUE) }</CICLE_DUE>
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
	        	 		<TOTAL_OVERDUE_BALANCE>{ data($sjConsultaMaestraSaldosTarjetaCredito/TOTAL_OVERDUE_BALANCE) }</TOTAL_OVERDUE_BALANCE>
		        	 	<EXTRA_FINANCING_INFO>
		        	   	{
		        	 		for $valDisponible in string($rowconSaldosCTS/ns1:Column[@name = 'monto_Oferta']/text())
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
		        	 		for $valEstado in string($rowconSaldosCTS/ns1:Column[@name = 'EstadoOferta']/text())
		        	 		return
	        	 				<STATUS>{ $valEstado }</STATUS>
	        	 				
		        	 	}
		        	 	{
		        	 		for $tipoOferta in string($rowconSaldosCTS/ns1:Column[@name = 'TipoOferta']/text())
		        	 		return
	        	 				<OFFER_TYPE>{ $tipoOferta }</OFFER_TYPE> 
		        	 	}				 				
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
	        	</CREDIT_CARD_POINTS_INFO>,
	        	for $valPagoContado in xs:decimal($outputParameters/ns1:RowSet/ns1:Row[1]/ns1:Column[@name = 'amt_access_chks_1'])
	        	let $org := data($outputParameters/ns1:RowSet/ns1:Row[1]/ns1:Column[upper-case(@name) = 'ORG'])
	        	let $rowConsultaSaldoSPMD := $consultaSaldoSPMD/ns7:RowSet/ns7:Row[ns7:Column[@name = 'Org']/text() = $org]
	        	let $valSaldoActual := xs:decimal($outputParameters/ns1:RowSet/ns1:Row[1]/ns1:Column[@name = 'billed_bal'])
	    		let $totalPayment := xs:decimal($sjConsultaMaestraSaldosTarjetaCreditoResponse/TOTAL_PAYMENT)
	    		let $valPagoContadoTotal :=  $valPagoContado - $totalPayment - $rowConsultaSaldoSPMD/ns7:Column[@name = 'PagosDia']/text()
	    		return(
	    			if(string($valPagoContadoTotal) != '')then(
    	 				if($valPagoContadoTotal > 0)then(
    	 					<TOTAL_PAYMENT>{ fn-bea:decimal-round(xs:decimal($valPagoContadoTotal), 2) }</TOTAL_PAYMENT>
    	 				)else(
    	 					<TOTAL_PAYMENT>0</TOTAL_PAYMENT>
    	 				)
    	 			)else(
    	 				<TOTAL_PAYMENT>{ $valPagoContado - $totalPayment }</TOTAL_PAYMENT>
    	 			)
	    		)
	    	)
	    }     
        </ns0:consultaMaestraSaldosTarjetaCreditoResponse>
};

declare variable $sjConsultaMaestraSaldosTarjetaCreditoResponse as element(ns6:sjConsultaMaestraSaldosTarjetaCreditoResponse)? external;
declare variable $outputParameters as element(ns1:OutputParameters)? external;
declare variable $valSaldoActualPuntos as xs:string? external;
declare variable $outputParameters1 as element(ns2:OutputParameters)? external;
declare variable $consultaSaldoSPMD as element(ns7:OutputParameters)? external;

xf:consultaMaestraSaldosTarjetaCreditoHNOut($sjConsultaMaestraSaldosTarjetaCreditoResponse,
$outputParameters, $valSaldoActualPuntos, $outputParameters1, $consultaSaldoSPMD)