xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/creditManagement";
(:: import schema at "../../../../../../MWBanking/CreditManagement/RequestorServices/XSD/creditManagement.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $responseData as element() external;
declare variable $uuid as xs:string external;

declare function local:Tx_consulta_ONBASE_V2_To_GetConsolidatedCustomerRiskGTResponse($responseData as element(), 
                                                                                      $uuid as xs:string) 
                                                                                      as element() (:: schema-element(ns1:getConsolidatedCustomerRiskResponse) ::) {
    <ns1:getConsolidatedCustomerRiskResponse>
     <ns1:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns1:StatusInfo>
        
        <ns1:GetConsolidatedCustomerRisk>
	<ns1:LoanMaintenance>
		<ns1:CustomerInfo>
			{
			for $IDENTIDAD in $responseData/*:Identidad
			return
			<ns1:Id>{ data($IDENTIDAD) }</ns1:Id>
			}
			{
			for $TARGET in $responseData/*:Target
			return
			<ns1:Target>{ data($TARGET) }</ns1:Target>
			}
			{
			for $DATE_OF_BIRTH in $responseData/*:FechaNacimiento
			return
			<ns1:DateOfBirth>{ fn-bea:date-from-string-with-format("yyyy-MM-dd",data($DATE_OF_BIRTH)) }</ns1:DateOfBirth>
			}
			{
			for $AGE in $responseData/*:Edad
			return
			<ns1:Age>{ xs:int(data($AGE)) }</ns1:Age>
			}
			{
			for $TYPE in $responseData/*:TipoCliente
			return
			<ns1:Type>{ data($TYPE) }</ns1:Type>
			}
			{
			for $GENDER in $responseData/*:Genero
			return
			<ns1:Gender>{ data($GENDER) }</ns1:Gender>
			}

				{
					for $ExchangeFactor in $responseData/*:TipoCambio
					return
					<ns1:ExchangeFactor>{ data($ExchangeFactor) }</ns1:ExchangeFactor>
				}
				{
					for $CustomerCode in $responseData/*:CodigoTipoCliente
					return
					<ns1:CustomerCode>{ data($CustomerCode) }</ns1:CustomerCode>
				}
				{
					for $ExternalScore in $responseData/*:ScoreBuro
					return
					<ns1:ExternalScore>{ data($ExternalScore) }</ns1:ExternalScore>
				}
                                {
                                    if(fn:exists($responseData/REFERENCIASTUCA/CUENTA)) then (
                                        let $EvaluationNumberTuca := $responseData/REFERENCIASTUCA/CUENTA[1]/@NumeroEvaluacionTuca
                                        return
                                        if(fn:data($EvaluationNumberTuca) != "") then (
                                            <ns1:EvaluationNumberTuca>{ data($EvaluationNumberTuca) }</ns1:EvaluationNumberTuca>
                                        ) else ()
                                    ) else ()
                                }
			{
                            if(fn:exists($responseData/REFERENCIASSIRC/CUENTA)) then (
                                let $EvaluationNumberSirc := $responseData/REFERENCIASSIRC/CUENTA[1]/@NumeroEvaluacionSirc
                                return
                                if(fn:data($EvaluationNumberSirc) != "") then (
                                    <ns1:EvaluationNumberSirc>{ data($EvaluationNumberSirc) }</ns1:EvaluationNumberSirc>
                                ) else ()
                            ) else ()
			}
			{
			if(count($responseData/*:PASIVOS/*:CUENTA) > 0) then (
			<ns1:Assets>
				{
				for $asset in $responseData/*:PASIVOS/*:CUENTA
				return(
				<ns1:Asset>
					<ns1:Number>{ data($asset/@NUMEROCUENTA) }</ns1:Number>
					<ns1:Category>{ data($asset/@CATEGORIA) }</ns1:Category>
					<ns1:Currency>{ data($asset/@MONEDA) }</ns1:Currency>
					<ns1:OpeningDate>{ fn-bea:date-from-string-with-format("yyyy-MM-dd",data($asset/@FECHAAPERTURA)) }</ns1:OpeningDate>
					<ns1:CurrentBalance>{ data($asset/@SALDOACTUAL) }</ns1:CurrentBalance>
					<ns1:EndOfMonthBalance>{ data($asset/@SALDOFINMES) }</ns1:EndOfMonthBalance>
					<ns1:AverageBalance>{ data($asset/@SALDOPROMEDIO) }</ns1:AverageBalance>
					{
					if($responseData/*:TRANSACCIONESPASIVOS/*:CUENTA/@Cuenta = $asset/@NUMEROCUENTA) then (
					<ns1:ProductTransactions>
						{
						for $transaction in $responseData/*:TRANSACCIONESPASIVOS/*:CUENTA[@Cuenta = $asset/@NUMEROCUENTA]
						return(
						<ns1:Transaction>
							<ns1:PeriodDate>{ fn-bea:dateTime-from-string-with-format("yyyy-MM-dd",data($transaction/@FECHAFINDEPERIODO)) }</ns1:PeriodDate>
							<ns1:PeriodBalance>{ data($transaction/@SALDOFIN) }</ns1:PeriodBalance>
							<ns1:MaxBalance>{ data($transaction/@SALDOMAX) }</ns1:MaxBalance>
							<ns1:MinBalance>{ data($transaction/@SALDOMIN) }</ns1:MinBalance>
							<ns1:AverageBalance>{ data($transaction/@SALDOPROMEDIO) }</ns1:AverageBalance>
							<ns1:LastCreditDate>{ data($transaction/@FECHAULTIMOCREDITO) }</ns1:LastCreditDate>
							<ns1:LastDebitDate>{ data($transaction/@FECHAULTIMODEBITO) }</ns1:LastDebitDate>
							<ns1:Facilities>{ data($transaction/@FLAGFACILIDADESCUENTA) }</ns1:Facilities>
							<ns1:LegalRepresentative>{ data($transaction/@FLAGREPRESENTANTELEGAL) }</ns1:LegalRepresentative>
							<ns1:PayrollAccount>{ data($transaction/@FLAGCUENTAPLANILLA) }</ns1:PayrollAccount>
							<ns1:PayrollCreditAmount>{ data($transaction/@MONTOACREDITADOPLANILLA) }</ns1:PayrollCreditAmount>
							<ns1:JointAccounts>{ data($transaction/@FLAGCUENTAMANCOMUNADA) }</ns1:JointAccounts>
							<ns1:ProductBlock>{ data($transaction/@FLAGBLOQUEOCUENTA) }</ns1:ProductBlock>
							<ns1:CreditsInfo>
								<ns1:AmountOnPeriod>{ data($transaction/@MONTOCREDITOS) }</ns1:AmountOnPeriod>
								<ns1:Summation>{ data($transaction/@NUMEROCREDITOS) }</ns1:Summation>
								<ns1:InterestOnPeriod>{ data($transaction/@NUMEROINTERESESCREDITOS) }</ns1:InterestOnPeriod>
								<ns1:InterestsSummation>{ data($transaction/@MONTOINTERESESCREDITOS) }</ns1:InterestsSummation>
							</ns1:CreditsInfo>
							<ns1:DebitsInfo>
								<ns1:AmountOnPeriod>{ data($transaction/@MONTODEBITOS) }</ns1:AmountOnPeriod>
								<ns1:Summation>{ data($transaction/@NUMERODEBITOS) }</ns1:Summation>
								<ns1:InterestOnPeriod>{ data($transaction/@NUMEROINTERESESDEBITOS) }</ns1:InterestOnPeriod>
								<ns1:InterestsSummation>{ data($transaction/@MONTOINTERESESDEBITOS) }</ns1:InterestsSummation>
							</ns1:DebitsInfo>
						</ns1:Transaction>
						)
						}
					</ns1:ProductTransactions>
					)else ()
					}
				</ns1:Asset>
				)
				}
			</ns1:Assets>
			) else()
			}                        
			<ns1:Liabilities>
				<ns1:Liability>
				{
				if(count($responseData/*:TARJETAS/*:CUENTA) > 0) then (
				<ns1:CreditCardsInfo>
					{
					for $card in $responseData/*:TARJETAS/*:CUENTA
					return(
					<ns1:CreditCard>
						<ns1:Account>{ data($card/@NumeroCuenta) }</ns1:Account>
                                                {
                                                    for $QualificationScore in $card/@CalificacionScore
                                                    return
                                                    <ns1:QualificationScore>{ data($QualificationScore) }</ns1:QualificationScore>
                                                }
                                                {
                                                    for $QualificationCustomerScore in $card/@CalificacionScoreCliente
                                                    return
                                                    <ns1:QualificationCustomerScore>{ data($QualificationCustomerScore) }</ns1:QualificationCustomerScore>
                                                }
						<ns1:Status>{data($card/@Estado) }</ns1:Status>
						<ns1:OpeningDate>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", data($card/@FechaApertura)) }</ns1:OpeningDate>
						<ns1:LastWithdrawalDate>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", data($card/@FechaUltimoAdelanto)) }</ns1:LastWithdrawalDate>
						<ns1:CurrentDue>{ data($card/@MoraActual) }</ns1:CurrentDue>                                      
						<ns1:CurrentBalance>{ data($card/@SaldoActual) }</ns1:CurrentBalance>
						<ns1:ClosingBalance>{ data($card/@SaldoCorte) }</ns1:ClosingBalance>
                                                {
                                                    for $Logo in $card/@Logo
                                                    return
                                                    <ns1:Logo>{ data($Logo) }</ns1:Logo>
                                                }
						<ns1:LockDate1>{ xs:string(data($card/@FechaBloqueo1)) }</ns1:LockDate1>
						<ns1:LockDate2>{ xs:string(data($card/@FechaBloqueo2)) }</ns1:LockDate2>
                        <ns1:LastPurchaseDate>{ data($card/@FechaUltimoConsumo) }</ns1:LastPurchaseDate>
                        <ns1:LastPaymentDate>{ data($card/@FechaUltimoPago) }</ns1:LastPaymentDate>
                        <ns1:CurrentLimit>{ data($card/@Limite) }</ns1:CurrentLimit>
                        <ns1:MiscUser3>{ data($card/@MiscUser3) }</ns1:MiscUser3>
                        <ns1:AvailableCash>{ data($card/@DiponibleCompras) }</ns1:AvailableCash>
                        <ns1:TotalBalance>{ data($card/@SaldoTotal) }</ns1:TotalBalance>
                        <ns1:Pmt29Days>{ data($card/@MorosidadVida29) }</ns1:Pmt29Days>
                        <ns1:Pmt30Days>{ data($card/@MorosidadVida30) }</ns1:Pmt30Days>
                        <ns1:Pmt60Days>{ data($card/@MorosidadVida60) }</ns1:Pmt60Days>
                        <ns1:Pmt90Days>{ data($card/@MorosidadVida90) }</ns1:Pmt90Days>
                        <ns1:Pmt120Days>{ data($card/@MorosidadVida120) }</ns1:Pmt120Days>
                        <ns1:Pmt150Days>{ data($card/@MorosidadVida150) }</ns1:Pmt150Days>
                        <ns1:Pmt180Days>{ data($card/@MorosidadVida180) }</ns1:Pmt180Days>
                        <ns1:Pmt210Days>{ data($card/@MorosidadVida210) }</ns1:Pmt210Days>

						<!-- CAMPO FALTANTE INICIO -->
							<ns1:PilTurboRate>{ data($card/@TasaPilTurbo) }</ns1:PilTurboRate>
							<ns1:ExtraRate>{ data($card/@TasaExtra) }</ns1:ExtraRate>
							<ns1:StateIssue>{ data($card/@StateIssue) }</ns1:StateIssue>
							<ns1:ChargeOffBalance>{ data($card/@SaldoSaneado) }</ns1:ChargeOffBalance>
							<ns1:ResolutionPilTurbo>{ data($card/@RechazosPilTurbo) }</ns1:ResolutionPilTurbo>
							<ns1:ResolutionTc>{ data($card/@Rechazos) }</ns1:ResolutionTc>
							<ns1:Org>{ data($card/@Org) }</ns1:Org>
							<ns1:SecondAccountOffer>{ data($card/@OfertaSegundaCuenta) }</ns1:SecondAccountOffer>
							<ns1:PilTurboOffer>{ data($card/@OfertaPilTurbo) }</ns1:PilTurboOffer>
							<ns1:ExtraOffer>{ data($card/@OfertaExtra) }</ns1:ExtraOffer>
							<ns1:PriorLimit>{ data($card/@LimitePrevio) }</ns1:PriorLimit>
							<ns1:LastLimitDate>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", data($card/@FechaUltimoLimite)) }</ns1:LastLimitDate>
							<ns1:ChargeOffDate>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", data($card/@FechaSaneado)) }</ns1:ChargeOffDate>
							<ns1:MaxPaymentDate>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", data($card/@FechaMaximaPago)) }</ns1:MaxPaymentDate>
							<ns1:LimitDate>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", data($card/@FechaLimite)) }</ns1:LimitDate>
							<ns1:ChargeOffStatus>{ data($card/@EstadoSaneado) }</ns1:ChargeOffStatus>
                                                        <ns1:LockCode1>{ data($card/@CodBloqueo1) }</ns1:LockCode1>
							<ns1:LockCode2>{ data($card/@CodBloqueo2) }</ns1:LockCode2>
							<ns1:ChargeOffCash>{ data($card/@CashsSaneado) }</ns1:ChargeOffCash>
							<ns1:PlasticBlockCode>{ data($card/@BloqueoPlastico) }</ns1:PlasticBlockCode>
							<ns1:BehaviorScore>{ data($card/@BehaviorScore) }</ns1:BehaviorScore>
						<!-- CAMPO FALTANTE FIN -->

						{
						if($responseData/*:TRANSACCIONESTARJETA/*:CUENTA/@NumeroCuenta = $card/@NumeroCuenta) then (
						<ns1:ProductTransactions>
							{
							for $transaction in $responseData/*:TRANSACCIONESTARJETA/*:CUENTA[@NumeroCuenta = $card/@NumeroCuenta]
							return(
							<ns1:Transaction>
								<ns1:Org>{ data($transaction/@Org) }</ns1:Org>
								<ns1:Account>{ data($transaction/@NumeroCuenta) }</ns1:Account>
								<ns1:ExchangeFactor>{ data($transaction/@TipoCambio) }</ns1:ExchangeFactor>
								<ns1:Payments>{ data($transaction/@FechaCorte1) }</ns1:Payments>
								<ns1:MerchSales>{ data($transaction/@CONSUMOS_1) }</ns1:MerchSales>
								<ns1:CashWithDrawal>{ data($transaction/@RETIROS_1) }</ns1:CashWithDrawal>
								<ns1:Limit>{ data($transaction/@LimitE_1) }</ns1:Limit>
								<ns1:OtherTransactions>{ data($transaction/@OTRASTRANSACCIONES_1) }</ns1:OtherTransactions>
								<ns1:Interest>{ data($transaction/@INTERESES_1) }</ns1:Interest>
								<ns1:TotalFees>{ data($transaction/@TOTALCARGOS_1) }</ns1:TotalFees>
								<ns1:OtherDebits>{ data($transaction/@OTROSDEBITOS_1) }</ns1:OtherDebits>
								<ns1:CycleDue>{ data($transaction/@MORA_1) }</ns1:CycleDue>
								<ns1:CycleTotalBalance>{ data($transaction/@SALDOTOTAL_1) }</ns1:CycleTotalBalance>
								<ns1:ExtraCashInfo>
									<ns1:Balance>{ data($transaction/@SALDOEXTRA_1) }</ns1:Balance>
									<ns1:Installment>{ data($transaction/@CUOTAEXTRA_1) }</ns1:Installment>
									<ns1:Interest>{ data($transaction/@INTERESESEXTRA_1) }</ns1:Interest>
									<ns1:Fee>{ data($transaction/@CARGOSINTRA_1) }</ns1:Fee>
								</ns1:ExtraCashInfo>
								<ns1:IntraCashInfo>
									<ns1:Balance>{ data($transaction/@SALDOINTRA_1) }</ns1:Balance>
									<ns1:Installment>{ data($transaction/@CUOTAINTRA_1) }</ns1:Installment>
									<ns1:Interest>{ data($transaction/@INTERESESINTRA_1) }</ns1:Interest>
									<ns1:Fee>{ data($transaction/@CARGOSINTRA_1) }</ns1:Fee>
								</ns1:IntraCashInfo>
							</ns1:Transaction>
							)
							}
						</ns1:ProductTransactions>
						)else ()
						}
						{
						if($responseData/*:PLANES/*:CUENTA/@NumeroCuenta = $card/@NumeroCuenta) then (
                                                    for $transaction in $responseData/*:PLANES/*:CUENTA[@NumeroCuenta = $card/@NumeroCuenta]
                                                    return(
                                                        <ns1:CreditPlans>
                                                          <ns1:Org>{ data($transaction/@Org) }</ns1:Org>
                                                          <ns1:Account>{ data($transaction/@NumeroCuenta) }</ns1:Account>
                                                          <ns1:Logo>{ data($transaction/@Logo) }</ns1:Logo>
                                                          <ns1:PlanNumber>{ data($transaction/@NumPlan) }</ns1:PlanNumber>
                                                          <ns1:PlanDate>{ data($transaction/@FecPlan) }</ns1:PlanDate>
                                                          <ns1:PlanType>{ data($transaction/@TipoPlan) }</ns1:PlanType>
                                                          <ns1:PlanIndicador>{ data($transaction/@LoanPlanId) }</ns1:PlanIndicador>
                                                          <ns1:InitialBalance>{ data($transaction/@BalaceInicial) }</ns1:InitialBalance>
                                                          <ns1:ActualBalance>{ data($transaction/@BalancePrin) }</ns1:ActualBalance>
                                                          <ns1:CurrentBalance>{ data($transaction/@BalanceActual) }</ns1:CurrentBalance>
                                                          <ns1:PlanRate>{ data($transaction/@IntRate) }</ns1:PlanRate>
                                                          <ns1:Insurance>{ data($transaction/@InsBnp) }</ns1:Insurance>
                                                          <!-- CAMPO FALTANTE  INICIO -->
                                                          <ns1:Interest>{ data($transaction/@IntBnp) }</ns1:Interest>
                                                          <!-- CAMPO FALTANTE  FIN -->
                                                          <ns1:User2Bnp>{ data($transaction/@User2Bnp) }</ns1:User2Bnp>
                                                          <ns1:User5Bnp>{ data($transaction/@User5Bnp) }</ns1:User5Bnp>
                                                          <ns1:User1Bnp>{ data($transaction/@User1Bnp) }</ns1:User1Bnp>
                                                          <ns1:ServiceCharges>{ data($transaction/@SvcBnp) }</ns1:ServiceCharges>
                                                          <ns1:LateChargeBnp>{ data($transaction/@LatechgBnp) }</ns1:LateChargeBnp>
                                                          <ns1:AnualFees>{ data($transaction/@MemberBnp) }</ns1:AnualFees>
                                                          <ns1:OverlimitFees>{ data($transaction/@OvlmBnp) }</ns1:OverlimitFees>
                                                          <ns1:RecoveryFees>{ data($transaction/@RecvBnp) }</ns1:RecoveryFees>
                                                          <ns1:CollectionFees>{ data($transaction/@CollBnp) }</ns1:CollectionFees>
                                                          <ns1:NsfFees>{ data($transaction/@NsfBnp) }</ns1:NsfFees>
                                                          <ns1:User3Bnp>{ data($transaction/@User3Bnp) }</ns1:User3Bnp>
                                                          <ns1:User4Bnp>{ data($transaction/@User4Bnp) }</ns1:User4Bnp>
                                                          <ns1:User6Bnp>{ data($transaction/@User6Bnp) }</ns1:User6Bnp>
                                                          <ns1:PlanInstallment>{ data($transaction/@FxdpmtAmt) }</ns1:PlanInstallment>
                                                          <ns1:PlanStatus>{ data($transaction/@PlanStatus) }</ns1:PlanStatus>
                                                          <ns1:ChangeFactor>{ data($transaction/@TipoCambio) }</ns1:ChangeFactor>
                                                        </ns1:CreditPlans>
                                                    )
						)else ()
						}                                                
						{
						if($responseData/*:GESTIONES/*:CUENTA/@Identidad > 0) then (
                                                    for $transaction in $responseData/*:GESTIONES/*:CUENTA[@Identidad = $card/@Identidad]
                                                    return(
                                                        <ns1:Negotiations>
                                                            <ns1:Account>{ data($transaction/@NumeroCuenta) }</ns1:Account>
                                                            <ns1:NegotiationNumber>{ data($transaction/@NumeroGestion) }</ns1:NegotiationNumber>
                                                            <ns1:NegotiationFlow>{ data($transaction/@Flujo) }</ns1:NegotiationFlow>
                                                            <ns1:NegotiationName>{ data($transaction/@NombreGestion) }</ns1:NegotiationName>
                                                            <ns1:NegotiationReason>{ data($transaction/@MotivoGestion) }</ns1:NegotiationReason>
                                                            <ns1:NegotiationStage>{ data($transaction/@Etapa) }</ns1:NegotiationStage>
                                                            <ns1:NegotiationStatus>{ data($transaction/@EstadoGestion) }</ns1:NegotiationStatus>
                                                            <ns1:NegotiationDate>{ data($transaction/@FechaGestion) }</ns1:NegotiationDate>
                                                            <ns1:NegotiationEndDate>{ data($transaction/@FechaFinalizacion) }</ns1:NegotiationEndDate>
                                                            <ns1:NegotiationActualLogo>{ data($transaction/@LogoActual) }</ns1:NegotiationActualLogo>
							</ns1:Negotiations>
                                                    )
						)else ()
						}                                                 
					</ns1:CreditCard>
					)
					}
				</ns1:CreditCardsInfo>
				) else ()
				}
				{
				if(count($responseData/*:PRESTAMOS/*:CUENTA) > 0) then (
				<ns1:LoansInfo>
					{
					for $prestamos in $responseData/*:PRESTAMOS/*:CUENTA
					return(
					<ns1:Loan>
						<ns1:Number>{ data($prestamos/@NumeroPrestamo) }</ns1:Number>
							<ns1:Account>{ data($prestamos/@NumeroCuenta) }</ns1:Account>
							<ns1:Code1>{ data($prestamos/@Codigo1) }</ns1:Code1>
							<ns1:Code2>{ data($prestamos/@Codigo2) }</ns1:Code2>
						<ns1:AgencyCode>{ data($prestamos/@CodigoAgencia) }</ns1:AgencyCode>
						<ns1:SubApplicaton>{ data($prestamos/@CodigoSubAplicacion) }</ns1:SubApplicaton>
						<ns1:OpeningDate>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", data($prestamos/@FechaApertura)) }</ns1:OpeningDate>
						{
						if(data($prestamos/@FechaCancelacion) != "") then(
						<ns1:CancelationDate>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", data($prestamos/@FechaCancelacion)) }</ns1:CancelationDate>
						)else ()
						}
						<ns1:InitialAmount>{ data($prestamos/@MontoInicial) }</ns1:InitialAmount>
						<ns1:CurrentBalance>{ data($prestamos/@SaldoActual) }</ns1:CurrentBalance>
						<ns1:PaymentAmount>{ data($prestamos/@ValorCuota) }</ns1:PaymentAmount>
						<ns1:Rate>{ data($prestamos/@Tasa) }</ns1:Rate>
						<ns1:Term>{ data($prestamos/@Plazo) }</ns1:Term>
						<ns1:PaymentNumber>{ data($prestamos/@NumeroCuotas) }</ns1:PaymentNumber>
						<ns1:FirstCapitalPaymentDate>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", data($prestamos/@FechaPrimerPagoCapital)) }</ns1:FirstCapitalPaymentDate>
						<ns1:LastPaymentDate>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", data($prestamos/@FechaUltimoPago)) }</ns1:LastPaymentDate>
						<ns1:PaidPayments>{ data($prestamos/@CantidadCuotasPagadas) }</ns1:PaidPayments>
						<ns1:CapitalFrequency>{ data($prestamos/@FrecuenciaCapital) }</ns1:CapitalFrequency>
						<ns1:DestinationCode>{ data($prestamos/@CodigoDestino) }</ns1:DestinationCode>
						<ns1:MonthlyPrime>{ data($prestamos/@PrimaMensual) }</ns1:MonthlyPrime>
                                                <ns1:GuaranteeType>{ data($prestamos/@Codigotipogarantia) }</ns1:GuaranteeType>
						<ns1:ContractNumber>{ xs:int(data($prestamos/@Numerocontrato)) }</ns1:ContractNumber>
						<ns1:Charges>{ data($prestamos/@Cargos) }</ns1:Charges>
						<ns1:Interest>{ data($prestamos/@Interes) }</ns1:Interest>
						<ns1:Insurance>{ data($prestamos/@Seguros) }</ns1:Insurance>
						<ns1:OtherCharges>{ data($prestamos/@OtrosCargos) }</ns1:OtherCharges>
						<ns1:CurrentDue>{ data($prestamos/@MoraActual) }</ns1:CurrentDue>
						<ns1:DebtorType>{ data($prestamos/@TipoDeudor) }</ns1:DebtorType>
						<ns1:CodeType>{ data($prestamos/@Codigotipoprestamo) }</ns1:CodeType>
						
						{
						if(data($prestamos/@Identidad) > 0)then (
						<ns1:ProductTransactions>
							{
							for $transaccionesPrestamo in $responseData/*:TRANSACCIONESPRESTAMO/*:CUENTA
							return(
							<ns1:Transaction>
								<ns1:PeriodDate></ns1:PeriodDate>
								<ns1:PeriodBalance>{ data($transaccionesPrestamo/@FECHACIERRE_1) }</ns1:PeriodBalance>
								<ns1:CapitalBalance>{ data($transaccionesPrestamo/@SALDOCAPITAL_1) }</ns1:CapitalBalance>
								<ns1:DueBalance></ns1:DueBalance>
								<ns1:Charges>{ data($transaccionesPrestamo/@CARGOS_1) }</ns1:Charges>
								<ns1:Interest>{ data($transaccionesPrestamo/@INTERESES_1) }</ns1:Interest>
								<ns1:Payment>{ data($transaccionesPrestamo/@PAGOS_1) }</ns1:Payment>
								<ns1:Insurance>{ data($transaccionesPrestamo/@SEGUROS_1) }</ns1:Insurance>
								<ns1:OtherCharges>{ data($transaccionesPrestamo/@OTROSCARGOS_1) }</ns1:OtherCharges>
								<ns1:CycleDue></ns1:CycleDue>
							</ns1:Transaction>
							)
							}
						</ns1:ProductTransactions>
						)else()
						}
					</ns1:Loan>
					)
					}
				</ns1:LoansInfo>
				) else ()
				}                                
				</ns1:Liability>
			</ns1:Liabilities>
			{
			if(count($responseData/*:PASIVOS/*:CUENTA) > 0) then (
			<ns1:PreApprovedOffers>
				{
				for $asset in $responseData/*:PASIVOS/*:CUENTA
				return(
				<ns1:Offer>
					<ns1:ProductCode>{ data($asset/@NUMEROCUENTA) }</ns1:ProductCode>
					<ns1:Resolution>{ data($asset/@CATEGORIA) }</ns1:Resolution>
					<ns1:Rate>{ data($asset/@MONEDA) }</ns1:Rate>
					<ns1:Installment>{ fn-bea:date-from-string-with-format("yyyy-MM-dd",data($asset/@FECHAAPERTURA)) }</ns1:Installment>
					<ns1:MinimumTerm>{ data($asset/@SALDOACTUAL) }</ns1:MinimumTerm>
					<ns1:MaximumTerm>{ data($asset/@SALDOFINMES) }</ns1:MaximumTerm>
					<ns1:MaxOffer>{ data($asset/@SALDOPROMEDIO) }</ns1:MaxOffer>
					<ns1:MaxLimit>{ data($asset/@SALDOFINMES) }</ns1:MaxLimit>
					<ns1:Flag>{ data($asset/@SALDOPROMEDIO) }</ns1:Flag>
				</ns1:Offer>
				)
				}
			</ns1:PreApprovedOffers>
			) else()
			}                                                
		</ns1:CustomerInfo>
	</ns1:LoanMaintenance>
	<ns1:LoanOriginations>
		<ns1:ReferencesDetails>
			{
			if(fn:exists($responseData/CONSULTATUCA/CUENTA)) then (
			<ns1:Queries>
				{
				for $recordc in $responseData/CONSULTATUCA/CUENTA
				return(
				<ns1:QueryItem>
					{
                                            for $Date in $recordc/@FechaConsulta
                                            return
                                            <ns1:Date>{ fn-bea:dateTime-to-string-with-format("yyyy-MM-dd", xs:dateTime(fn:data($Date))) }</ns1:Date>
                                        }
                                        {
                                            for $Motive in $recordc/@Motivo
                                            return
                                            <ns1:Motive>{ data($Motive) }</ns1:Motive>
                                        }
                                        {
                                            for $QueryType in $recordc/@TipoConsulta
                                            return
                                            <ns1:QueryType>{ data($QueryType) }</ns1:QueryType>
                                        }
				</ns1:QueryItem>
				)
				}
			</ns1:Queries>
			)else ()
			}
                        {
                            if(fn:exists($responseData/REFERENCIASTUCA/CUENTA)) then (
                                <ns1:ReferenceBureauTuca>
                                {
                                    for $recordb in $responseData/REFERENCIASTUCA/CUENTA
                                    return(
                                        <ns1:Reference>
					{
					if(data($recordb/@NumeroEvaluacionTuca) != "") then (
					<ns1:QueryId>{ data($recordb/@NumeroEvaluacionTuca) }</ns1:QueryId>
					) else ()
					}
					<ns1:Creditor>{ data($recordb/@Entidad) }</ns1:Creditor>
					<ns1:ReferenceNumber>{ data($recordb/@IDEvaluacion) }</ns1:ReferenceNumber>
					<ns1:Type>{ data($recordb/@TipoReferencia) }</ns1:Type>
					<ns1:ObligationType>{ data($recordb/@TipoObligacion) }</ns1:ObligationType>
					<ns1:CreditType>{ data($recordb/@TipoActivo) }</ns1:CreditType>
					<ns1:Status>{ data($recordb/@Estatus) }</ns1:Status>
					<ns1:Limit>{fn:data($recordb/@LimiteCredito) }</ns1:Limit>
					<ns1:Currency>{ data($recordb/@Moneda) }</ns1:Currency>
					<ns1:Balance>{ data($recordb/@SaldoActual) }</ns1:Balance>
					<ns1:PaymentMethod>{ data($recordb/@PeriodoPago) }</ns1:PaymentMethod>
					<ns1:ObligationCode>{ data($recordb/@CodigoObligacion) }</ns1:ObligationCode>
					<ns1:GuaranteeType>{ data($recordb/@TipoGarantia) }</ns1:GuaranteeType>
					<ns1:ArrearBalance>{ data($recordb/@SaldoMora) }</ns1:ArrearBalance>
					<ns1:ObligationSector>{ data($recordb/@SectorObligacion) }</ns1:ObligationSector>
					<ns1:DueBalance>{ data($recordb/@SaldoVencido) }</ns1:DueBalance>
					<ns1:InExecution>{ data($recordb/@SaldoCobroJudicial) }</ns1:InExecution>
					<ns1:PunishedBalance>{ data($recordb/@SaldoCastigado) }</ns1:PunishedBalance>
					<ns1:Period>{ data($recordb/@periodoInfo) }</ns1:Period>
                                        <ns1:Installment>{ fn:data($recordb/@cuota) }</ns1:Installment>
                                        <ns1:LastMovementMonth>{ data($recordb/@UltMovMes) }</ns1:LastMovementMonth>
                                        <ns1:LastMovementYear>{ data($recordb/@UltMovAnio) }</ns1:LastMovementYear>
                                        <ns1:CreditStatus>{ data($recordb/@EstadoCredito) }</ns1:CreditStatus>
					<ns1:OpeningDate>{ data($recordb/@FechaApertura) }</ns1:OpeningDate>
					

					<ns1:CancelationDate>{ data($recordb/@FechaVencimiento) }</ns1:CancelationDate>


					<ns1:InformationDate>{ data($recordb/@FechaActualizacion) }</ns1:InformationDate>
					
					<ns1:Category>{ data($recordb/@Calificacion) }</ns1:Category>
					{
                                            for $HistoricalArrear in $recordb/@HistoricalArrear
                                            return
                                            <ns1:HistoricalArrear>{ fn:data($HistoricalArrear) }</ns1:HistoricalArrear>
					}
                                        {
                                            for $ExternalScore in $recordb/@ExternalScore
                                            return
                                            <ns1:ExternalScore>{ fn:data($ExternalScore) }</ns1:ExternalScore>
                                        }
				</ns1:Reference>
                                    )
                                }
                                </ns1:ReferenceBureauTuca>
                            ) else ()
                        }
                        {
                            if(fn:exists($responseData/REFERENCIASSIRC/CUENTA)) then (
                                <ns1:ReferenceBureauSirc>
                                {
                                    for $recordprb in $responseData/REFERENCIASSIRC/CUENTA
                                    return(
                                        <ns1:Reference>
					{
					if(data($recordprb/@NumeroEvaluacionSirc) != "") then (
					<ns1:QueryId>{ data($recordprb/@NumeroEvaluacionSirc) }</ns1:QueryId>
					)else ()
					}
					<ns1:Creditor>{ data($recordprb/@Entidad) }</ns1:Creditor>
					<ns1:ReferenceNumber>{ data($recordprb/@noReferencia) }</ns1:ReferenceNumber>
					<ns1:Type>{ data($recordprb/@TipoReferencia) }</ns1:Type>
					<ns1:Amount>{ data($recordprb/@CapitalOriginal) }</ns1:Amount>
					<ns1:Status>{ data($recordprb/@EstadoCredito) }</ns1:Status>
					<ns1:AssetType>{data($recordprb/@TipoActivo) }</ns1:AssetType>
					<ns1:Currency>{ data($recordprb/@Moneda) }</ns1:Currency>
					<ns1:Balance>{ data($recordprb/@SaldoCapital) }</ns1:Balance>
					<ns1:DueBalance>{ data($recordprb/@Vencido) }</ns1:DueBalance>
					<ns1:WarrantyType>{ data($recordprb/@TipoGarantia) }</ns1:WarrantyType>
					<ns1:ConsessionDate>{ data($recordprb/@FechaConcesion) }</ns1:ConsessionDate>
					<ns1:HistoricalArrear>{ data($recordprb/@Comportamiento) }</ns1:HistoricalArrear>
					<ns1:Category>{ data($recordprb/@Categoria) }</ns1:Category>
					<ns1:Period>{ data($recordprb/@periodoInfo) }</ns1:Period>
					<ns1:OpeningDate>{ data($recordprb/@FechaActivo) }</ns1:OpeningDate>

					<ns1:CancelationDate>{ data($recordprb/@FechaCancelacion) }</ns1:CancelationDate>



					<ns1:ExpirationDate>{ data($recordprb/@FechaVencimiento) }</ns1:ExpirationDate>

                                    </ns1:Reference>
                                    )
                                }
                                </ns1:ReferenceBureauSirc>
                            ) else ()
                        }
		</ns1:ReferencesDetails>
	</ns1:LoanOriginations>        
   </ns1:GetConsolidatedCustomerRisk>        
        
    </ns1:getConsolidatedCustomerRiskResponse>
};

local:Tx_consulta_ONBASE_V2_To_GetConsolidatedCustomerRiskGTResponse($responseData, $uuid)