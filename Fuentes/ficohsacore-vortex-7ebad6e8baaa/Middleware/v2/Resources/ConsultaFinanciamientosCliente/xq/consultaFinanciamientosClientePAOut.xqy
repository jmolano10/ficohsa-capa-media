xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/MasterDataPA/conListadoPrestamos/xsd/conListadoPrestamos_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaFinanciamientosClienteResponse" location="../xsd/consultaFinanciamientosClienteTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFinanciamientosCliente/xq/consultaFinanciamientosClientePAOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaFinanciamientosClienteTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conListadoPrestamos";

declare function xf:consultaFinanciamientosClientePAOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:consultaFinanciamientosClienteResponse) {
        <ns0:consultaFinanciamientosClienteResponse>
        {
            	for $rows in $outputParameters1/ns1:RowSet/ns1:Row
            	return 
            	(
            	<consultaFinanciamientosClienteResponseRecordType>	
            		{
            		    let $productType := string($rows/ns1:Column[@name = 'ProductoFinanciamiento']/text())
            		    return
            		        if($productType != "")then(
            		           <PRODUCT_TYPE>{$productType}</PRODUCT_TYPE>
            		        )else()
            		}
					{
						let $org := string($rows/ns1:Column[@name = 'org']/text())
						return
							if($org != "")then(
								<ORG>{$org}</ORG>
							)else()
					}
					{	
						let $currency := string($rows/ns1:Column[@name = 'moneda']/text())
						return
						<CURRENCY>{$currency}</CURRENCY>
					}
					{
						let $planCode := string($rows/ns1:Column[@name = 'numplan']/text())
						return
							<PLAN_CODE>{$planCode}</PLAN_CODE>
					}
					{
						let $planSequence := string($rows/ns1:Column[@name = 'PlanRecord']/text())
						return
							<PLAN_SEQUENCE>{$planSequence}</PLAN_SEQUENCE>

					}
					{
						let $fincancingRef := string($rows/ns1:Column[@name = 'NumReferencia']/text())
						return
								<FINANCING_REFERENCE>{$fincancingRef}</FINANCING_REFERENCE>
					}
					
					{
						let $productNumber := string($rows/ns1:Column[@name = 'cuenta']/text())
						return
								<PRODUCT_NUMBER>{$productNumber}</PRODUCT_NUMBER>
					}
					{
						let $disbursementDate := $rows/ns1:Column[@name = 'FecDesembolso']
						return
							if(string($disbursementDate/text()) != '')then(
								<DISBURSEMENT_DATE>{fn-bea:date-from-string-with-format('yyyy-MM-dd',fn-bea:dateTime-to-string-with-format('yyyy-MM-dd',data($disbursementDate)))}</DISBURSEMENT_DATE>
							)else()
            		}
            		{
            			let $maturityDate := $rows/ns1:Column[@name = 'FechaPago']
						return
							if(string($maturityDate/text()) != '')then(
								<MATURITY_DATE>{fn-bea:date-from-string-with-format('yyyy-MM-dd',fn-bea:dateTime-to-string-with-format('yyyy-MM-dd',data($maturityDate)))}</MATURITY_DATE>
							)else()
            		
            		}
            		{
						let $principalInAmount := string($rows/ns1:Column[@name = 'MontoInicial']/text())
						return
							if($principalInAmount != '')then(
								<PRINCIPAL_INICIAL_AMOUNT>{$principalInAmount}</PRINCIPAL_INICIAL_AMOUNT>
							)else()
					}
					{
						let $principalDueAmount := string($rows/ns1:Column[@name = 'BalanceActual']/text())
						return
							if($principalDueAmount != '')then(
								<PRINCIPAL_DUE_AMOUNT>{$principalDueAmount}</PRINCIPAL_DUE_AMOUNT>
							)else()
					}
					{
						let $interestRate := string($rows/ns1:Column[@name = 'Tasa']/text())
						return
							if($interestRate != '')then(
								<INTEREST_RATE>{$interestRate}</INTEREST_RATE>
							)else()
					}
					{
						let $interestAmount := string($rows/ns1:Column[@name = 'InteresTotal']/text())
						return
							if($interestAmount != '')then(
								<INTEREST_AMOUNT>{$interestAmount}</INTEREST_AMOUNT>
							)else()
					}
					{
						let $insuranceAmount := string($rows/ns1:Column[@name = 'SeguroTotal']/text())
						return
							if($insuranceAmount != '')then(
								<INSURANCE_AMOUNT>{$insuranceAmount}</INSURANCE_AMOUNT>
							)else()
					}
					{
						let $pendingInsuranceAmount := string($rows/ns1:Column[@name = 'Seguros']/text())
						return
							if($pendingInsuranceAmount != '')then(
								<PENDING_INSURANCE_AMOUNT>{$pendingInsuranceAmount}</PENDING_INSURANCE_AMOUNT>
							)else()
					}
					{
						let $commisionAmount := string($rows/ns1:Column[@name = 'ComisionTotal']/text())
						return
							if($commisionAmount != '')then(
								<COMMISION_AMOUNT>{$commisionAmount}</COMMISION_AMOUNT>
							)else()
					}
					{
						let $pendingConmissionAmount := string($rows/ns1:Column[@name = 'Comision']/text())
						return
							if($pendingConmissionAmount != '')then(
								<PENDING_COMMISION_AMOUNT>{$pendingConmissionAmount}</PENDING_COMMISION_AMOUNT>
							)else()
					}
					{
						let $penaltyAmount := string($rows/ns1:Column[@name = 'InteresMoratorio']/text())
						return
							if($penaltyAmount != '')then(
								<PENALTY_AMOUNT>{$penaltyAmount}</PENALTY_AMOUNT>
							)else()
					}
					{
						let $monthlyPayment := string($rows/ns1:Column[@name = 'MontoAjustado']/text())
						return
							if($monthlyPayment != '')then(
								<MONTHLY_PAYMENT>{$monthlyPayment}</MONTHLY_PAYMENT>
							)else()
					}
					{
						let $initialLoanTerm := string($rows/ns1:Column[@name = 'PlazoInicial']/text())
						return
							if($initialLoanTerm != '')then(
								<INITIAL_LOAN_TERM>{$initialLoanTerm}</INITIAL_LOAN_TERM>
							)else()
					}
					{
						let $remainigLoanTerm := string($rows/ns1:Column[@name = 'PlazoPendiente']/text())
						return
							if($remainigLoanTerm != '')then(
								<REMAINING_LOAN_TERM>{$remainigLoanTerm}</REMAINING_LOAN_TERM>
							)else()
					}
					{
						let $currentLoanTerm := string($rows/ns1:Column[@name = 'PlazoActual']/text())
						return
							if($currentLoanTerm != '')then(
								<CURRENT_LOAN_TERM>{$currentLoanTerm}</CURRENT_LOAN_TERM>
							)else()
					}
					{
						let $totalDebt := string($rows/ns1:Column[@name = 'TotalaPagar']/text())
						return
							if($totalDebt != '')then(
								<TOTAL_DEBT>{$totalDebt}</TOTAL_DEBT>
							)else()
					}
					{
						let $minPaymentAmount := string($rows/ns1:Column[@name = 'PagoMinimo']/text())
						return
							if($minPaymentAmount != '')then(
								<MIN_PAYMENT_AMOUNT>{$minPaymentAmount}</MIN_PAYMENT_AMOUNT>
							)else()
					}
					{
						let $chargeCycleDay := string($rows/ns1:Column[@name = 'Ciclo']/text())
						return
							if($chargeCycleDay != '')then(
								<CHARGE_CYCLE_DAY>{$chargeCycleDay}</CHARGE_CYCLE_DAY>
							)else()
					}
					{
						let $pendingPrincipalAmount := string($rows/ns1:Column[@name = 'SaldoActual']/text())
						return
						if($pendingPrincipalAmount != '')then(
							<PENDING_PRINCIPAL_AMOUNT>{ $pendingPrincipalAmount }</PENDING_PRINCIPAL_AMOUNT>
						)else()
					}
					{
						let $cardNumber := string($rows/ns1:Column[@name = 'NumeroTarjeta']/text())
						return
						if($cardNumber != '')then(
							<CARD_NUMBER>{ $cardNumber }</CARD_NUMBER>
						)else()
					}
					{
						let $loanIndicator := string($rows/ns1:Column[@name = 'IndicadorFinanciamiento']/text())
						return
						if($loanIndicator != '')then(
							<LOAN_INDICATOR>{ $loanIndicator }</LOAN_INDICATOR>
						)else()
					}
					{
						let $planDescription := string($rows/ns1:Column[@name = 'DescripcionPlan']/text())
						return
						if($planDescription != '')then(
							<PLAN_DESCRIPTION>{ $planDescription }</PLAN_DESCRIPTION>
						)else()
					}
            	 </consultaFinanciamientosClienteResponseRecordType>
            	)
            }
        </ns0:consultaFinanciamientosClienteResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consultaFinanciamientosClientePAOut($outputParameters1)