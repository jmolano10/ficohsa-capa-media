xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$conDatoCuentaOut" element="ns4:OutputParameters" location="../../../BusinessServices/MasterDataPA/conDatoCuenta/xsd/conDatoCuenta_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$conEncabezadoEstadoCuentaOut" element="ns2:OutputParameters" location="../../../BusinessServices/MasterDataPA/conEncabezadoEstadoCuenta/xsd/conEncabezadoEstadoCuenta_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$ptEquivalencias" element="ns3:OutputParameters" location="../../../BusinessServices/MDW/consultaEquivalenciasCatalogos/xsd/consultaEquivalenciasCatalogos_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$sjconsultaCuentaTCResponse" element="ns0:sjconsultaCuentaTCResponse" location="../../../BusinessServices/SJS/consultaCuentaTC/xsd/sjconsultaCuentaTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/registraCuentaTC/xsd/registraCuentaTC_sp.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conEncabezadoEstadoCuenta";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraCuentaTC";
declare namespace ns4 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoCuenta";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEquivalenciasCatalogos";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjconsultaCuentaTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCuentaTC/xq/registraCuentaTCIn/";

declare function valorCatalogoAPPToOSB($valor as xs:string,
	$aplicacion as xs:string,
	$catalogoId as xs:string,
	$equivalencias as element(*)
) as xs:string {
	let $retorno := fn:string($equivalencias/ns3:EQUIVALENCIA[ns3:CATALOGO_ID = $catalogoId and 
															  ns3:APLICACION_DESC = $aplicacion and 
															  ns3:EQUIVALENCIA_DESC = $valor]/ns3:VALOR_DESC/text())
	return
		if($retorno != "") then (
			$retorno
		) else (
			$valor
		)
};

declare function xf:registraCuentaTCIn($conDatoCuentaOut as element(ns4:OutputParameters),
    $conEncabezadoEstadoCuentaOut as element(ns2:OutputParameters),
    $ptEquivalencias as element(ns3:OutputParameters),
    $sjconsultaCuentaTCResponse as element(ns0:sjconsultaCuentaTCResponse),
    $countryCode as xs:string, $saldolcy as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGO_PAIS>{ $countryCode }</ns1:PV_CODIGO_PAIS>
            <ns1:PT_CUENTA_TC>
                <ns1:ACCOUNT_NUMBER>{ data($sjconsultaCuentaTCResponse/ACCOUNT_NUMBER) }</ns1:ACCOUNT_NUMBER>
                <ns1:LOGO>{ data($sjconsultaCuentaTCResponse/LOGO) }</ns1:LOGO>
                <ns1:ACCOUNT_CYCLE>{ data($sjconsultaCuentaTCResponse/ACCOUNT_CYCLE) }</ns1:ACCOUNT_CYCLE>
                <ns1:OPENING_DATE>{ data($sjconsultaCuentaTCResponse/OPENING_DATE) }</ns1:OPENING_DATE>
                <ns1:SETTLEMENT_MODEL>{ data($sjconsultaCuentaTCResponse/SETTLEMENT_MODEL) }</ns1:SETTLEMENT_MODEL>
                <ns1:LAST_CUTOFF_DATE>{ data($sjconsultaCuentaTCResponse/LAST_CUTOFF_DATE) }</ns1:LAST_CUTOFF_DATE>
                <ns1:NEXT_CUTOFF_DATE>{ data($sjconsultaCuentaTCResponse/NEXT_CUTOFF_DATE) }</ns1:NEXT_CUTOFF_DATE>
                <ns1:MAX_PAYMENT_DATE>{ data($sjconsultaCuentaTCResponse/MAX_PAYMENT_DATE) }</ns1:MAX_PAYMENT_DATE>
                <ns1:HOLDER_INFORMATION>
                    {
                        fn-bea:serialize(
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
	                        )
                        )
                    }
				</ns1:HOLDER_INFORMATION>
				<ns1:BALANCE_INFORMATION>{
					fn-bea:serialize(
						let $rowDatosCuenta := $conDatoCuentaOut/ns4:RowSet/ns4:Row
						let $rowconEncabezadoEstadoCuentaOut := $conEncabezadoEstadoCuentaOut/ns2:RowSet/ns2:Row
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
			            	for $intrafinancingBalance in string($rowDatosCuenta/ns4:Column[@name = 'balance_prin']/text())
			            	return
			            		if(fn-bea:trim($intrafinancingBalance) != '') then(
			            			<INTRAFINANCING_BALANCE>{ $intrafinancingBalance }</INTRAFINANCING_BALANCE>
			            		)else()			            				
			            }			            			            
			            {
			            	for $disputeAmount in string($rowconEncabezadoEstadoCuentaOut/ns2:Column[@name = 'cantdisputa']/text())
			            	return
			            		if(fn-bea:trim($disputeAmount) != '') then(
			            			<DISPUTE_AMOUNT>{ $disputeAmount }</DISPUTE_AMOUNT>
			            		) else ()
			            }
			            {
			            	for $disputeQTY in string($rowconEncabezadoEstadoCuentaOut/ns2:Column[@name = 'numdisputa']/text())
			            	return
			            		if(fn-bea:trim($disputeQTY) != '') then(
			            			<DISPUTE_QTY>{ $disputeQTY }</DISPUTE_QTY>
			            		)else()
			            }
			            {
			            	for $initialBalance in string($rowconEncabezadoEstadoCuentaOut/ns2:Column[@name = 'totbalini']/text())
			            	return
			            		if(fn-bea:trim($initialBalance) != '') then(
			            			<INITIAL_BALANCE>{ $initialBalance }</INITIAL_BALANCE>
			            		)else()
			            }
			            {
			           		for $currentBalance in string($rowDatosCuenta/ns4:Column[@name = 'billed_bal']/text())
			            	return
			            		if(fn-bea:trim($currentBalance) != '') then(
			            			<CURRENT_BALANCE>{ $saldolcy }</CURRENT_BALANCE>
			            		)else()
			            }
			            {
			            	for $minPayment in string($rowconEncabezadoEstadoCuentaOut/ns2:Column[@name = 'Actualdue']/text())
			            	return
			            		if(fn-bea:trim($minPayment) != '') then(
			            			<MIN_PAYMENT>{ $minPayment }</MIN_PAYMENT>
			            		)else()
			            }
						<CURRENT_MIN_PAYMENT>{ string($sjconsultaCuentaTCResponse/BALANCE_INFORMATION[1]/CURRENT_MIN_PAYMENT/text()) }</CURRENT_MIN_PAYMENT>
						 {
			            	for $paymentCutOffAmount in string($rowconEncabezadoEstadoCuentaOut/ns2:Column[@name = 'Totbalactual']/text())
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
			            	for $lateFeeCoutoffbalance in string($rowconEncabezadoEstadoCuentaOut/ns2:Column[@name = 'Cantotaldue']/text())
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
						
						)
					)
				}</ns1:BALANCE_INFORMATION>
                <ns1:CHANGE_PRODUCT_DATE>{ data($sjconsultaCuentaTCResponse/CHANGE_PRODUCT_DATE) }</ns1:CHANGE_PRODUCT_DATE>
                <ns1:NEW_LOGO>{ data($sjconsultaCuentaTCResponse/NEW_LOGO) }</ns1:NEW_LOGO>
                <ns1:NEW_ACCOUNT_NUMBER>{ data($sjconsultaCuentaTCResponse/NEW_ACCOUNT_NUMBER) }</ns1:NEW_ACCOUNT_NUMBER>
                <ns1:LAST_DATE_LIMIT_CHANGE>{ data($sjconsultaCuentaTCResponse/LAST_DATE_LIMIT_CHANGE) }</ns1:LAST_DATE_LIMIT_CHANGE>
                <ns1:CASH_BACK_EARNED>{ data($sjconsultaCuentaTCResponse/CASH_BACK_EARNED) }</ns1:CASH_BACK_EARNED>
                {
	                for $rsncharges in fn:string($conDatoCuentaOut/ns4:RowSet/ns4:Row/ns4:Column[@name = 'misc_user_1']/text())
					return
	                	if( fn-bea:trim($rsncharges) != '')then(
	        	        	<RSN_CHARGES>{ $rsncharges}</RSN_CHARGES>
						)else()
				}
        	  {      
        	    for $accountHolderLegalId in $conDatoCuentaOut/ns4:RowSet/ns4:Row
				where $accountHolderLegalId/ns4:Column[upper-case(@name) = 'TIPOORG']/text() = "BASE"
				return
				 	<ACCOUNT_HOLDER_LEGAL_ID>{ string($accountHolderLegalId/ns4:Column[@name = 'numero_id']/text()) }</ACCOUNT_HOLDER_LEGAL_ID>,
				 		    
			    for $accountHolderName in $conDatoCuentaOut/ns4:RowSet/ns2:Row
				where $accountHolderName/ns4:Column[upper-case(@name) = 'TIPOORG']/text() = "BASE"
				return
				   <ACCOUNT_HOLDER_NAME>{ string($accountHolderName/ns4:Column[@name = 'nombre_cliente']/text()) }</ACCOUNT_HOLDER_NAME>              
		     }
            </ns1:PT_CUENTA_TC>
        </ns1:InputParameters>
};

declare variable $conDatoCuentaOut as element(ns4:OutputParameters) external;
declare variable $conEncabezadoEstadoCuentaOut as element(ns2:OutputParameters) external;
declare variable $ptEquivalencias as element(ns3:OutputParameters) external;
declare variable $sjconsultaCuentaTCResponse as element(ns0:sjconsultaCuentaTCResponse) external;
declare variable $countryCode as xs:string external;
declare variable $saldolcy as xs:string external;

xf:registraCuentaTCIn($conDatoCuentaOut,
    $conEncabezadoEstadoCuentaOut,
    $ptEquivalencias,
    $sjconsultaCuentaTCResponse,
    $countryCode, $saldolcy)