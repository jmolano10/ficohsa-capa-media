(:: pragma bea:global-element-parameter parameter="$sjconsultaCuentaTCResponse" element="ns5:sjconsultaCuentaTCResponse" location="../../../BusinessServices/SJS/consultaCuentaTC/xsd/sjconsultaCuentaTCTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$conDatoCuenta" element="ns4:OutputParameters" location="../../../BusinessServices/MasterDataPA/conDatoCuenta/xsd/conDatoCuenta_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$conEncabezadoEstadoCuenta" element="ns0:OutputParameters" location="../../../BusinessServices/MasterDataPA/conEncabezadoEstadoCuenta/xsd/conEncabezadoEstadoCuenta_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$ptEquivalencias" element="ns2:OutputParameters" location="../../../BusinessServices/MDW/consultaEquivalenciasCatalogos/xsd/consultaEquivalenciasCatalogos_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaCuentaTC" element="ns1:OutputParameters" location="../../../BusinessServices/consultaCuentaTC/xsd/consultaCuentaTC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns3:consultaCuentaTCResponse" location="../xsd/consultaCuentaTCTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$sjconsultaCuentaTCResponse1" element="ns5:sjconsultaCuentaTCResponse" location="../../../BusinessServices/SJS/consultaCuentaTC/xsd/sjconsultaCuentaTCTypes.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEquivalenciasCatalogos";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCuentaTC";
declare namespace ns4 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoCuenta";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/consultaCuentaTCTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conEncabezadoEstadoCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCuentaTC/xq/consultaCuentaTCPA_v2Out/";
declare namespace ns5 = "http://www.ficohsa.com.hn/middleware.services/sjconsultaCuentaTCTypes";

declare function valorCatalogoAPPToOSB($valor as xs:string,
	$aplicacion as xs:string,
	$catalogoId as xs:string,
	$equivalencias as element(*)
) as xs:string {
	let $retorno := fn:string($equivalencias/ns2:EQUIVALENCIA[ns2:CATALOGO_ID = $catalogoId and 
															  ns2:APLICACION_DESC = $aplicacion and 
															  ns2:EQUIVALENCIA_DESC = $valor]/ns2:VALOR_DESC/text())
	return
		if($retorno != "") then (
			$retorno
		) else (
			$valor
		)
};

declare function xf:consultaCuentaTCPAOut($sjconsultaCuentaTCResponse as element(ns5:sjconsultaCuentaTCResponse)?,
    $conDatoCuenta as element(ns4:OutputParameters)?,
    $conEncabezadoEstadoCuenta as element(ns0:OutputParameters)?,
    $ptEquivalencias as element(ns2:OutputParameters)?,
    $consultaCuentaTC as element(ns1:OutputParameters)?)
    as element(ns3:consultaCuentaTCResponse) {
        <ns3:consultaCuentaTCResponse>
        {
        	if(not(empty($consultaCuentaTC/ns1:PT_CUENTA_TC/ns1:ACCOUNT_NUMBER))) then (
	        	<ACCOUNT_NUMBER>{ data($consultaCuentaTC/ns1:PT_CUENTA_TC/ns1:ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>,
	            <LOGO>{ data($consultaCuentaTC/ns1:PT_CUENTA_TC/ns1:LOGO) }</LOGO>,
	            <ACCOUNT_CYCLE>{ data($consultaCuentaTC/ns1:PT_CUENTA_TC/ns1:ACCOUNT_CYCLE) }</ACCOUNT_CYCLE>,
	            if(data($consultaCuentaTC/ns1:PT_CUENTA_TC/ns1:OPENING_DATE/text()) != '')then(
            		<OPENING_DATE>{   fn-bea:dateTime-to-string-with-format("yyyy-MM-dd", data($consultaCuentaTC/ns1:PT_CUENTA_TC/ns1:OPENING_DATE)) }</OPENING_DATE>
          		)else(),
	            <SETTLEMENT_MODEL>{ data($consultaCuentaTC/ns1:PT_CUENTA_TC/ns1:SETTLEMENT_MODEL) }</SETTLEMENT_MODEL>,
	             if(data($consultaCuentaTC/ns1:PT_CUENTA_TC/ns1:LAST_CUTOFF_DATE/text()) != '')then(
            		<LAST_CUTOFF_DATE>{  fn-bea:dateTime-to-string-with-format("yyyy-MM-dd", data($consultaCuentaTC/ns1:PT_CUENTA_TC/ns1:LAST_CUTOFF_DATE)) }</LAST_CUTOFF_DATE>
          		)else(),
          		if(data($consultaCuentaTC/ns1:PT_CUENTA_TC/ns1:NEXT_CUTOFF_DATE/text()) != '')then(
            		 <NEXT_CUTOFF_DATE>{ fn-bea:dateTime-to-string-with-format("yyyy-MM-dd", data($consultaCuentaTC/ns1:PT_CUENTA_TC/ns1:NEXT_CUTOFF_DATE)) }</NEXT_CUTOFF_DATE>
          		)else(),
          		if(data($consultaCuentaTC/ns1:PT_CUENTA_TC/ns1:MAX_PAYMENT_DATE/text()) != '')then(
            		 <MAX_PAYMENT_DATE>{   fn-bea:dateTime-to-string-with-format("yyyy-MM-dd",data($consultaCuentaTC/ns1:PT_CUENTA_TC/ns1:MAX_PAYMENT_DATE)) }</MAX_PAYMENT_DATE>
          		)else(''),
          		let $HOLDER_INFORMATION := fn-bea:inlinedXML($consultaCuentaTC/ns1:PT_CUENTA_TC/ns1:HOLDER_INFORMATION)
                return(
                    <HOLDER_INFORMATION>
                        <EDUCATION_LEVEL>{ string($HOLDER_INFORMATION/EDUCATION_LEVEL/text()) }</EDUCATION_LEVEL>
	                    <JOB_TITTLE>{ string($HOLDER_INFORMATION/JOB_TITTLE/text()) }</JOB_TITTLE>
	                    <SCORE>{ string($HOLDER_INFORMATION/SCORE/text()) }</SCORE>
                        <MAIN_INCOME>{ string($HOLDER_INFORMATION/MAIN_INCOME/text()) }</MAIN_INCOME>
                        <SECONDARY_INCOME>{ string($HOLDER_INFORMATION/SECONDARY_INCOME/text()) }</SECONDARY_INCOME>
                        <INCOME_RANGE>{ string($HOLDER_INFORMATION/INCOME_RANGE/text()) }</INCOME_RANGE>
                        <CUSTOMER_ID>{ string($HOLDER_INFORMATION/CUSTOMER_ID/text()) }</CUSTOMER_ID>
                        <CUSTOMER_SEGMENT>{ string($HOLDER_INFORMATION/CUSTOMER_SEGMENT/text()) }</CUSTOMER_SEGMENT>
                        <CUSTOMER_TYPE>{ string($HOLDER_INFORMATION/CUSTOMER_TYPE/text())}</CUSTOMER_TYPE>
                        <PEP>{string($HOLDER_INFORMATION/PEP/text()) }</PEP>
                    </HOLDER_INFORMATION>
                 ),
              	 let $BALANCE_INFORMATION_ITEM:=  fn-bea:inlinedXML($consultaCuentaTC/ns1:PT_CUENTA_TC/ns1:BALANCE_INFORMATION)
              	 for $BALANCE_INFORMATION in $BALANCE_INFORMATION_ITEM 
              	 return(
                    <BALANCE_INFORMATION>
                    	<CURRENCY>{ string($BALANCE_INFORMATION/CURRENCY/text())}</CURRENCY>
                    	<ORG>{ string($BALANCE_INFORMATION/ORG/text())}</ORG>
                    		<BLOCKING_INFORMATION>
									<BLOCK1>
										<BLOCK_CODE>{ string($BALANCE_INFORMATION/BLOCKING_INFORMATION/BLOCK1/BLOCK_CODE/text())}</BLOCK_CODE>
										<BLOCK_DATE>{ string($BALANCE_INFORMATION/BLOCKING_INFORMATION/BLOCK1/BLOCK_DATE/text()) }</BLOCK_DATE>
										<BLOCK_REASON>{ string($BALANCE_INFORMATION/BLOCKING_INFORMATION/BLOCK1/BLOCK_REASON/text()) }</BLOCK_REASON>
									</BLOCK1>
									<BLOCK2>
										<BLOCK_CODE>{ string($BALANCE_INFORMATION/BLOCKING_INFORMATION/BLOCK2/BLOCK_CODE/text())}</BLOCK_CODE>
										<BLOCK_DATE>{ string($BALANCE_INFORMATION/BLOCKING_INFORMATION/BLOCK2/BLOCK_DATE/text()) }</BLOCK_DATE>
										<BLOCK_REASON>{ string($BALANCE_INFORMATION/BLOCKING_INFORMATION/BLOCK2/BLOCK_REASON/text()) }</BLOCK_REASON>
									</BLOCK2>
								</BLOCKING_INFORMATION>
						<INTRAFINANCING_BALANCE>{ string($BALANCE_INFORMATION/INTRAFINANCING_BALANCE/text()) }</INTRAFINANCING_BALANCE>
						<DISPUTE_AMOUNT>{ string($BALANCE_INFORMATION/DISPUTE_AMOUNT/text()) }</DISPUTE_AMOUNT>
						<DISPUTE_QTY>{ string($BALANCE_INFORMATION/DISPUTE_QTY/text()) }</DISPUTE_QTY>
						<INITIAL_BALANCE>{ string($BALANCE_INFORMATION/INITIAL_BALANCE/text()) }</INITIAL_BALANCE>
						<CURRENT_BALANCE>{ string($BALANCE_INFORMATION/CURRENT_BALANCE/text()) }</CURRENT_BALANCE>
				        <MIN_PAYMENT>{ string($BALANCE_INFORMATION/MIN_PAYMENT/text()) }</MIN_PAYMENT> 		
						<CURRENT_MIN_PAYMENT>{ string($BALANCE_INFORMATION/CURRENT_MIN_PAYMENT/text()) }</CURRENT_MIN_PAYMENT>
						<PAYMENT_CUTOFF_AMOUNT>{ string($BALANCE_INFORMATION/PAYMENT_CUTOFF_AMOUNT/text()) }</PAYMENT_CUTOFF_AMOUNT>	
						<PAYMENTS_AMOUNT>{ string($BALANCE_INFORMATION/PAYMENTS_AMOUNT/text()) }</PAYMENTS_AMOUNT>			
						<PENDING_AUTHORIZATIONS>{ string($BALANCE_INFORMATION/PENDING_AUTHORIZATIONS/text()) }</PENDING_AUTHORIZATIONS>
						<PENDING_PAYMENTS>{ string($BALANCE_INFORMATION/PENDING_PAYMENTS/text()) }</PENDING_PAYMENTS>
						<LATE_FEE_BALANCE>{ string($BALANCE_INFORMATION/LATE_FEE_BALANCE/text()) }</LATE_FEE_BALANCE>
						<LATE_FEE_CUTOFF_BALANCE>{ string($BALANCE_INFORMATION/LATE_FEE_CUTOFF_BALANCE/text()) }</LATE_FEE_CUTOFF_BALANCE>
						<CICLE>{ string($BALANCE_INFORMATION/CICLE/text()) }</CICLE>
						<LAST_CUTOFF_LATE_FEE_DATE>{ string($BALANCE_INFORMATION/LAST_CUTOFF_LATE_FEE_DATE/text()) }</LAST_CUTOFF_LATE_FEE_DATE>
						<LAST_CUTOFF_PAYMENT_DATE>{ string($BALANCE_INFORMATION/LAST_CUTOFF_PAYMENT_DATE/text()) }</LAST_CUTOFF_PAYMENT_DATE>
						<LAST_TXN_DATE>{ string($BALANCE_INFORMATION/LAST_TXN_DATE/text()) }</LAST_TXN_DATE>		
						<TEMP_CRLIM_DATE>{ string($BALANCE_INFORMATION/TEMP_CRLIM_DATE/text()) }</TEMP_CRLIM_DATE>	
						<TEMP_CRLIM_AMOUNT>{ string($BALANCE_INFORMATION/TEMP_CRLIM_AMOUNT/text()) }</TEMP_CRLIM_AMOUNT>
						<PURCHASE_AVAILABLE_AMOUNT>{ string($BALANCE_INFORMATION/PURCHASE_AVAILABLE_AMOUNT/text()) }</PURCHASE_AVAILABLE_AMOUNT>
						<OPEN_TO_BUY>{ string($BALANCE_INFORMATION/OPEN_TO_BUY/text()) } </OPEN_TO_BUY>		
						<AVAILABLE_WITHDRAWAL>{ string($BALANCE_INFORMATION/AVAILABLE_WITHDRAWAL/text()) }</AVAILABLE_WITHDRAWAL>
						<CREDIT_LIMIT>{ string($BALANCE_INFORMATION/CREDIT_LIMIT/text()) }</CREDIT_LIMIT>
						<LAST_CRLIM_AMOUNT>{ string($BALANCE_INFORMATION/LAST_CRLIM_AMOUNT/text()) }</LAST_CRLIM_AMOUNT>
						<LATE_FEE_INFORMATION>
							<LATE_FEE_TYPE>{ string($BALANCE_INFORMATION/LATE_FEE_INFORMATION[1]/LATE_FEE_TYPE/text()) }</LATE_FEE_TYPE>
							<LATE_FEE_COUNTER>{ string($BALANCE_INFORMATION/LATE_FEE_INFORMATION[1]/LATE_FEE_COUNTER/text()) }</LATE_FEE_COUNTER>
							<LATE_FEE_AMOUNT>{ string($BALANCE_INFORMATION/LATE_FEE_INFORMATION[1]/LATE_FEE_AMOUNT/text()) }</LATE_FEE_AMOUNT>
						</LATE_FEE_INFORMATION>
						<LATE_FEE_INFORMATION>
							<LATE_FEE_TYPE>{ string($BALANCE_INFORMATION/LATE_FEE_INFORMATION[2]/LATE_FEE_TYPE/text()) }</LATE_FEE_TYPE>
							<LATE_FEE_COUNTER>{ string($BALANCE_INFORMATION/LATE_FEE_INFORMATION[2]/LATE_FEE_COUNTER/text()) }</LATE_FEE_COUNTER>
							<LATE_FEE_AMOUNT>{ string($BALANCE_INFORMATION/LATE_FEE_INFORMATION[2]/LATE_FEE_AMOUNT/text()) }</LATE_FEE_AMOUNT>
						</LATE_FEE_INFORMATION>
						<LATE_FEE_INFORMATION>
							<LATE_FEE_TYPE>{ string($BALANCE_INFORMATION/LATE_FEE_INFORMATION[3]/LATE_FEE_TYPE/text()) }</LATE_FEE_TYPE>
							<LATE_FEE_COUNTER>{ string($BALANCE_INFORMATION/LATE_FEE_INFORMATION[3]/LATE_FEE_COUNTER/text()) }</LATE_FEE_COUNTER>
							<LATE_FEE_AMOUNT>{ string($BALANCE_INFORMATION/LATE_FEE_INFORMATION[3]/LATE_FEE_AMOUNT/text()) }</LATE_FEE_AMOUNT>
						</LATE_FEE_INFORMATION>
						<LATE_FEE_INFORMATION>
							<LATE_FEE_TYPE>{ string($BALANCE_INFORMATION/LATE_FEE_INFORMATION[4]/LATE_FEE_TYPE/text()) }</LATE_FEE_TYPE>
							<LATE_FEE_COUNTER>{ string($BALANCE_INFORMATION/LATE_FEE_INFORMATION[4]/LATE_FEE_COUNTER/text()) }</LATE_FEE_COUNTER>
							<LATE_FEE_AMOUNT>{ string($BALANCE_INFORMATION/LATE_FEE_INFORMATION[4]/LATE_FEE_AMOUNT/text()) }</LATE_FEE_AMOUNT>
						</LATE_FEE_INFORMATION>
						<LATE_FEE_INFORMATION>
							<LATE_FEE_TYPE>{ string($BALANCE_INFORMATION/LATE_FEE_INFORMATION[5]/LATE_FEE_TYPE/text()) }</LATE_FEE_TYPE>
							<LATE_FEE_COUNTER>{ string($BALANCE_INFORMATION/LATE_FEE_INFORMATION[5]/LATE_FEE_COUNTER/text()) }</LATE_FEE_COUNTER>
							<LATE_FEE_AMOUNT>{ string($BALANCE_INFORMATION/LATE_FEE_INFORMATION[5]/LATE_FEE_AMOUNT/text()) }</LATE_FEE_AMOUNT>
						</LATE_FEE_INFORMATION>
						<LATE_FEE_INFORMATION>
							<LATE_FEE_TYPE>{ string($BALANCE_INFORMATION/LATE_FEE_INFORMATION[6]/LATE_FEE_TYPE/text()) }</LATE_FEE_TYPE>
							<LATE_FEE_COUNTER>{ string($BALANCE_INFORMATION/LATE_FEE_INFORMATION[6]/LATE_FEE_COUNTER/text()) }</LATE_FEE_COUNTER>
							<LATE_FEE_AMOUNT>{ string($BALANCE_INFORMATION/LATE_FEE_INFORMATION[6]/LATE_FEE_AMOUNT/text()) }</LATE_FEE_AMOUNT>
						</LATE_FEE_INFORMATION>
						<LATE_FEE_INFORMATION>
							<LATE_FEE_TYPE>{ string($BALANCE_INFORMATION/LATE_FEE_INFORMATION[7]/LATE_FEE_TYPE/text()) }</LATE_FEE_TYPE>
							<LATE_FEE_COUNTER>{ string($BALANCE_INFORMATION/LATE_FEE_INFORMATION[7]/LATE_FEE_COUNTER/text()) }</LATE_FEE_COUNTER>
							<LATE_FEE_AMOUNT>{ string($BALANCE_INFORMATION/LATE_FEE_INFORMATION[7]/LATE_FEE_AMOUNT/text()) }</LATE_FEE_AMOUNT>
						</LATE_FEE_INFORMATION>
						<STATUS>{ string($BALANCE_INFORMATION/STATUS/text())}</STATUS>
						<LAST_PAYMENT_AMOUNT>{ string($BALANCE_INFORMATION/LAST_PAYMENT_AMOUNT/text())}</LAST_PAYMENT_AMOUNT>
						<LAST_PAYMENT_DATE>{ string($BALANCE_INFORMATION/LAST_PAYMENT_DATE/text())}</LAST_PAYMENT_DATE>
						<AMOUNT_LAST_WITHDRAWAL>{ string($BALANCE_INFORMATION/AMOUNT_LAST_WITHDRAWAL/text())}</AMOUNT_LAST_WITHDRAWAL>
						<DATE_LAST_WITHDRAWAL>{ string($BALANCE_INFORMATION/DATE_LAST_WITHDRAWAL/text())}</DATE_LAST_WITHDRAWAL>
						<LAST_PURCHASE_AMOUNT>{ string($BALANCE_INFORMATION/LAST_PURCHASE_AMOUNT/text())}</LAST_PURCHASE_AMOUNT>
						<LAST_PURCHASE_DATE>{ string($BALANCE_INFORMATION/LAST_PURCHASE_DATE/text())}</LAST_PURCHASE_DATE>
                    </BALANCE_INFORMATION>
                    
                 ),
                 <CHANGE_PRODUCT_DATE>{ data($consultaCuentaTC/ns1:PT_CUENTA_TC/ns1:CHANGE_PRODUCT_DATE) }</CHANGE_PRODUCT_DATE>,
                 <NEW_LOGO>{ data($consultaCuentaTC/ns1:PT_CUENTA_TC/ns1:NEW_LOGO) }</NEW_LOGO>,
	             <NEW_ACCOUNT_NUMBER>{ data($consultaCuentaTC/ns1:PT_CUENTA_TC/ns1:NEW_ACCOUNT_NUMBER) }</NEW_ACCOUNT_NUMBER>,
	             if(data($consultaCuentaTC/ns1:PT_CUENTA_TC/ns1:LAST_DATE_LIMIT_CHANGE/text()) != '')then(
            		<LAST_DATE_LIMIT_CHANGE>{ fn-bea:dateTime-to-string-with-format("yyyy-MM-dd", data($consultaCuentaTC/ns1:PT_CUENTA_TC/ns1:LAST_DATE_LIMIT_CHANGE)) }</LAST_DATE_LIMIT_CHANGE>
          		)else(),
	             <CASH_BACK_EARNED>{ data($consultaCuentaTC/ns1:PT_CUENTA_TC/ns1:CASH_BACK_EARNED) }</CASH_BACK_EARNED>,
                 <RSN_CHARGES>{ data($consultaCuentaTC/ns1:PT_CUENTA_TC/ns1:RSN_CHARGES) }</RSN_CHARGES>,
	             <ACCOUNT_HOLDER_LEGAL_ID>{ data($consultaCuentaTC/ns1:PT_CUENTA_TC/ns1:ACCOUNT_HOLDER_LEGAL_ID) }</ACCOUNT_HOLDER_LEGAL_ID>,
                 <ACCOUNT_HOLDER_NAME>{ data($consultaCuentaTC/ns1:PT_CUENTA_TC/ns1:ACCOUNT_HOLDER_NAME) }</ACCOUNT_HOLDER_NAME>,
                 <AFP_ID>{ data($consultaCuentaTC/ns1:PT_CUENTA_TC/ns1:AFP_ID) }</AFP_ID>,
                 <DATE_BENEFIT_CHANGE>{ data($consultaCuentaTC/ns1:PT_CUENTA_TC/ns1:DATE_BENEFIT_CHANGE) }</DATE_BENEFIT_CHANGE>
	         )else(
	         	<ACCOUNT_NUMBER>{ data($sjconsultaCuentaTCResponse/ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>,
                <LOGO>{ data($sjconsultaCuentaTCResponse/LOGO) }</LOGO>,
                <ACCOUNT_CYCLE>{ data($sjconsultaCuentaTCResponse/ACCOUNT_CYCLE) }</ACCOUNT_CYCLE>,
                <OPENING_DATE>{ data($sjconsultaCuentaTCResponse/OPENING_DATE) }</OPENING_DATE>,
                <SETTLEMENT_MODEL>{ data($sjconsultaCuentaTCResponse/SETTLEMENT_MODEL) }</SETTLEMENT_MODEL>,
                <LAST_CUTOFF_DATE>{ data($sjconsultaCuentaTCResponse/LAST_CUTOFF_DATE) }</LAST_CUTOFF_DATE>,
                <NEXT_CUTOFF_DATE>{ data($sjconsultaCuentaTCResponse/NEXT_CUTOFF_DATE) }</NEXT_CUTOFF_DATE>,
                <MAX_PAYMENT_DATE>{ data($sjconsultaCuentaTCResponse/MAX_PAYMENT_DATE) }</MAX_PAYMENT_DATE>,        
                for $HOLDER_INFORMATION in $sjconsultaCuentaTCResponse/HOLDER_INFORMATION
                return(
                    <HOLDER_INFORMATION>
                        {
	                        let $EDUCATION_LEVEL:= string($HOLDER_INFORMATION/EDUCATION_LEVEL/text())
	                        return(
	                        <EDUCATION_LEVEL>{ valorCatalogoAPPToOSB($EDUCATION_LEVEL, 'VISION+PA', '10', $ptEquivalencias) }</EDUCATION_LEVEL>
	                        )
                        }
                        {
	                        let $JOB_TITTLE:= string($HOLDER_INFORMATION/JOB_TITTLE/text())
	                        return(
	                        	<JOB_TITTLE>{ valorCatalogoAPPToOSB($JOB_TITTLE, 'VISION+PA', '11', $ptEquivalencias) }</JOB_TITTLE>
	                        	)
	                        }
                        {
	                        let $SCORE:= string($HOLDER_INFORMATION/SCORE/text())
	                        return(
	                        	<SCORE>{ valorCatalogoAPPToOSB($SCORE, 'VISION+PA', '11', $ptEquivalencias) }</SCORE>
	                        )
                        }
                        <MAIN_INCOME>{ string($HOLDER_INFORMATION/MAIN_INCOME/text()) }</MAIN_INCOME>
                        <SECONDARY_INCOME>{ string($HOLDER_INFORMATION/SECONDARY_INCOME/text()) }</SECONDARY_INCOME>
                        <INCOME_RANGE>{ string($HOLDER_INFORMATION/INCOME_RANGE/text()) }</INCOME_RANGE>
                        <CUSTOMER_ID>{ string($HOLDER_INFORMATION/CUSTOMER_ID/text()) }</CUSTOMER_ID>
                        <CUSTOMER_SEGMENT>{ string($HOLDER_INFORMATION/CUSTOMER_SEGMENT/text()) }</CUSTOMER_SEGMENT>
                        <CUSTOMER_TYPE>{ string($HOLDER_INFORMATION/CUSTOMER_TYPE/text())}</CUSTOMER_TYPE>
                        <PEP>{string($HOLDER_INFORMATION/PEP/text()) }</PEP>
                    </HOLDER_INFORMATION>
                ),
				let $rowDatosCuenta := $conDatoCuenta/ns4:RowSet/ns4:Row
				let $rowconEncabezadoEstadoCuentaOut := $conEncabezadoEstadoCuenta/ns0:RowSet/ns2:Row
				return(
					<BALANCE_INFORMATION>
						{
							for $currency in string($rowDatosCuenta/ns4:Column[@name = 'codMoneda']/text())
							return
								<CURRENCY>{ $currency }</CURRENCY>
						}
						<ORG>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/ORG/text()) }</ORG>
						<BLOCKING_INFORMATION>
							<BLOCK1>
								<BLOCK_CODE>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/BLOCKING_INFORMATION/BLOCK1/BLOCK_CODE/text())}</BLOCK_CODE>
								<BLOCK_DATE>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/BLOCKING_INFORMATION/BLOCK1/BLOCK_DATE/text()) }</BLOCK_DATE>
								<BLOCK_REASON>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/BLOCKING_INFORMATION/BLOCK1/BLOCK_REASON/text()) }</BLOCK_REASON>
							</BLOCK1>
							<BLOCK2>
								<BLOCK_CODE>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/BLOCKING_INFORMATION/BLOCK2/BLOCK_CODE/text())}</BLOCK_CODE>
								<BLOCK_DATE>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/BLOCKING_INFORMATION/BLOCK2/BLOCK_DATE/text()) }</BLOCK_DATE>
								<BLOCK_REASON>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/BLOCKING_INFORMATION/BLOCK2/BLOCK_REASON/text()) }</BLOCK_REASON>
							</BLOCK2>
						</BLOCKING_INFORMATION>
						{
	            	for $intrafinancingBalance in string($rowDatosCuenta/ns2:Column[@name = 'balance_prin']/text())
	            	return
	            		if(fn-bea:trim($intrafinancingBalance) != '') then(
	            			<INTRAFINANCING_BALANCE>{ $intrafinancingBalance }</INTRAFINANCING_BALANCE>
	            		)else()			            				
	            }			            			            
	            {
	            	for $disputeAmount in string($rowconEncabezadoEstadoCuentaOut/ns0:Column[@name = 'cantdisputa']/text())
	            	return
	            		if(fn-bea:trim($disputeAmount) != '') then(
	            			<DISPUTE_AMOUNT>{ $disputeAmount }</DISPUTE_AMOUNT>
	            		) else ()
	            }
	            {
	            	for $disputeQTY in string($rowconEncabezadoEstadoCuentaOut/ns0:Column[@name = 'numdisputa']/text())
	            	return
	            		if(fn-bea:trim($disputeQTY) != '') then(
	            			<DISPUTE_QTY>{ $disputeQTY }</DISPUTE_QTY>
	            		)else()
	            }
	            {
	            	for $initialBalance in string($rowconEncabezadoEstadoCuentaOut/ns0:Column[@name = 'totbalini']/text())
	            	return
	            		if(fn-bea:trim($initialBalance) != '') then(
	            			<INITIAL_BALANCE>{ $initialBalance }</INITIAL_BALANCE>
	            		)else()
	            }
	            {
	           		let $currentBalance:= $conDatoCuenta/ns4:RowSet/ns4:Row/ns4:Column[@name = 'billed_bal']/text() - $sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/PENDING_PAYMENTS/text()
	            	return
	            		if(fn-bea:trim(fn:string($currentBalance)) != '') then(
	            			<CURRENT_BALANCE>{ fn-bea:decimal-round(xs:decimal($currentBalance), 2) }</CURRENT_BALANCE>
	            		)else(
	            			<CURRENT_BALANCE>{ $conDatoCuenta/ns4:RowSet/ns4:Row/ns4:Column[@name = 'billed_bal']/text() }</CURRENT_BALANCE>
	            		)
	            }
	            {
	            	for $minPayment in string($rowconEncabezadoEstadoCuentaOut/ns0:Column[@name = 'Actualdue']/text())
	            	return
	            		if(fn-bea:trim($minPayment) != '') then(
	            			<MIN_PAYMENT>{ $minPayment }</MIN_PAYMENT>
	            		)else()
	            }
				<CURRENT_MIN_PAYMENT>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/CURRENT_MIN_PAYMENT/text()) }</CURRENT_MIN_PAYMENT>
				 {
	            	for $paymentCutOffAmount in string($rowconEncabezadoEstadoCuentaOut/ns0:Column[@name = 'Totbalactual']/text())
	            	return
	            		if(fn-bea:trim($paymentCutOffAmount) != '') then(
	            			<PAYMENT_CUTOFF_AMOUNT>{ $paymentCutOffAmount }</PAYMENT_CUTOFF_AMOUNT>
	            		)else()
	            }
	            <PAYMENTS_AMOUNT>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/PAYMENTS_AMOUNT/text()) }</PAYMENTS_AMOUNT>			
				<PENDING_AUTHORIZATIONS>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/PENDING_AUTHORIZATIONS/text()) }</PENDING_AUTHORIZATIONS>
				<PENDING_PAYMENTS>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/PENDING_PAYMENTS/text()) }</PENDING_PAYMENTS>
				<LATE_FEE_BALANCE>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LATE_FEE_BALANCE/text()) }</LATE_FEE_BALANCE>
				{
	            	for $lateFeeCoutoffbalance in string($rowconEncabezadoEstadoCuentaOut/ns0:Column[@name = 'Cantotaldue']/text())
	            	return
	            		if(fn-bea:trim($lateFeeCoutoffbalance) != '') then(
	            			<LATE_FEE_CUTOFF_BALANCE>{ $lateFeeCoutoffbalance }</LATE_FEE_CUTOFF_BALANCE>
	            		)else()
	            }			
				<CICLE>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/CICLE/text()) }</CICLE>
				<LAST_CUTOFF_LATE_FEE_DATE>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LAST_CUTOFF_LATE_FEE_DATE/text()) }</LAST_CUTOFF_LATE_FEE_DATE>
				<LAST_CUTOFF_PAYMENT_DATE>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LAST_CUTOFF_PAYMENT_DATE/text()) }</LAST_CUTOFF_PAYMENT_DATE>
				<LAST_TXN_DATE>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LAST_TXN_DATE/text()) }</LAST_TXN_DATE>		
				<TEMP_CRLIM_DATE>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/TEMP_CRLIM_DATE/text()) }</TEMP_CRLIM_DATE>	
				<TEMP_CRLIM_AMOUNT>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/TEMP_CRLIM_AMOUNT/text()) }</TEMP_CRLIM_AMOUNT>
				<PURCHASE_AVAILABLE_AMOUNT>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/PURCHASE_AVAILABLE_AMOUNT/text()) }</PURCHASE_AVAILABLE_AMOUNT>
				<OPEN_TO_BUY>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/OPEN_TO_BUY/text()) } </OPEN_TO_BUY>		
				<AVAILABLE_WITHDRAWAL>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/AVAILABLE_WITHDRAWAL/text()) }</AVAILABLE_WITHDRAWAL>
				<CREDIT_LIMIT>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/CREDIT_LIMIT/text()) }</CREDIT_LIMIT>
				<LAST_CRLIM_AMOUNT>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LAST_CRLIM_AMOUNT/text()) }</LAST_CRLIM_AMOUNT>		
				<LATE_FEE_INFORMATION>
					<LATE_FEE_TYPE>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LATE_FEE_INFORMATION[1]/LATE_FEE_TYPE/text()) }</LATE_FEE_TYPE>
					<LATE_FEE_COUNTER>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LATE_FEE_INFORMATION[1]/LATE_FEE_COUNTER/text()) }</LATE_FEE_COUNTER>
					<LATE_FEE_AMOUNT>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LATE_FEE_INFORMATION[1]/LATE_FEE_AMOUNT/text()) }</LATE_FEE_AMOUNT>
				</LATE_FEE_INFORMATION>
				<LATE_FEE_INFORMATION>
					<LATE_FEE_TYPE>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LATE_FEE_INFORMATION[2]/LATE_FEE_TYPE/text()) }</LATE_FEE_TYPE>
					<LATE_FEE_COUNTER>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LATE_FEE_INFORMATION[2]/LATE_FEE_COUNTER/text()) }</LATE_FEE_COUNTER>
					<LATE_FEE_AMOUNT>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LATE_FEE_INFORMATION[2]/LATE_FEE_AMOUNT/text()) }</LATE_FEE_AMOUNT>
				</LATE_FEE_INFORMATION>
				<LATE_FEE_INFORMATION>
					<LATE_FEE_TYPE>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LATE_FEE_INFORMATION[3]/LATE_FEE_TYPE/text()) }</LATE_FEE_TYPE>
					<LATE_FEE_COUNTER>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LATE_FEE_INFORMATION[3]/LATE_FEE_COUNTER/text()) }</LATE_FEE_COUNTER>
					<LATE_FEE_AMOUNT>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LATE_FEE_INFORMATION[3]/LATE_FEE_AMOUNT/text()) }</LATE_FEE_AMOUNT>
				</LATE_FEE_INFORMATION>
				<LATE_FEE_INFORMATION>
					<LATE_FEE_TYPE>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LATE_FEE_INFORMATION[4]/LATE_FEE_TYPE/text()) }</LATE_FEE_TYPE>
					<LATE_FEE_COUNTER>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LATE_FEE_INFORMATION[4]/LATE_FEE_COUNTER/text()) }</LATE_FEE_COUNTER>
					<LATE_FEE_AMOUNT>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LATE_FEE_INFORMATION[4]/LATE_FEE_AMOUNT/text()) }</LATE_FEE_AMOUNT>
				</LATE_FEE_INFORMATION>
				<LATE_FEE_INFORMATION>
					<LATE_FEE_TYPE>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LATE_FEE_INFORMATION[5]/LATE_FEE_TYPE/text()) }</LATE_FEE_TYPE>
					<LATE_FEE_COUNTER>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LATE_FEE_INFORMATION[5]/LATE_FEE_COUNTER/text()) }</LATE_FEE_COUNTER>
					<LATE_FEE_AMOUNT>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LATE_FEE_INFORMATION[5]/LATE_FEE_AMOUNT/text()) }</LATE_FEE_AMOUNT>
				</LATE_FEE_INFORMATION>
				<LATE_FEE_INFORMATION>
					<LATE_FEE_TYPE>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LATE_FEE_INFORMATION[6]/LATE_FEE_TYPE/text()) }</LATE_FEE_TYPE>
					<LATE_FEE_COUNTER>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LATE_FEE_INFORMATION[6]/LATE_FEE_COUNTER/text()) }</LATE_FEE_COUNTER>
					<LATE_FEE_AMOUNT>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LATE_FEE_INFORMATION[6]/LATE_FEE_AMOUNT/text()) }</LATE_FEE_AMOUNT>
				</LATE_FEE_INFORMATION>
				<LATE_FEE_INFORMATION>
					<LATE_FEE_TYPE>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LATE_FEE_INFORMATION[7]/LATE_FEE_TYPE/text()) }</LATE_FEE_TYPE>
					<LATE_FEE_COUNTER>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LATE_FEE_INFORMATION[7]/LATE_FEE_COUNTER/text()) }</LATE_FEE_COUNTER>
					<LATE_FEE_AMOUNT>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LATE_FEE_INFORMATION[7]/LATE_FEE_AMOUNT/text()) }</LATE_FEE_AMOUNT>
				</LATE_FEE_INFORMATION>
				<STATUS>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/STATUS/text())}</STATUS>
				<LAST_PAYMENT_AMOUNT>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LAST_PAYMENT_AMOUNT/text())}</LAST_PAYMENT_AMOUNT>
				<LAST_PAYMENT_DATE>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LAST_PAYMENT_DATE/text())}</LAST_PAYMENT_DATE>
				<AMOUNT_LAST_WITHDRAWAL>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/AMOUNT_LAST_WITHDRAWAL/text())}</AMOUNT_LAST_WITHDRAWAL>
				<DATE_LAST_WITHDRAWAL>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/DATE_LAST_WITHDRAWAL/text())}</DATE_LAST_WITHDRAWAL>
				<LAST_PURCHASE_AMOUNT>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LAST_PURCHASE_AMOUNT/text())}</LAST_PURCHASE_AMOUNT>
				<LAST_PURCHASE_DATE>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/LAST_PURCHASE_DATE/text())}</LAST_PURCHASE_DATE>
			</BALANCE_INFORMATION>
			),
                <CHANGE_PRODUCT_DATE>{ data($sjconsultaCuentaTCResponse/CHANGE_PRODUCT_DATE) }</CHANGE_PRODUCT_DATE>,
                <NEW_LOGO>{ data($sjconsultaCuentaTCResponse/NEW_LOGO) }</NEW_LOGO>,
                <NEW_ACCOUNT_NUMBER>{ data($sjconsultaCuentaTCResponse/NEW_ACCOUNT_NUMBER) }</NEW_ACCOUNT_NUMBER>,
                <LAST_DATE_LIMIT_CHANGE>{ data($sjconsultaCuentaTCResponse/LAST_DATE_LIMIT_CHANGE) }</LAST_DATE_LIMIT_CHANGE>,
                <CASH_BACK_EARNED>{ data($sjconsultaCuentaTCResponse/CASH_BACK_EARNED) }</CASH_BACK_EARNED>,
                
	                for $rsncharges in fn:string($conDatoCuenta/ns4:RowSet/ns4:Row/ns4:Column[@name = 'misc_user_1']/text())
					return
	                	if( fn-bea:trim($rsncharges) != '')then(
	        	        	<RSN_CHARGES>{ $rsncharges}</RSN_CHARGES>
						)else(),
				
        	      
        	    for $accountHolderLegalId in $conDatoCuenta/ns4:RowSet/ns4:Row
				where $accountHolderLegalId/ns4:Column[upper-case(@name) = 'TIPOORG']/text() = "BASE"
				return
				 	<ACCOUNT_HOLDER_LEGAL_ID>{ string($accountHolderLegalId/ns4:Column[@name = 'numero_id']/text()) }</ACCOUNT_HOLDER_LEGAL_ID>,
				 		    
			    for $accountHolderName in $conDatoCuenta/ns4:RowSet/ns4:Row
				where $accountHolderName/ns4:Column[upper-case(@name) = 'TIPOORG']/text() = "BASE"
				return
				   <ACCOUNT_HOLDER_NAME>{ string($accountHolderName/ns4:Column[@name = 'nombre_cliente']/text()) }</ACCOUNT_HOLDER_NAME>              
		     
	         )
	    }
        </ns3:consultaCuentaTCResponse>
};

declare variable $sjconsultaCuentaTCResponse as element(ns5:sjconsultaCuentaTCResponse)? external;
declare variable $conDatoCuenta as element(ns4:OutputParameters)? external;
declare variable $conEncabezadoEstadoCuenta as element(ns0:OutputParameters)? external;
declare variable $ptEquivalencias as element(ns2:OutputParameters)? external;
declare variable $consultaCuentaTC as element(ns1:OutputParameters)? external;

xf:consultaCuentaTCPAOut($sjconsultaCuentaTCResponse,
    $conDatoCuenta,
    $conEncabezadoEstadoCuenta,
    $ptEquivalencias,
    $consultaCuentaTC)