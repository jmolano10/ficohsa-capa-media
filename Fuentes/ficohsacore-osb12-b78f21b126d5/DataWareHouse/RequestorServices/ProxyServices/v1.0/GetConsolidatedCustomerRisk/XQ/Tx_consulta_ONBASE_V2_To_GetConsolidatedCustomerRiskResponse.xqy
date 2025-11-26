xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/creditManagement";
(:: import schema at "../../../../../../MWBanking/CreditManagement/RequestorServices/XSD/creditManagement.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCustomerRisk_BS";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerRisk/v1.0/GetCustomerRisk_BS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $responseData as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare function xq:Tx_consulta_ONBASE_V2_To_GetConsolidatedCustomerRiskResponse($responseData as element(*),$uuid as xs:string) as element() (:: schema-element(ns2:getConsolidatedCustomerRiskResponse) ::) {
    <ns2:getConsolidatedCustomerRiskResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
        <ns2:GetConsolidatedCustomerRisk>
	<ns2:LoanMaintenance>
		<ns2:CustomerInfo>
			{
			for $IDENTIDAD in $responseData/*:IDENTIDAD
			return
			<ns2:Id>{ data($IDENTIDAD) }</ns2:Id>
			}
			{
			for $TARGET in $responseData/*:SEGMENTOCLIENTE
			return
			<ns2:Target>{ data($TARGET) }</ns2:Target>
			}
			{
			for $DATE_OF_BIRTH in $responseData/*:FECHANACIMIENTO
			return
			<ns2:DateOfBirth>{ fn-bea:date-from-string-with-format("yyyy-MM-dd",data($DATE_OF_BIRTH)) }</ns2:DateOfBirth>
			}
			{
			for $AGE in $responseData/*:EDAD
			return
			<ns2:Age>{ xs:int(data($AGE)) }</ns2:Age>
			}
			{
			for $TYPE in $responseData/*:TIPOCLIENTE
			return
			<ns2:Type>{ data($TYPE) }</ns2:Type>
			}
			{
			for $SALARY in $responseData/*:SALARIOCLIENTE
			return
			<ns2:Salary>{ data($SALARY) }</ns2:Salary>
			}
			{
			for $PAYROLL_SALARY in $responseData/*:MONTOLPSPLANILLA
			return
			<ns2:PayRollSalary>{ data($PAYROLL_SALARY) }</ns2:PayRollSalary>
			}
			{
			for $CREDIT_MONTHS in $responseData/*:MESPLANILLA
			return
			<ns2:CreditMonths>{ data($CREDIT_MONTHS) }</ns2:CreditMonths>
			}
			{
			for $FLAG_BLAZE in $responseData/*:FLAGBLAZE
			return
			<ns2:FlagBlaze>{ data($FLAG_BLAZE) }</ns2:FlagBlaze>
			}
			{
			for $FLAG_HIT in $responseData/*:FLAGHIT
			return
			<ns2:FlagHit>{ data($FLAG_HIT) }</ns2:FlagHit>
			}
			{
			for $EVALUATION_RESULT in $responseData/*:RECORDEVALUACION/*:CUENTA[1]
			return
			<ns2:EvaluationResult>{ data($EVALUATION_RESULT/@resultadoEvaluacion) }</ns2:EvaluationResult>
			}
			{
			if(count($responseData/*:RECORDA/*:CUENTA) > 0) then (
			<ns2:AddressesInfo>
				{
				for $recorda in $responseData/*:RECORDA/*:CUENTA
				return(
				<ns2:AddressItem>
					<ns2:Period>{ data($recorda/@informationPeriod) }</ns2:Period>
					<ns2:Address>{ fn-bea:trim(data($recorda/@debtorAddress)) }</ns2:Address>
				</ns2:AddressItem>
				)
				}
			</ns2:AddressesInfo>
			)else ()
			}
			{
			if(count($responseData/*:RECORDTEL/*:CUENTA) > 0) then (
			<ns2:PhonesInfo>
				{
				for $recordtel in $responseData/*:RECORDTEL/*:CUENTA
				return(
				<ns2:PhoneItem>
					<ns2:Period>{ data($recordtel/@periodoInformacion) }</ns2:Period>
					<ns2:Phone>{ fn-bea:trim(data($recordtel/@numeroTelefono)) }</ns2:Phone>
				</ns2:PhoneItem>
				)
				}
			</ns2:PhonesInfo>
			)else ()
			}
			{
			if(count($responseData/*:RECORDH/*:CUENTA) > 0) then (
			<ns2:AdministrativeCharges>
				{
				for $recordh in $responseData/*:RECORDH/*:CUENTA
				return(
				<ns2:Charge>
					<ns2:Id>{ data($recordh/@viewId) }</ns2:Id>
					{
					if(data($recordh/@infoDate) != "00/00/0000")then (
					<ns2:InformationDate>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordh/@infoDate))) }</ns2:InformationDate>
					)else ()
					}
					{
					if(data($recordh/@inDate) != "00/00/0000")then (
					<ns2:InDate>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordh/@inDate))) }</ns2:InDate>
					)else ()
					}
					<ns2:Creditor>{ fn-bea:trim(data($recordh/@creditor)) }</ns2:Creditor>
					<ns2:Motivation>{ fn-bea:trim(data($recordh/@inMotivation)) }</ns2:Motivation>
					<ns2:Currency>{ fn-bea:trim(data($recordh/@currency)) }</ns2:Currency>
					<ns2:TotalDebtAmount>{ xs:decimal(data($recordh/@totalDebtAmount)) }</ns2:TotalDebtAmount>
					<ns2:ExchangeFactor>{ xs:decimal(data($recordh/@changeFactor)) }</ns2:ExchangeFactor>
				</ns2:Charge>
				)
				}
			</ns2:AdministrativeCharges>
			)else ()
			}
			{
			if(count($responseData/*:RECORDS/*:CUENTA) > 0) then (
			<ns2:CurrentArrearSumary>
				{
				for $records in $responseData/*:RECORDS/*:CUENTA
				return(
				<ns2:Arrear>
					<ns2:Id>{ data($records/@viewId) }</ns2:Id>
					{
					if(data($records/@infoDate) != "00/00/0000")then (
					<ns2:InformationDate>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($records/@infoDate))) }</ns2:InformationDate>
					)else ()
					}
					{
					if(data($records/@dwellDate) != "00/00/0000")then (
					<ns2:Date>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($records/@dwellDate))) }</ns2:Date>
					)else ()
					}
					<ns2:Creditor>{ fn-bea:trim(data($records/@creditor)) }</ns2:Creditor>
					<ns2:AccountType>{ fn-bea:trim(data($records/@accountType)) }</ns2:AccountType>
					<ns2:Currency>{ fn-bea:trim(data($records/@currency)) }</ns2:Currency>
					<ns2:Days>{ xs:int(data($records/@dwellDays)) }</ns2:Days>
					<ns2:Amount>{ xs:decimal(data($records/@dwellAmount)) }</ns2:Amount>
					<ns2:ExchangeFactor>{ xs:decimal(data($records/@changeFactor)) }</ns2:ExchangeFactor>
				</ns2:Arrear>
				)
				}
			</ns2:CurrentArrearSumary>
			)else ()
			}
			{
			for $EXTERNAL_SCORE in $responseData/*:EQX_CONTROL/*:CUENTA
			return
			<ns2:ExternalScore>{ data($EXTERNAL_SCORE/@ValorScore) }</ns2:ExternalScore>
			}
			<ns2:ScoreInfo>
				{
				for $SCORE_CALCULATION in $responseData/*:BLAZE_DATA_PTMO/*:CUENTA/@scoreMC
				return
				<ns2:ScoreCalculation>{ xs:float(data($SCORE_CALCULATION)) }</ns2:ScoreCalculation>
				}
				{
				for $QUALIFICATION in $responseData/*:CALIFICACIONSCORE
				return
				<ns2:Qualification>{ data($QUALIFICATION) }</ns2:Qualification>
				}
				{
				for $RISK_LEVEL in $responseData/*:NIVELRIESGO
				return
				<ns2:RiskLevel>{ data($RISK_LEVEL) }</ns2:RiskLevel>
				}
			</ns2:ScoreInfo>
			{
			if(count($responseData/*:PASIVOS/*:CUENTA) > 0) then (
			<ns2:Assets>
				{
				for $asset in $responseData/*:PASIVOS/*:CUENTA
				return(
				<ns2:Asset>
					<ns2:Number>{ data($asset/@NUMEROCUENTA) }</ns2:Number>
					<ns2:Category>{ data($asset/@CATEGORIA) }</ns2:Category>
					<ns2:Currency>{ data($asset/@MONEDA) }</ns2:Currency>
					<ns2:OpeningDate>{ fn-bea:date-from-string-with-format("yyyy-MM-dd",data($asset/@FECHAAPERTURA)) }</ns2:OpeningDate>
					<ns2:CurrentBalance>{ xs:float(data($asset/@SALDOACTUAL)) }</ns2:CurrentBalance>
					<ns2:EndOfMonthBalance>{ xs:float(data($asset/@SALDOFINMES)) }</ns2:EndOfMonthBalance>
					<ns2:AverageBalance>{ xs:float(data($asset/@SALDOPROMEDIO)) }</ns2:AverageBalance>
					{
					if($responseData/*:TRANSACCIONESPASIVOS/*:CUENTA/@Cuenta = $asset/@NUMEROCUENTA) then (
					<ns2:ProductTransactions>
						{
						for $transaction in $responseData/*:TRANSACCIONESPASIVOS/*:CUENTA[@Cuenta = $asset/@NUMEROCUENTA]
						return(
						<ns2:Transaction>
							<ns2:PeriodDate>{ fn-bea:dateTime-from-string-with-format("yyyy-MM-dd",data($transaction/@FECHAFINDEPERIODO)) }</ns2:PeriodDate>
							<ns2:PeriodBalance>{ data($transaction/@SALDOFIN) }</ns2:PeriodBalance>
							<ns2:MaxBalance>{ data($transaction/@SALDOMAX) }</ns2:MaxBalance>
							<ns2:MinBalance>{ data($transaction/@SALDOMIN) }</ns2:MinBalance>
							<ns2:AverageBalance>{ data($transaction/@SALDOPROMEDIO) }</ns2:AverageBalance>
							<ns2:LastCreditDate>{ data($transaction/@FECHAULTIMOCREDITO) }</ns2:LastCreditDate>
							<ns2:LastDebitDate>{ data($transaction/@FECHAULTIMODEBITO) }</ns2:LastDebitDate>
							<ns2:Facilities>{ data($transaction/@FLAGFACILIDADESCUENTA) }</ns2:Facilities>
							<ns2:LegalRepresentative>{ data($transaction/@FLAGREPRESENTANTELEGAL) }</ns2:LegalRepresentative>
							<ns2:PayrollAccount>{ data($transaction/@FLAGCUENTAPLANILLA) }</ns2:PayrollAccount>
							<ns2:PayrollCreditAmount>{ data($transaction/@MONTOACREDITADOPLANILLA) }</ns2:PayrollCreditAmount>
							<ns2:JointAccounts>{ data($transaction/@FLAGCUENTAMANCOMUNADA) }</ns2:JointAccounts>
							<ns2:ProductBlock>{ data($transaction/@FLAGBLOQUEOCUENTA) }</ns2:ProductBlock>
							<ns2:CreditsInfo>
								<ns2:AmountOnPeriod>{ data($transaction/@MONTOCREDITOS) }</ns2:AmountOnPeriod>
								<ns2:Summation>{ data($transaction/@NUMEROCREDITOS) }</ns2:Summation>
								<ns2:InterestOnPeriod>{ data($transaction/@NUMEROINTERESESCREDITOS) }</ns2:InterestOnPeriod>
								<ns2:InterestsSummation>{ data($transaction/@MONTOINTERESESCREDITOS) }</ns2:InterestsSummation>
							</ns2:CreditsInfo>
							<ns2:DebitsInfo>
								<ns2:AmountOnPeriod>{ data($transaction/@MONTODEBITOS) }</ns2:AmountOnPeriod>
								<ns2:Summation>{ data($transaction/@NUMERODEBITOS) }</ns2:Summation>
								<ns2:InterestOnPeriod>{ data($transaction/@NUMEROINTERESESDEBITOS) }</ns2:InterestOnPeriod>
								<ns2:InterestsSummation>{ data($transaction/@MONTOINTERESESDEBITOS) }</ns2:InterestsSummation>
							</ns2:DebitsInfo>
						</ns2:Transaction>
						)
						}
					</ns2:ProductTransactions>
					)else ()
					}
				</ns2:Asset>
				)
				}
			</ns2:Assets>
			) else()
			}
			<ns2:Liabilities>
				<ns2:Liability>
				{
				if(count($responseData/*:TARJETAS/*:CUENTA) > 0) then (
				<ns2:CreditCardsInfo>
					{
					for $card in $responseData/*:TARJETAS/*:CUENTA
					return(
					<ns2:CreditCard>
						<ns2:Account>{ data($card/@NUMEROCUENTA) }</ns2:Account>
						<ns2:BehaviorScore>{ xs:float(data($card/@BEHAVIORSCORE)) }</ns2:BehaviorScore>
						<ns2:QualificationScore>{ xs:string(data($card/@CALIFICACIONSCORE)) }</ns2:QualificationScore>
						<ns2:QualificationCustomerScore>{ xs:string(data($card/@CALIFICACIONSCORECLIENTE)) }</ns2:QualificationCustomerScore>
						<ns2:Status>{data($card/@ESTADO) }</ns2:Status>
						<ns2:AffinityGroup>{ data($card/@GRUPOAFINIDAD) }</ns2:AffinityGroup>
						<ns2:Product>{ data($card/@PRODUCTO) }</ns2:Product>
						<ns2:ClearingModel>{ xs:int(data($card/@MODELOLIQUIDACION)) }</ns2:ClearingModel>
						<ns2:OpeningDate>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", data($card/@FECHAAPERTURA)) }</ns2:OpeningDate>
						<ns2:CancelationDate>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", data($card/@FECHACANCELACION)) }</ns2:CancelationDate>
						<ns2:LastExtraDate>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", data($card/@FECHAULTIMOEXTRA)) }</ns2:LastExtraDate>
						<ns2:CurrentDue>{ xs:int(data($card/@MORAACTUAL)) }</ns2:CurrentDue>
						<ns2:CurrentLimit>{ xs:float(data($card/@LIMITEACTUAL)) }</ns2:CurrentLimit>
						<ns2:CurrentBalance>{ xs:float(data($card/@SALDOACTUAL)) }</ns2:CurrentBalance>
						<ns2:ClosingBalance>{ xs:float(data($card/@SALDOCORTE)) }</ns2:ClosingBalance>
						<ns2:ExtraBalance>{ xs:float(data($card/@SALDOEXTRA)) }</ns2:ExtraBalance>
						<ns2:IntraBalance>{ xs:float(data($card/@SALDOINTRA)) }</ns2:IntraBalance>
						<ns2:ActiveExtraInstallments>{ xs:float(data($card/@CUOTASEXTRAVIGENTES)) }</ns2:ActiveExtraInstallments>
      <ns2:LockCode1>{ data($card/@CODBLOQUE1) }</ns2:LockCode1>
      <ns2:LockCode2>{ data($card/@CODBLOQUE2) }</ns2:LockCode2>
      <ns2:Logo>{ data($card/@GRUPOAFINIDAD) }</ns2:Logo>
      {
      let $disponible := (data($card/@DISPONIBLE_1), data($card/@DISPONIBLE_2), data($card/@DISPONIBLE_3), data($card/@DISPONIBLE_4), data($card/@DISPONIBLE_5), data($card/@DISPONIBLE_6), data($card/@DISPONIBLE_7),
      data($card/@DISPONIBLE_8), data($card/@DISPONIBLE_9), data($card/@DISPONIBLE_10), data($card/@DISPONIBLE_11), data($card/@DISPONIBLE_12) )
      return
      <ns2:AvailableCash>{ sum($disponible) }</ns2:AvailableCash>
      }
      <ns2:LockDate1>{ data($card/@FECBLOQUE1) }</ns2:LockDate1>
      <ns2:LockDate2>{ data($card/@FECBLOQUE2) }</ns2:LockDate2>
      <ns2:Bin>{ data($card/@PRODUCTO) }</ns2:Bin>
      <ns2:ExtraApprovalDate>{ data($card/@FECHA_APROBACION_EXTRA) }</ns2:ExtraApprovalDate>
      <ns2:IntraApprovalDate>{ data($card/@FECHA_APROBACION_EXTRA) }</ns2:IntraApprovalDate>
      <ns2:PilApprovalDate>{ data($card/@FECHA_APROBACION_INTRA) }</ns2:PilApprovalDate>
      <ns2:PriorLimit>{ data($card/@LIMITE_PREVIO) }</ns2:PriorLimit>
      <ns2:AuthBalance>{ data($card/@SALDO_AUTORIZACION) }</ns2:AuthBalance>
      <ns2:ProductTransactions>{ data($card/@SALDO_AUTORIZACION)}</ns2:ProductTransactions>
						{
						if($responseData/*:TRANSACCIONESTARJETA/*:CUENTA/@NUMEROCUENTA = $card/@NUMEROCUENTA) then (
						<ns2:ProductTransactions>
							{
							for $transaction in $responseData/*:TRANSACCIONESTARJETA/*:CUENTA[@NUMEROCUENTA = $card/@NUMEROCUENTA]
							return(
							<ns2:Transaction>
								<ns2:PeriodDate>{ data($transaction/@FECHACORTE_1) }</ns2:PeriodDate>
								<ns2:PeriodBalance>{ data($transaction/@SALDOCORTE_1) }</ns2:PeriodBalance>
								<ns2:AmountDue>{ data($transaction/@PAGOMINIMO_1) }</ns2:AmountDue>
								<ns2:Payments>{ data($transaction/@PAGOS_1) }</ns2:Payments>
								<ns2:MerchSales>{ data($transaction/@CONSUMOS_1) }</ns2:MerchSales>
								<ns2:CashWithDrawal>{ data($transaction/@RETIROS_1) }</ns2:CashWithDrawal>
								<ns2:Limit>{ data($transaction/@LimitE_1) }</ns2:Limit>
								<ns2:OtherTransactions>{ data($transaction/@OTRASTRANSACCIONES_1) }</ns2:OtherTransactions>
								<ns2:Interest>{ data($transaction/@INTERESES_1) }</ns2:Interest>
								<ns2:TotalFees>{ data($transaction/@TOTALCARGOS_1) }</ns2:TotalFees>
								<ns2:OtherDebits>{ data($transaction/@OTROSDEBITOS_1) }</ns2:OtherDebits>
								<ns2:CycleDue>{ data($transaction/@MORA_1) }</ns2:CycleDue>
								<ns2:CycleTotalBalance>{ data($transaction/@SALDOTOTAL_1) }</ns2:CycleTotalBalance>
								<ns2:ExtraCashInfo>
									<ns2:Balance>{ data($transaction/@SALDOEXTRA_1) }</ns2:Balance>
									<ns2:Installment>{ data($transaction/@CUOTAEXTRA_1) }</ns2:Installment>
									<ns2:Interest>{ data($transaction/@INTERESESEXTRA_1) }</ns2:Interest>
									<ns2:Fee>{ data($transaction/@CARGOSINTRA_1) }</ns2:Fee>
								</ns2:ExtraCashInfo>
								<ns2:IntraCashInfo>
									<ns2:Balance>{ data($transaction/@SALDOINTRA_1) }</ns2:Balance>
									<ns2:Installment>{ data($transaction/@CUOTAINTRA_1) }</ns2:Installment>
									<ns2:Interest>{ data($transaction/@INTERESESINTRA_1) }</ns2:Interest>
									<ns2:Fee>{ data($transaction/@CARGOSINTRA_1) }</ns2:Fee>
								</ns2:IntraCashInfo>
							</ns2:Transaction>,
							<ns2:Transaction>
								<ns2:PeriodDate>{ data($transaction/@FECHACORTE_2) }</ns2:PeriodDate>
								<ns2:PeriodBalance>{ data($transaction/@SALDOCORTE_2) }</ns2:PeriodBalance>
								<ns2:AmountDue>{ data($transaction/@PAGOMINIMO_2) }</ns2:AmountDue>
								<ns2:Payments>{ data($transaction/@PAGOS_2) }</ns2:Payments>
								<ns2:MerchSales>{ data($transaction/@CONSUMOS_2) }</ns2:MerchSales>
								<ns2:CashWithDrawal>{ data($transaction/@RETIROS_2) }</ns2:CashWithDrawal>
								<ns2:Limit>{ data($transaction/@LimitE_2) }</ns2:Limit>
								<ns2:OtherTransactions>{ data($transaction/@OTRASTRANSACCIONES_2) }</ns2:OtherTransactions>
								<ns2:Interest>{ data($transaction/@INTERESES_2) }</ns2:Interest>
								<ns2:TotalFees>{ data($transaction/@TOTALCARGOS_2) }</ns2:TotalFees>
								<ns2:OtherDebits>{ data($transaction/@OTROSDEBITOS_2) }</ns2:OtherDebits>
								<ns2:CycleDue>{ data($transaction/@MORA_2) }</ns2:CycleDue>
								<ns2:CycleTotalBalance>{ data($transaction/@SALDOTOTAL_2) }</ns2:CycleTotalBalance>
								<ns2:ExtraCashInfo>
									<ns2:Balance>{ data($transaction/@SALDOEXTRA_2) }</ns2:Balance>
									<ns2:Installment>{ data($transaction/@CUOTAEXTRA_2) }</ns2:Installment>
									<ns2:Interest>{ data($transaction/@INTERESESEXTRA_2) }</ns2:Interest>
									<ns2:Fee>{ data($transaction/@CARGOSINTRA_2) }</ns2:Fee>
								</ns2:ExtraCashInfo>
								<ns2:IntraCashInfo>
									<ns2:Balance>{ data($transaction/@SALDOINTRA_2) }</ns2:Balance>
									<ns2:Installment>{ data($transaction/@CUOTAINTRA_2) }</ns2:Installment>
									<ns2:Interest>{ data($transaction/@INTERESESINTRA_2) }</ns2:Interest>
									<ns2:Fee>{ data($transaction/@CARGOSINTRA_2) }</ns2:Fee>
								</ns2:IntraCashInfo>
							</ns2:Transaction>,
							<ns2:Transaction>
								<ns2:PeriodDate>{ data($transaction/@FECHACORTE_3) }</ns2:PeriodDate>
								<ns2:PeriodBalance>{ data($transaction/@SALDOCORTE_3) }</ns2:PeriodBalance>
								<ns2:AmountDue>{ data($transaction/@PAGOMINIMO_3) }</ns2:AmountDue>
								<ns2:Payments>{ data($transaction/@PAGOS_3) }</ns2:Payments>
								<ns2:MerchSales>{ data($transaction/@CONSUMOS_3) }</ns2:MerchSales>
								<ns2:CashWithDrawal>{ data($transaction/@RETIROS_3) }</ns2:CashWithDrawal>
								<ns2:Limit>{ data($transaction/@LimitE_3) }</ns2:Limit>
								<ns2:OtherTransactions>{ data($transaction/@OTRASTRANSACCIONES_3) }</ns2:OtherTransactions>
								<ns2:Interest>{ data($transaction/@INTERESES_3) }</ns2:Interest>
								<ns2:TotalFees>{ data($transaction/@TOTALCARGOS_3) }</ns2:TotalFees>
								<ns2:OtherDebits>{ data($transaction/@OTROSDEBITOS_3) }</ns2:OtherDebits>
								<ns2:CycleDue>{ data($transaction/@MORA_3) }</ns2:CycleDue>
								<ns2:CycleTotalBalance>{ data($transaction/@SALDOTOTAL_3) }</ns2:CycleTotalBalance>
								<ns2:ExtraCashInfo>
									<ns2:Balance>{ data($transaction/@SALDOEXTRA_3) }</ns2:Balance>
									<ns2:Installment>{ data($transaction/@CUOTAEXTRA_3) }</ns2:Installment>
									<ns2:Interest>{ data($transaction/@INTERESESEXTRA_3) }</ns2:Interest>
									<ns2:Fee>{ data($transaction/@CARGOSINTRA_3) }</ns2:Fee>
								</ns2:ExtraCashInfo>
								<ns2:IntraCashInfo>
									<ns2:Balance>{ data($transaction/@SALDOINTRA_3) }</ns2:Balance>
									<ns2:Installment>{ data($transaction/@CUOTAINTRA_3) }</ns2:Installment>
									<ns2:Interest>{ data($transaction/@INTERESESINTRA_3) }</ns2:Interest>
									<ns2:Fee>{ data($transaction/@CARGOSINTRA_3) }</ns2:Fee>
								</ns2:IntraCashInfo>
							</ns2:Transaction>,
							<ns2:Transaction>
								<ns2:PeriodDate>{ data($transaction/@FECHACORTE_4) }</ns2:PeriodDate>
								<ns2:PeriodBalance>{ data($transaction/@SALDOCORTE_4) }</ns2:PeriodBalance>
								<ns2:AmountDue>{ data($transaction/@PAGOMINIMO_4) }</ns2:AmountDue>
								<ns2:Payments>{ data($transaction/@PAGOS_4) }</ns2:Payments>
								<ns2:MerchSales>{ data($transaction/@CONSUMOS_4) }</ns2:MerchSales>
								<ns2:CashWithDrawal>{ data($transaction/@RETIROS_4) }</ns2:CashWithDrawal>
								<ns2:Limit>{ data($transaction/@LimitE_4) }</ns2:Limit>
								<ns2:OtherTransactions>{ data($transaction/@OTRASTRANSACCIONES_4) }</ns2:OtherTransactions>
								<ns2:Interest>{ data($transaction/@INTERESES_4) }</ns2:Interest>
								<ns2:TotalFees>{ data($transaction/@TOTALCARGOS_4) }</ns2:TotalFees>
								<ns2:OtherDebits>{ data($transaction/@OTROSDEBITOS_4) }</ns2:OtherDebits>
								<ns2:CycleDue>{ data($transaction/@MORA_4) }</ns2:CycleDue>
								<ns2:CycleTotalBalance>{ data($transaction/@SALDOTOTAL_4) }</ns2:CycleTotalBalance>
								<ns2:ExtraCashInfo>
									<ns2:Balance>{ data($transaction/@SALDOEXTRA_4) }</ns2:Balance>
									<ns2:Installment>{ data($transaction/@CUOTAEXTRA_4) }</ns2:Installment>
									<ns2:Interest>{ data($transaction/@INTERESESEXTRA_4) }</ns2:Interest>
									<ns2:Fee>{ data($transaction/@CARGOSINTRA_4) }</ns2:Fee>
								</ns2:ExtraCashInfo>
								<ns2:IntraCashInfo>
									<ns2:Balance>{ data($transaction/@SALDOINTRA_4) }</ns2:Balance>
									<ns2:Installment>{ data($transaction/@CUOTAINTRA_4) }</ns2:Installment>
									<ns2:Interest>{ data($transaction/@INTERESESINTRA_4) }</ns2:Interest>
									<ns2:Fee>{ data($transaction/@CARGOSINTRA_4) }</ns2:Fee>
								</ns2:IntraCashInfo>
							</ns2:Transaction>,
							<ns2:Transaction>
								<ns2:PeriodDate>{ data($transaction/@FECHACORTE_5) }</ns2:PeriodDate>
								<ns2:PeriodBalance>{ data($transaction/@SALDOCORTE_5) }</ns2:PeriodBalance>
								<ns2:AmountDue>{ data($transaction/@PAGOMINIMO_5) }</ns2:AmountDue>
								<ns2:Payments>{ data($transaction/@PAGOS_5) }</ns2:Payments>
								<ns2:MerchSales>{ data($transaction/@CONSUMOS_5) }</ns2:MerchSales>
								<ns2:CashWithDrawal>{ data($transaction/@RETIROS_5) }</ns2:CashWithDrawal>
								<ns2:Limit>{ data($transaction/@LimitE_5) }</ns2:Limit>
								<ns2:OtherTransactions>{ data($transaction/@OTRASTRANSACCIONES_5) }</ns2:OtherTransactions>
								<ns2:Interest>{ data($transaction/@INTERESES_5) }</ns2:Interest>
								<ns2:TotalFees>{ data($transaction/@TOTALCARGOS_5) }</ns2:TotalFees>
								<ns2:OtherDebits>{ data($transaction/@OTROSDEBITOS_5) }</ns2:OtherDebits>
								<ns2:CycleDue>{ data($transaction/@MORA_5) }</ns2:CycleDue>
								<ns2:CycleTotalBalance>{ data($transaction/@SALDOTOTAL_5) }</ns2:CycleTotalBalance>
								<ns2:ExtraCashInfo>
									<ns2:Balance>{ data($transaction/@SALDOEXTRA_5) }</ns2:Balance>
									<ns2:Installment>{ data($transaction/@CUOTAEXTRA_5) }</ns2:Installment>
									<ns2:Interest>{ data($transaction/@INTERESESEXTRA_5) }</ns2:Interest>
									<ns2:Fee>{ data($transaction/@CARGOSINTRA_5) }</ns2:Fee>
								</ns2:ExtraCashInfo>
								<ns2:IntraCashInfo>
									<ns2:Balance>{ data($transaction/@SALDOINTRA_5) }</ns2:Balance>
									<ns2:Installment>{ data($transaction/@CUOTAINTRA_5) }</ns2:Installment>
									<ns2:Interest>{ data($transaction/@INTERESESINTRA_5) }</ns2:Interest>
									<ns2:Fee>{ data($transaction/@CARGOSINTRA_5) }</ns2:Fee>
								</ns2:IntraCashInfo>
							</ns2:Transaction>,
							<ns2:Transaction>
								<ns2:PeriodDate>{ data($transaction/@FECHACORTE_6) }</ns2:PeriodDate>
								<ns2:PeriodBalance>{ data($transaction/@SALDOCORTE_6) }</ns2:PeriodBalance>
								<ns2:AmountDue>{ data($transaction/@PAGOMINIMO_6) }</ns2:AmountDue>
								<ns2:Payments>{ data($transaction/@PAGOS_6) }</ns2:Payments>
								<ns2:MerchSales>{ data($transaction/@CONSUMOS_6) }</ns2:MerchSales>
								<ns2:CashWithDrawal>{ data($transaction/@RETIROS_6) }</ns2:CashWithDrawal>
								<ns2:Limit>{ data($transaction/@LimitE_6) }</ns2:Limit>
								<ns2:OtherTransactions>{ data($transaction/@OTRASTRANSACCIONES_6) }</ns2:OtherTransactions>
								<ns2:Interest>{ data($transaction/@INTERESES_6) }</ns2:Interest>
								<ns2:TotalFees>{ data($transaction/@TOTALCARGOS_6) }</ns2:TotalFees>
								<ns2:OtherDebits>{ data($transaction/@OTROSDEBITOS_6) }</ns2:OtherDebits>
								<ns2:CycleDue>{ data($transaction/@MORA_6) }</ns2:CycleDue>
								<ns2:CycleTotalBalance>{ data($transaction/@SALDOTOTAL_6) }</ns2:CycleTotalBalance>
								<ns2:ExtraCashInfo>
									<ns2:Balance>{ data($transaction/@SALDOEXTRA_6) }</ns2:Balance>
									<ns2:Installment>{ data($transaction/@CUOTAEXTRA_6) }</ns2:Installment>
									<ns2:Interest>{ data($transaction/@INTERESESEXTRA_6) }</ns2:Interest>
									<ns2:Fee>{ data($transaction/@CARGOSINTRA_6) }</ns2:Fee>
								</ns2:ExtraCashInfo>
								<ns2:IntraCashInfo>
									<ns2:Balance>{ data($transaction/@SALDOINTRA_6) }</ns2:Balance>
									<ns2:Installment>{ data($transaction/@CUOTAINTRA_6) }</ns2:Installment>
									<ns2:Interest>{ data($transaction/@INTERESESINTRA_6) }</ns2:Interest>
									<ns2:Fee>{ data($transaction/@CARGOSINTRA_6) }</ns2:Fee>
								</ns2:IntraCashInfo>
							</ns2:Transaction>,
							<ns2:Transaction>
								<ns2:PeriodDate>{ data($transaction/@FECHACORTE_7) }</ns2:PeriodDate>
								<ns2:PeriodBalance>{ data($transaction/@SALDOCORTE_7) }</ns2:PeriodBalance>
								<ns2:AmountDue>{ data($transaction/@PAGOMINIMO_7) }</ns2:AmountDue>
								<ns2:Payments>{ data($transaction/@PAGOS_7) }</ns2:Payments>
								<ns2:MerchSales>{ data($transaction/@CONSUMOS_7) }</ns2:MerchSales>
								<ns2:CashWithDrawal>{ data($transaction/@RETIROS_7) }</ns2:CashWithDrawal>
								<ns2:Limit>{ data($transaction/@LimitE_7) }</ns2:Limit>
								<ns2:OtherTransactions>{ data($transaction/@OTRASTRANSACCIONES_7) }</ns2:OtherTransactions>
								<ns2:Interest>{ data($transaction/@INTERESES_7) }</ns2:Interest>
								<ns2:TotalFees>{ data($transaction/@TOTALCARGOS_7) }</ns2:TotalFees>
								<ns2:OtherDebits>{ data($transaction/@OTROSDEBITOS_7) }</ns2:OtherDebits>
								<ns2:CycleDue>{ data($transaction/@MORA_7) }</ns2:CycleDue>
								<ns2:CycleTotalBalance>{ data($transaction/@SALDOTOTAL_7) }</ns2:CycleTotalBalance>
								<ns2:ExtraCashInfo>
									<ns2:Balance>{ data($transaction/@SALDOEXTRA_7) }</ns2:Balance>
									<ns2:Installment>{ data($transaction/@CUOTAEXTRA_7) }</ns2:Installment>
									<ns2:Interest>{ data($transaction/@INTERESESEXTRA_7) }</ns2:Interest>
									<ns2:Fee>{ data($transaction/@CARGOSINTRA_7) }</ns2:Fee>
								</ns2:ExtraCashInfo>
								<ns2:IntraCashInfo>
									<ns2:Balance>{ data($transaction/@SALDOINTRA_7) }</ns2:Balance>
									<ns2:Installment>{ data($transaction/@CUOTAINTRA_7) }</ns2:Installment>
									<ns2:Interest>{ data($transaction/@INTERESESINTRA_7) }</ns2:Interest>
									<ns2:Fee>{ data($transaction/@CARGOSINTRA_7) }</ns2:Fee>
								</ns2:IntraCashInfo>
							</ns2:Transaction>,
							<ns2:Transaction>
								<ns2:PeriodDate>{ data($transaction/@FECHACORTE_8) }</ns2:PeriodDate>
								<ns2:PeriodBalance>{ data($transaction/@SALDOCORTE_8) }</ns2:PeriodBalance>
								<ns2:AmountDue>{ data($transaction/@PAGOMINIMO_8) }</ns2:AmountDue>
								<ns2:Payments>{ data($transaction/@PAGOS_8) }</ns2:Payments>
								<ns2:MerchSales>{ data($transaction/@CONSUMOS_8) }</ns2:MerchSales>
								<ns2:CashWithDrawal>{ data($transaction/@RETIROS_8) }</ns2:CashWithDrawal>
								<ns2:Limit>{ data($transaction/@LimitE_8) }</ns2:Limit>
								<ns2:OtherTransactions>{ data($transaction/@OTRASTRANSACCIONES_8) }</ns2:OtherTransactions>
								<ns2:Interest>{ data($transaction/@INTERESES_8) }</ns2:Interest>
								<ns2:TotalFees>{ data($transaction/@TOTALCARGOS_8) }</ns2:TotalFees>
								<ns2:OtherDebits>{ data($transaction/@OTROSDEBITOS_8) }</ns2:OtherDebits>
								<ns2:CycleDue>{ data($transaction/@MORA_8) }</ns2:CycleDue>
								<ns2:CycleTotalBalance>{ data($transaction/@SALDOTOTAL_8) }</ns2:CycleTotalBalance>
								<ns2:ExtraCashInfo>
									<ns2:Balance>{ data($transaction/@SALDOEXTRA_8) }</ns2:Balance>
									<ns2:Installment>{ data($transaction/@CUOTAEXTRA_8) }</ns2:Installment>
									<ns2:Interest>{ data($transaction/@INTERESESEXTRA_8) }</ns2:Interest>
									<ns2:Fee>{ data($transaction/@CARGOSINTRA_8) }</ns2:Fee>
								</ns2:ExtraCashInfo>
								<ns2:IntraCashInfo>
									<ns2:Balance>{ data($transaction/@SALDOINTRA_8) }</ns2:Balance>
									<ns2:Installment>{ data($transaction/@CUOTAINTRA_8) }</ns2:Installment>
									<ns2:Interest>{ data($transaction/@INTERESESINTRA_8) }</ns2:Interest>
									<ns2:Fee>{ data($transaction/@CARGOSINTRA_8) }</ns2:Fee>
								</ns2:IntraCashInfo>
							</ns2:Transaction>,
							<ns2:Transaction>
								<ns2:PeriodDate>{ data($transaction/@FECHACORTE_9) }</ns2:PeriodDate>
								<ns2:PeriodBalance>{ data($transaction/@SALDOCORTE_9) }</ns2:PeriodBalance>
								<ns2:AmountDue>{ data($transaction/@PAGOMINIMO_9) }</ns2:AmountDue>
								<ns2:Payments>{ data($transaction/@PAGOS_9) }</ns2:Payments>
								<ns2:MerchSales>{ data($transaction/@CONSUMOS_9) }</ns2:MerchSales>
								<ns2:CashWithDrawal>{ data($transaction/@RETIROS_9) }</ns2:CashWithDrawal>
								<ns2:Limit>{ data($transaction/@LimitE_9) }</ns2:Limit>
								<ns2:OtherTransactions>{ data($transaction/@OTRASTRANSACCIONES_9) }</ns2:OtherTransactions>
								<ns2:Interest>{ data($transaction/@INTERESES_9) }</ns2:Interest>
								<ns2:TotalFees>{ data($transaction/@TOTALCARGOS_9) }</ns2:TotalFees>
								<ns2:OtherDebits>{ data($transaction/@OTROSDEBITOS_9) }</ns2:OtherDebits>
								<ns2:CycleDue>{ data($transaction/@MORA_9) }</ns2:CycleDue>
								<ns2:CycleTotalBalance>{ data($transaction/@SALDOTOTAL_9) }</ns2:CycleTotalBalance>
								<ns2:ExtraCashInfo>
									<ns2:Balance>{ data($transaction/@SALDOEXTRA_9) }</ns2:Balance>
									<ns2:Installment>{ data($transaction/@CUOTAEXTRA_9) }</ns2:Installment>
									<ns2:Interest>{ data($transaction/@INTERESESEXTRA_9) }</ns2:Interest>
									<ns2:Fee>{ data($transaction/@CARGOSINTRA_9) }</ns2:Fee>
								</ns2:ExtraCashInfo>
								<ns2:IntraCashInfo>
									<ns2:Balance>{ data($transaction/@SALDOINTRA_9) }</ns2:Balance>
									<ns2:Installment>{ data($transaction/@CUOTAINTRA_9) }</ns2:Installment>
									<ns2:Interest>{ data($transaction/@INTERESESINTRA_9) }</ns2:Interest>
									<ns2:Fee>{ data($transaction/@CARGOSINTRA_9) }</ns2:Fee>
								</ns2:IntraCashInfo>
							</ns2:Transaction>,
							<ns2:Transaction>
								<ns2:PeriodDate>{ data($transaction/@FECHACORTE_10) }</ns2:PeriodDate>
								<ns2:PeriodBalance>{ data($transaction/@SALDOCORTE_10) }</ns2:PeriodBalance>
								<ns2:AmountDue>{ data($transaction/@PAGOMINIMO_10) }</ns2:AmountDue>
								<ns2:Payments>{ data($transaction/@PAGOS_10) }</ns2:Payments>
								<ns2:MerchSales>{ data($transaction/@CONSUMOS_10) }</ns2:MerchSales>
								<ns2:CashWithDrawal>{ data($transaction/@RETIROS_10) }</ns2:CashWithDrawal>
								<ns2:Limit>{ data($transaction/@LimitE_10) }</ns2:Limit>
								<ns2:OtherTransactions>{ data($transaction/@OTRASTRANSACCIONES_10) }</ns2:OtherTransactions>
								<ns2:Interest>{ data($transaction/@INTERESES_10) }</ns2:Interest>
								<ns2:TotalFees>{ data($transaction/@TOTALCARGOS_10) }</ns2:TotalFees>
								<ns2:OtherDebits>{ data($transaction/@OTROSDEBITOS_10) }</ns2:OtherDebits>
								<ns2:CycleDue>{ data($transaction/@MORA_10) }</ns2:CycleDue>
								<ns2:CycleTotalBalance>{ data($transaction/@SALDOTOTAL_10) }</ns2:CycleTotalBalance>
								<ns2:ExtraCashInfo>
									<ns2:Balance>{ data($transaction/@SALDOEXTRA_10) }</ns2:Balance>
									<ns2:Installment>{ data($transaction/@CUOTAEXTRA_10) }</ns2:Installment>
									<ns2:Interest>{ data($transaction/@INTERESESEXTRA_10) }</ns2:Interest>
									<ns2:Fee>{ data($transaction/@CARGOSINTRA_10) }</ns2:Fee>
								</ns2:ExtraCashInfo>
								<ns2:IntraCashInfo>
									<ns2:Balance>{ data($transaction/@SALDOINTRA_10) }</ns2:Balance>
									<ns2:Installment>{ data($transaction/@CUOTAINTRA_10) }</ns2:Installment>
									<ns2:Interest>{ data($transaction/@INTERESESINTRA_10) }</ns2:Interest>
									<ns2:Fee>{ data($transaction/@CARGOSINTRA_10) }</ns2:Fee>
								</ns2:IntraCashInfo>
							</ns2:Transaction>,
							<ns2:Transaction>
								<ns2:PeriodDate>{ data($transaction/@FECHACORTE_11) }</ns2:PeriodDate>
								<ns2:PeriodBalance>{ data($transaction/@SALDOCORTE_11) }</ns2:PeriodBalance>
								<ns2:AmountDue>{ data($transaction/@PAGOMINIMO_11) }</ns2:AmountDue>
								<ns2:Payments>{ data($transaction/@PAGOS_11) }</ns2:Payments>
								<ns2:MerchSales>{ data($transaction/@CONSUMOS_11) }</ns2:MerchSales>
								<ns2:CashWithDrawal>{ data($transaction/@RETIROS_11) }</ns2:CashWithDrawal>
								<ns2:Limit>{ data($transaction/@LimitE_11) }</ns2:Limit>
								<ns2:OtherTransactions>{ data($transaction/@OTRASTRANSACCIONES_11) }</ns2:OtherTransactions>
								<ns2:Interest>{ data($transaction/@INTERESES_11) }</ns2:Interest>
								<ns2:TotalFees>{ data($transaction/@TOTALCARGOS_11) }</ns2:TotalFees>
								<ns2:OtherDebits>{ data($transaction/@OTROSDEBITOS_11) }</ns2:OtherDebits>
								<ns2:CycleDue>{ data($transaction/@MORA_11) }</ns2:CycleDue>
								<ns2:CycleTotalBalance>{ data($transaction/@SALDOTOTAL_11) }</ns2:CycleTotalBalance>
								<ns2:ExtraCashInfo>
									<ns2:Balance>{ data($transaction/@SALDOEXTRA_11) }</ns2:Balance>
									<ns2:Installment>{ data($transaction/@CUOTAEXTRA_11) }</ns2:Installment>
									<ns2:Interest>{ data($transaction/@INTERESESEXTRA_11) }</ns2:Interest>
									<ns2:Fee>{ data($transaction/@CARGOSINTRA_11) }</ns2:Fee>
								</ns2:ExtraCashInfo>
								<ns2:IntraCashInfo>
									<ns2:Balance>{ data($transaction/@SALDOINTRA_11) }</ns2:Balance>
									<ns2:Installment>{ data($transaction/@CUOTAINTRA_11) }</ns2:Installment>
									<ns2:Interest>{ data($transaction/@INTERESESINTRA_11) }</ns2:Interest>
									<ns2:Fee>{ data($transaction/@CARGOSINTRA_11) }</ns2:Fee>
								</ns2:IntraCashInfo>
							</ns2:Transaction>,
							<ns2:Transaction>
								<ns2:PeriodDate>{ data($transaction/@FECHACORTE_12) }</ns2:PeriodDate>
								<ns2:PeriodBalance>{ data($transaction/@SALDOCORTE_12) }</ns2:PeriodBalance>
								<ns2:AmountDue>{ data($transaction/@PAGOMINIMO_12) }</ns2:AmountDue>
								<ns2:Payments>{ data($transaction/@PAGOS_12) }</ns2:Payments>
								<ns2:MerchSales>{ data($transaction/@CONSUMOS_12) }</ns2:MerchSales>
								<ns2:CashWithDrawal>{ data($transaction/@RETIROS_12) }</ns2:CashWithDrawal>
								<ns2:Limit>{ data($transaction/@LimitE_12) }</ns2:Limit>
								<ns2:OtherTransactions>{ data($transaction/@OTRASTRANSACCIONES_12) }</ns2:OtherTransactions>
								<ns2:Interest>{ data($transaction/@INTERESES_12) }</ns2:Interest>
								<ns2:TotalFees>{ data($transaction/@TOTALCARGOS_12) }</ns2:TotalFees>
								<ns2:OtherDebits>{ data($transaction/@OTROSDEBITOS_12) }</ns2:OtherDebits>
								<ns2:CycleDue>{ data($transaction/@MORA_12) }</ns2:CycleDue>
								<ns2:CycleTotalBalance>{ data($transaction/@SALDOTOTAL_12) }</ns2:CycleTotalBalance>
								<ns2:ExtraCashInfo>
									<ns2:Balance>{ data($transaction/@SALDOEXTRA_12) }</ns2:Balance>
									<ns2:Installment>{ data($transaction/@CUOTAEXTRA_12) }</ns2:Installment>
									<ns2:Interest>{ data($transaction/@INTERESESEXTRA_12) }</ns2:Interest>
									<ns2:Fee>{ data($transaction/@CARGOSINTRA_12) }</ns2:Fee>
								</ns2:ExtraCashInfo>
								<ns2:IntraCashInfo>
									<ns2:Balance>{ data($transaction/@SALDOINTRA_12) }</ns2:Balance>
									<ns2:Installment>{ data($transaction/@CUOTAINTRA_12) }</ns2:Installment>
									<ns2:Interest>{ data($transaction/@INTERESESINTRA_12) }</ns2:Interest>
									<ns2:Fee>{ data($transaction/@CARGOSINTRA_12) }</ns2:Fee>
								</ns2:IntraCashInfo>
							</ns2:Transaction>
							)
							}
						</ns2:ProductTransactions>
						)else ()
						}
					</ns2:CreditCard>
					)
					}
				</ns2:CreditCardsInfo>
				) else ()
				}
				{
				if(count($responseData/*:PRESTAMOS/*:CUENTA) > 0) then (
				<ns2:LoansInfo>
					{
					for $prestamos in $responseData/*:PRESTAMOS/*:CUENTA
					return(
					<ns2:Loan>
						<ns2:Number>{ data($prestamos/@NUMEROPRESTAMO) }</ns2:Number>
						<ns2:AgencyCode>{ data($prestamos/@CODIGOAGENCIA) }</ns2:AgencyCode>
						<ns2:SubApplicaton>{ data($prestamos/@CODIGOSUBAPLICACION) }</ns2:SubApplicaton>
						<ns2:OpeningDate>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", data($prestamos/@FECHAAPERTURA)) }</ns2:OpeningDate>
						{
						if(data($prestamos/@FECHACANCELACION) != "") then(
						<ns2:CancelationDate>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", data($prestamos/@FECHACANCELACION)) }</ns2:CancelationDate>
						)else ()
						}
						<ns2:InitialAmount>{ xs:float(data($prestamos/@MONTOINICIAL)) }</ns2:InitialAmount>
						<ns2:CurrentBalance>{ xs:float(data($prestamos/@SALDOACTUAL)) }</ns2:CurrentBalance>
						<ns2:PaymentAmount>{ xs:float(data($prestamos/@VALORCUOTA)) }</ns2:PaymentAmount>
						<ns2:Rate>{ xs:float(data($prestamos/@TASA)) }</ns2:Rate>
						<ns2:Term>{ xs:float(data($prestamos/@PLAZO)) }</ns2:Term>
						<ns2:PaymentNumber>{ xs:float(data($prestamos/@NUMEROCUOTAS)) }</ns2:PaymentNumber>
						<ns2:FirstCapitalPaymentDate>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", data($prestamos/@FECHAPRIMERPAGOCAPITAL)) }</ns2:FirstCapitalPaymentDate>
						<ns2:LastPaymentDate>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", data($prestamos/@FECHAULTIMOPAGO)) }</ns2:LastPaymentDate>
						<ns2:PaidPayments>{ data($prestamos/@CANTIDADCUOTASPAGADAS) }</ns2:PaidPayments>
						<ns2:CapitalFrequency>{ data($prestamos/@FRECUENCIACAPITAL) }</ns2:CapitalFrequency>
						<ns2:DestinationCode>{ data($prestamos/@CODIGODESTINO) }</ns2:DestinationCode>
						<ns2:MonthlyPrime>{ data($prestamos/@PRIMAMENSUAL) }</ns2:MonthlyPrime>
						<ns2:ContractNumber>{ xs:int(data($prestamos/@NUMEROCONTRATO)) }</ns2:ContractNumber>
						<ns2:Charges>{ xs:float(data($prestamos/@CARGOS)) }</ns2:Charges>
						<ns2:Interest>{ xs:float(data($prestamos/@INTERES)) }</ns2:Interest>
						<ns2:Insurance>{ xs:float(data($prestamos/@SEGUROS)) }</ns2:Insurance>
						<ns2:OtherCharges>{ xs:float(data($prestamos/@OTROSCARGOS)) }</ns2:OtherCharges>
						<ns2:CurrentDue>{ xs:int(xs:decimal(data($prestamos/@MORAACTUAL))) }</ns2:CurrentDue>
						<ns2:DebtorType>{ data($prestamos/@TIPODEUDOR) }</ns2:DebtorType>
						<ns2:CodeType>{ data($prestamos/@CODIGOTIPOPRESTAMO) }</ns2:CodeType>
						<ns2:GuaranteeType>{ data($prestamos/@CODIGOTIPOGARANTIA) }</ns2:GuaranteeType>
						{
						if(data($prestamos/@NUMEROPRESTAMO) = data($responseData/*:TRANSACCIONESPRESTAMO/*:CUENTA/@NUMEROPRESTAMO))then (
						<ns2:ProductTransactions>
							{
							for $transaccionesPrestamo in $responseData/*:TRANSACCIONESPRESTAMO/*:CUENTA order by  $transaccionesPrestamo/@FECHACIERRE descending
							return(
							<ns2:Transaction>
								<ns2:PeriodDate>{ fn-bea:dateTime-from-string-with-format("yyyy-MM-dd", data($transaccionesPrestamo/@FECHACIERRE)) }</ns2:PeriodDate>
								<ns2:PeriodBalance>{ xs:float(data($transaccionesPrestamo/@ALDOTOTAL)) }</ns2:PeriodBalance>
								<ns2:CapitalBalance>{ xs:float(data($transaccionesPrestamo/@SALDOCAPITAL)) }</ns2:CapitalBalance>
								<ns2:DueBalance>{ xs:int(xs:decimal(data($transaccionesPrestamo/@SALDOVENCIDO))) }</ns2:DueBalance>
								<ns2:Charges>{ data($transaccionesPrestamo/@CARGOS) }</ns2:Charges>
								<ns2:Interest>{ data($transaccionesPrestamo/@INTERESES) }</ns2:Interest>
								<ns2:Payment>{ data($transaccionesPrestamo/@PAGOS) }</ns2:Payment>
								<ns2:Insurance>{ data($transaccionesPrestamo/@SEGUROS) }</ns2:Insurance>
								<ns2:OtherCharges>{ data($transaccionesPrestamo/@OTROSCARGOS) }</ns2:OtherCharges>
								<ns2:CycleDue>{ data($transaccionesPrestamo/@MORACIERRE) }</ns2:CycleDue>
							</ns2:Transaction>
							)
							}
						</ns2:ProductTransactions>
						)else()
						}
					</ns2:Loan>
					)
					}
				</ns2:LoansInfo>
				) else ()
				}
				</ns2:Liability>
			</ns2:Liabilities>
		</ns2:CustomerInfo>
	</ns2:LoanMaintenance>
	<ns2:LoanOriginations>
		{
		if(count($responseData/*:OFERTAPREAPROBADA/*:OFERTA) > 0) then (
		<ns2:PreApprovedOffers>
			{
			for $oferta in $responseData/*:OFERTAPREAPROBADA/*:OFERTA
			return(
			<ns2:Offer>
				<ns2:InformationDate>{ fn-bea:dateTime-from-string-with-format("yyyy-MM-dd",data($oferta/@FECHAINFORMACION)) }</ns2:InformationDate>
				<ns2:Type>FICOCREDITO</ns2:Type>
				<ns2:Details>
					{
					<ns2:For12Months>{ xs:float(data($oferta/@OFERTAFICOCREDITO12)) }</ns2:For12Months>,
					<ns2:For18Months>{ xs:float(data($oferta/@OFERTAFICOCREDITO18)) }</ns2:For18Months>,
					<ns2:For24Months>{ xs:float(data($oferta/@OFERTAFICOCREDITO24)) }</ns2:For24Months>,
					<ns2:For36Months>{ xs:float(data($oferta/@OFERTAFICOCREDITO36)) }</ns2:For36Months>,
					<ns2:For48Months>{ xs:float(data($oferta/@OFERTAFICOCREDITO48)) }</ns2:For48Months>,
					<ns2:For60Months>{ xs:float(data($oferta/@OFERTAFICOCREDITO60)) }</ns2:For60Months>
					}
				</ns2:Details>
				<ns2:Installment>{ xs:float(($oferta/@CUOTAFICOCREDITO)) }</ns2:Installment>
				<ns2:Rate>{ xs:int(xs:decimal(data($oferta/@TASAFICOCREDITO))*100) }</ns2:Rate>
				<ns2:TimesIncome>{ xs:int(data($oferta/@TIMESINCOMEFICOCREDITO)) }</ns2:TimesIncome>
			</ns2:Offer>,
			<ns2:Offer>
				<ns2:InformationDate>{ fn-bea:dateTime-from-string-with-format("yyyy-MM-dd",data($oferta/@FECHAINFORMACION)) }</ns2:InformationDate>
				<ns2:Type>FICOYA</ns2:Type>
				<ns2:Details>
					{
					<ns2:For12Months>{ xs:float(data($oferta/@OFERTAFICOYA12)) }</ns2:For12Months>,
					<ns2:For18Months>{ xs:float(data($oferta/@OFERTAFICOYA18)) }</ns2:For18Months>,
					<ns2:For24Months>{ xs:float(data($oferta/@OFERTAFICOYA24)) }</ns2:For24Months>,
					<ns2:For36Months>{ xs:float(data($oferta/@OFERTAFICOYA36)) }</ns2:For36Months>,
					<ns2:For48Months>{ xs:float(data($oferta/@OFERTAFICOYA48)) }</ns2:For48Months>,
					<ns2:For60Months>{ xs:float(data($oferta/@OFERTAFICOYA60)) }</ns2:For60Months>
					}
				</ns2:Details>
				<ns2:Installment>{ xs:float(($oferta/@CUOTAFICOYA)) }</ns2:Installment>
				<ns2:Rate>{ xs:int(xs:decimal(data($oferta/@TASAFICOYA))*100) }</ns2:Rate>
				<ns2:TimesIncome>{ xs:int(data($oferta/@TIMESINCOMEFICOYA)) }</ns2:TimesIncome>
			</ns2:Offer>,
			<ns2:Offer>
				<ns2:InformationDate>{ fn-bea:dateTime-from-string-with-format("yyyy-MM-dd",data($oferta/@FECHAINFORMACION)) }</ns2:InformationDate>
				<ns2:Type>OPI</ns2:Type>
				<ns2:Details>
					{
					<ns2:For12Months>{ xs:float(data($oferta/@OFERTAOPI12)) }</ns2:For12Months>,
					<ns2:For18Months>{ xs:float(data($oferta/@OFERTAOPI18)) }</ns2:For18Months>,
					<ns2:For24Months>{ xs:float(data($oferta/@OFERTAOPI24)) }</ns2:For24Months>,
					<ns2:For36Months>{ xs:float(data($oferta/@OFERTAOPI36)) }</ns2:For36Months>,
					<ns2:For48Months>{ xs:float(data($oferta/@OFERTAOPI48)) }</ns2:For48Months>,
					<ns2:For60Months>{ xs:float(data($oferta/@OFERTAOPI60)) }</ns2:For60Months>
					}
				</ns2:Details>
				<ns2:Installment>{ xs:float(($oferta/@CUOTAOPI)) }</ns2:Installment>
				<ns2:Rate>{ xs:int(xs:decimal(data($oferta/@TASAOPI))*100) }</ns2:Rate>
				<ns2:TimesIncome>{ xs:int(data($oferta/@TIMESINCOMEOPI)) }</ns2:TimesIncome>
			</ns2:Offer>,
			<ns2:Offer>
				<ns2:InformationDate>{ fn-bea:dateTime-from-string-with-format("yyyy-MM-dd",data($oferta/@FECHAINFORMACION)) }</ns2:InformationDate>
				<ns2:Type>RETANQUEO</ns2:Type>
				<ns2:Details>
					{
					<ns2:For12Months>{ xs:float(data($oferta/@OFERTARETANQUEO12)) }</ns2:For12Months>,
					<ns2:For18Months>{ xs:float(data($oferta/@OFERTARETANQUEO18)) }</ns2:For18Months>,
					<ns2:For24Months>{ xs:float(data($oferta/@OFERTARETANQUEO24)) }</ns2:For24Months>,
					<ns2:For36Months>{ xs:float(data($oferta/@OFERTARETANQUEO36)) }</ns2:For36Months>,
					<ns2:For48Months>{ xs:float(data($oferta/@OFERTARETANQUEO48)) }</ns2:For48Months>,
					<ns2:For60Months>{ xs:float(data($oferta/@OFERTARETANQUEO60)) }</ns2:For60Months>
					}
				</ns2:Details>
				<ns2:Installment>{ xs:float(($oferta/@CUOTARETANQUEO)) }</ns2:Installment>
				<ns2:Rate>{ xs:int(xs:decimal(data($oferta/@TASARETANQUEO))*100) }</ns2:Rate>
				<ns2:TimesIncome>{ xs:int(data($oferta/@TIMESINCOMERETANQUEO)) }</ns2:TimesIncome>
			</ns2:Offer>
			)
			}
		</ns2:PreApprovedOffers>
		)else ()
		}
		{
		if(count($responseData/*:EXTRAFIN/*:CUENTA) > 0) then (
		<ns2:InternalExtras>
			{
			for $extrafin in $responseData/*:EXTRAFIN/*:CUENTA
			return(
			<ns2:Extra>
				<ns2:AccountNumber>{ data($extrafin/@NUMEROCUENTA) }</ns2:AccountNumber>
				<ns2:Date>{ data($extrafin/@FECHAEXTRA) }</ns2:Date>
				<ns2:Rate>{ data($extrafin/@TASAEXTRA) }</ns2:Rate>
				<ns2:Amount>{ data($extrafin/@MONTOTOMADO) }</ns2:Amount>
				<ns2:Installment>{ data($extrafin/@CUOTAEXTRA) }</ns2:Installment>
				<ns2:InstallmentCount>{ data($extrafin/@CUOTANUMERO) }</ns2:InstallmentCount>
				<ns2:TotalInstallment>{ data($extrafin/@TOTALCUOTAS) }</ns2:TotalInstallment>
			</ns2:Extra>
			)
			}
		</ns2:InternalExtras>
		)else ()
		}
		<ns2:ReferencesDetails>
			{
			if(count($responseData/*:RECORDC/*:CUENTA) > 0) then (
			<ns2:Queries>
				{
				for $recordc in $responseData/*:RECORDC/*:CUENTA
				return(
				<ns2:QueryItem>
					<ns2:Id>{ data($recordc/@viewId) }</ns2:Id>
					{
					if(data($recordc/@queryDate) != "00/00/0000")then (
					<ns2:Date>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordc/@queryDate))) }</ns2:Date>
					)else ()
					}
					<ns2:Entity>{ fn-bea:trim(data($recordc/@whoMadeQuery)) }</ns2:Entity>
				</ns2:QueryItem>
				)
				}
			</ns2:Queries>
			)else ()
			}
			<ns2:ActiveReferences>
				{
				if(count($responseData/*:RECORDB/*:CUENTA) > 0) then (
				for $recordb in $responseData/*:RECORDB/*:CUENTA
				return(
				<ns2:Reference>
					{
					if(data($recordb/@idEstudio) != "") then (
					<ns2:QueryId>{ data($recordb/@idEstudio) }</ns2:QueryId>
					) else ()
					}
					<ns2:Creditor>{ fn-bea:trim(data($recordb/@Acreedor)) }</ns2:Creditor>
					<ns2:ReferenceNumber>{ fn-bea:trim(data($recordb/@noReferencia)) }</ns2:ReferenceNumber>
					<ns2:Type>{ data($recordb/@TipoReferencia) }</ns2:Type>
					<ns2:ObligationType>{ fn-bea:trim(data($recordb/@tipoObligacion)) }</ns2:ObligationType>
					<ns2:CreditType>{ fn-bea:trim(data($recordb/@TipoPrestamo)) }</ns2:CreditType>
					<ns2:Status>{ fn-bea:trim(data($recordb/@Estado)) }</ns2:Status>
					<ns2:Limit>{fn:data($recordb/@LimiteMonto) }</ns2:Limit>
					<ns2:Currency>{ fn-bea:trim(data($recordb/@Moneda)) }</ns2:Currency>
					<ns2:Balance>{ xs:float(data($recordb/@SaldoActual)) }</ns2:Balance>
					<ns2:PaymentMethod>{ fn-bea:trim(data($recordb/@FormaPago)) }</ns2:PaymentMethod>
					<ns2:Guarantee>{ xs:float(data($recordb/@ValorGarantia)) }</ns2:Guarantee>
					<ns2:GuaranteeType>{ fn-bea:trim(data($recordb/@TipoGarantia)) }</ns2:GuaranteeType>
					<ns2:ArrearBalance>{ xs:float(data($recordb/@SaldoMora)) }</ns2:ArrearBalance>
					<ns2:ArrearLevel>{ fn-bea:trim(data($recordb/@nivelMora)) }</ns2:ArrearLevel>
					<ns2:DueBalance>{ xs:float(data($recordb/@SaldoVencido)) }</ns2:DueBalance>
					<ns2:InExecution>{ xs:float(data($recordb/@SaldoCobroJudicial)) }</ns2:InExecution>
					<ns2:PunishedBalance>{ xs:float(data($recordb/@SaldoCastigado)) }</ns2:PunishedBalance>
					<ns2:Period>{ data($recordb/@periodoInfo) }</ns2:Period>
					<ns2:OpeningDate>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordb/@FechaApertura))) }</ns2:OpeningDate>
					{
					if(data($recordb/@FechaCancelacion) != "00/00/0000")then (
					<ns2:CancelationDate>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordb/@FechaCancelacion))) }</ns2:CancelationDate>
					)else ()
					}
					{
					if(data($recordb/@FechaVencimiento) != "00/00/0000")then (
					<ns2:ExpirationDate>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordb/@FechaVencimiento))) }</ns2:ExpirationDate>
					)else ()
					}
					<ns2:Installment>{ xs:float(data($recordb/@Cuota)) }</ns2:Installment>
					{
					for $recordhb in $responseData/*:RECORDHB/*:CUENTA[@noReferencia = $recordb/@noReferencia]
					return(
					<ns2:HistoricalArrear>{ data($recordhb/@MoraHistorica) }</ns2:HistoricalArrear>,
					<ns2:HistoricalCountLoc>{ data($recordhb/@conteoHistoricoLoc) }</ns2:HistoricalCountLoc>,
					<ns2:HistoricalCountDol>{ data($recordhb/@conteoHistoricoDol) }</ns2:HistoricalCountDol>
					)
					}
				</ns2:Reference>
				)
				)else()
				}
				{
				if(count($responseData/*:RECORDD/*:CUENTA) > 0) then (
				for $recordd in $responseData/*:RECORDD/*:CUENTA
				return(
				<ns2:Reference>
					{
					if(data($recordd/@idEstudio) != "") then (
					<ns2:QueryId>{ data($recordd/@idEstudio) }</ns2:QueryId>
					)else ()
					}
					<ns2:Creditor>{ fn-bea:trim(data($recordd/@Acreedor)) }</ns2:Creditor>
					<ns2:ReferenceNumber>{ data($recordd/@noReferencia) }</ns2:ReferenceNumber>
					<ns2:Type>{ data($recordd/@TipoReferencia) }</ns2:Type>
					<ns2:CreditType>{ fn-bea:trim(data($recordd/@TipoPrestamo)) }</ns2:CreditType>
					<ns2:Status>{ fn-bea:trim(data($recordd/@Estado)) }</ns2:Status>
					<ns2:Limit>{ xs:float(data($recordd/@LimiteMonto)) }</ns2:Limit>
					<ns2:Term>{ xs:float(data($recordd/@Plazo)) }</ns2:Term>
					<ns2:Currency>{ fn-bea:trim(data($recordd/@Moneda)) }</ns2:Currency>
					<ns2:ExchangeFactor>{ xs:float(data($recordd/@FactorCambio)) }</ns2:ExchangeFactor>
					<ns2:Balance>{ xs:float(data($recordd/@SaldoActual)) }</ns2:Balance>
					<ns2:MinPayment>{ xs:float(data($recordd/@Cuota)) }</ns2:MinPayment>
					<ns2:GuaranteeType>{ fn-bea:trim(data($recordd/@TipoGarantia)) }</ns2:GuaranteeType>
					<ns2:ArrearBalance>{ xs:float(data($recordd/@SaldoMora)) }</ns2:ArrearBalance>
					<ns2:ArrearLevel>{ data($recordd/@nivelMora) }</ns2:ArrearLevel>
					<ns2:Period>{ data($recordd/@periodoInfo) }</ns2:Period>
					<ns2:OpeningDate>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordd/@FechaApertura))) }</ns2:OpeningDate>
					{
					if(data($recordd/@FechaCancelacion) != "00/00/0000")then (
					<ns2:CancelationDate>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordd/@FechaCancelacion))) }</ns2:CancelationDate>
					)else ()
					}
					{
					if(data($recordd/@FechaVencimiento) != "00/00/0000")then (
					<ns2:ExpirationDate>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordd/@FechaVencimiento))) }</ns2:ExpirationDate>
					)else ()
					}
					<ns2:Installment>{ xs:float(data($recordd/@Cuota)) }</ns2:Installment>
					{
					for $recordhd in $responseData/*:RECORDHD/*:CUENTA[@noReferencia = $recordd/@noReferencia]
					return(
					<ns2:HistoricalArrear>{ data($recordhd/@MoraHistorica) }</ns2:HistoricalArrear>,
					<ns2:HistoricalCountLoc>{ data($recordhd/@conteoHistoricoLoc) }</ns2:HistoricalCountLoc>,
					<ns2:HistoricalCountDol>{ data($recordhd/@conteoHistoricoDol) }</ns2:HistoricalCountDol>
					)
					}
				</ns2:Reference>
				)
				)else()
				}
				{
				if(count($responseData/*:RECORDT/*:CUENTA) > 0) then (
				for $recordt in $responseData/*:RECORDT/*:CUENTA
				return(
				<ns2:Reference>
					{
					if(data($recordt/@idEstudio) != "") then (
					<ns2:QueryId>{ data($recordt/@idEstudio) }</ns2:QueryId>
					)else ()
					}
					<ns2:Creditor>{ fn-bea:trim(data($recordt/@Acreedor)) }</ns2:Creditor>
					<ns2:ReferenceNumber>{ fn-bea:trim(data($recordt/@noReferencia)) }</ns2:ReferenceNumber>
					<ns2:Type>{ data($recordt/@TipoReferencia) }</ns2:Type>
					<ns2:CreditType>{ fn-bea:trim(data($recordt/@TipoPrestamo)) }</ns2:CreditType>
					<ns2:STATUS>{ fn-bea:trim(data($recordt/@Estado)) }</ns2:STATUS>
					<ns2:Limit>{ xs:float(data($recordt/@LimiteMonto)) }</ns2:Limit>
					<ns2:Currency>{ fn-bea:trim(data($recordt/@Moneda)) }</ns2:Currency>
					<ns2:ExchangeFactor>{ xs:float(data($recordt/@FactorCambio)) }</ns2:ExchangeFactor>
					<ns2:Balance>{ xs:float(data($recordt/@SaldoActual)) }</ns2:Balance>
					<ns2:ArrearBalance>{ xs:float(data($recordt/@SaldoMora)) }</ns2:ArrearBalance>
					<ns2:ArrearLevel>{ data($recordt/@nivelMora) }</ns2:ArrearLevel>
					<ns2:Period>{ data($recordt/@periodoInfo) }</ns2:Period>
					<ns2:OpeningDate>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordt/@FechaApertura))) }</ns2:OpeningDate>
					{
					if(data($recordt/@FechaCancelacion) != "00/00/0000")then (
					<ns2:CancelationDate>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordt/@FechaCancelacion))) }</ns2:CancelationDate>
					)else ()
					}
					<ns2:Installment>{ xs:float(data($recordt/@Cuota)) }</ns2:Installment>
					{
					for $recordht in $responseData/*:RECORDHT/*:CUENTA[@noReferencia = $recordt/@noReferencia]
					return(
					<ns2:HistoricalArrear>{ data($recordht/@MoraHistorica) }</ns2:HistoricalArrear>,
					<ns2:HistoricalCountLoc>{ data($recordht/@conteoHistoricoLoc) }</ns2:HistoricalCountLoc>,
					<ns2:HistoricalCountDol>{ data($recordht/@conteoHistoricoDol) }</ns2:HistoricalCountDol>
					)
					}
				</ns2:Reference>
				)
				)else()
				}
			</ns2:ActiveReferences>
			<ns2:HistoricalReferences>
				{
				if(count($responseData/*:RECORDPRB/*:CUENTA) > 0) then (
				for $recordprb in $responseData/*:RECORDPRB/*:CUENTA
				return(
				<ns2:Reference>
					{
					if(data($recordprb/@idEstudio) != "") then (
					<ns2:QueryId>{ data($recordprb/@idEstudio) }</ns2:QueryId>
					)else ()
					}
					<ns2:Creditor>{ fn-bea:trim(data($recordprb/@Acreedor)) }</ns2:Creditor>
					<ns2:ReferenceNumber>{ fn-bea:trim(data($recordprb/@noReferencia)) }</ns2:ReferenceNumber>
					<ns2:Type>{ data($recordprb/@TipoReferencia) }</ns2:Type>
					<ns2:CreditType>{ fn-bea:trim(data($recordprb/@TipoPrestamo)) }</ns2:CreditType>
					<ns2:Status>{ fn-bea:trim(data($recordprb/@Estado)) }</ns2:Status>
					<ns2:Limit>{ xs:float(data($recordprb/@LimiteMonto)) }</ns2:Limit>
					<ns2:Currency>{ fn-bea:trim(data($recordprb/@Moneda)) }</ns2:Currency>
					<ns2:Balance>{ xs:float(data($recordprb/@SaldoActual)) }</ns2:Balance>
					<ns2:PaymentMethod>{ fn-bea:trim(data($recordprb/@FormaPago)) }</ns2:PaymentMethod>
					<ns2:Guarantee>{ xs:float(data($recordprb/@ValorGarantia)) }</ns2:Guarantee>
					<ns2:GuaranteeType>{ fn-bea:trim(data($recordprb/@TipoGarantia)) }</ns2:GuaranteeType>
					<ns2:ArrearBalance>{ xs:float(data($recordprb/@SaldoMora)) }</ns2:ArrearBalance>
					<ns2:ArrearLevel>{ fn-bea:trim(data($recordprb/@nivelMora)) }</ns2:ArrearLevel>
					<ns2:DueBalance>{ xs:float(data($recordprb/@SaldoVencido)) }</ns2:DueBalance>
					<ns2:InExecution>{ xs:float(data($recordprb/@SaldoCobroJudicial)) }</ns2:InExecution>
					<ns2:PunishedBalance>{ xs:float(data($recordprb/@SaldoCastigado)) }</ns2:PunishedBalance>
					<ns2:Period>{ data($recordprb/@periodoInfo) }</ns2:Period>
					<ns2:OpeningDate>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordprb/@FechaApertura))) }</ns2:OpeningDate>
					{
					if(data($recordprb/@FechaCancelacion) != "00/00/0000")then (
					<ns2:CancelationDate>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("yyyyMMdd",data($recordprb/@FechaCancelacion))) }</ns2:CancelationDate>
					) else ()
					}
					{
					if(data($recordprb/@FechaVencimiento) != "00/00/0000")then (
					<ns2:ExpirationDate>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordprb/@FechaVencimiento))) }</ns2:ExpirationDate>
					) else ()
					}
					<ns2:Installment>{ xs:float(data($recordprb/@Cuota)) }</ns2:Installment>
					<ns2:HistoricalArrear>{ fn-bea:trim(data($recordprb/@MoraHistorica)) }</ns2:HistoricalArrear>
					<ns2:HistoricalCountLoc>{ fn-bea:trim(data($recordprb/@conteoHistoricoLoc)) }</ns2:HistoricalCountLoc>
					<ns2:HistoricalCountDol>{ fn-bea:trim(data($recordprb/@conteoHistoricoDol)) }</ns2:HistoricalCountDol>
				</ns2:Reference>
				)
				)else()
				}
				{
				if(count($responseData/*:RECORDPRD/*:CUENTA) > 0) then (
				for $recordprd in $responseData/*:RECORDPRD/*:CUENTA
				return(
				<ns2:Reference>
					{
					if(data($recordprd/@idEstudio) != "") then (
					<ns2:QueryId>{ data($recordprd/@idEstudio) }</ns2:QueryId>
					)else ()
					}
					<ns2:Creditor>{ fn-bea:trim(data($recordprd/@Acreedor)) }</ns2:Creditor>
					<ns2:ReferenceNumber>{ data($recordprd/@noReferencia) }</ns2:ReferenceNumber>
					<ns2:Type>{ data($recordprd/@TipoReferencia) }</ns2:Type>
					<ns2:CreditType>{ fn-bea:trim(data($recordprd/@TipoPrestamo)) }</ns2:CreditType>
					<ns2:Status>{ data($recordprd/@Estado) }</ns2:Status>
					<ns2:Limit>{ xs:float(data($recordprd/@LimiteMonto)) }</ns2:Limit>
					<ns2:Term>{ xs:float(data($recordprd/@Plazo)) }</ns2:Term>
					<ns2:Currency>{ fn-bea:trim(data($recordprd/@Moneda)) }</ns2:Currency>
					<ns2:ExchangeFactor>{ xs:float(data($recordprd/@FactorCambio)) }</ns2:ExchangeFactor>
					<ns2:Balance>{ xs:float(data($recordprd/@SaldoActual)) }</ns2:Balance>
					<ns2:MinPayment>{ xs:float(data($recordprd/@Cuota)) }</ns2:MinPayment>
					<ns2:GuaranteeType>{ fn-bea:trim(data($recordprd/@TipoGarantia)) }</ns2:GuaranteeType>
					<ns2:ArrearBalance>{ xs:float(data($recordprd/@SaldoMora)) }</ns2:ArrearBalance>
					<ns2:ArrearLevel>{ data($recordprd/@nivelMora) }</ns2:ArrearLevel>
					<ns2:Period>{ data($recordprd/@periodoInfo) }</ns2:Period>
					<ns2:OpeningDate>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordprd/@FechaApertura))) }</ns2:OpeningDate>
					{
					if(data($recordprd/@FechaCancelacion) != "00/00/0000")then (
					<ns2:CancelationDate>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordprd/@FechaCancelacion))) }</ns2:CancelationDate>
					) else ()
					}
					{
					if(data($recordprd/@FechaVencimiento) != "00/00/0000")then (
					<ns2:ExpirationDate>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordprd/@FechaVencimiento))) }</ns2:ExpirationDate>
					) else ()
					}
					<ns2:Installment>{ xs:float(data($recordprd/@Cuota)) }</ns2:Installment>
					<ns2:HistoricalArrear>{ fn-bea:trim(data($recordprd/@MoraHistorica)) }</ns2:HistoricalArrear>
					<ns2:HistoricalCountLoc>{ fn-bea:trim(data($recordprd/@conteoHistoricoLoc)) }</ns2:HistoricalCountLoc>
					<ns2:HistoricalCountDol>{ fn-bea:trim(data($recordprd/@conteoHistoricoDol)) }</ns2:HistoricalCountDol>
				</ns2:Reference>
				)
				)else()
				}
				{
				if(count($responseData/*:RECORDPRT/*:CUENTA) > 0) then (
				for $recordprt in $responseData/*:RECORDPRT/*:CUENTA
				return(
				<ns2:Reference>
					{
					if(data($recordprt/@idEstudio) != "") then (
					<ns2:QueryId>{ data($recordprt/@idEstudio) }</ns2:QueryId>
					) else ()
					}
					<ns2:Creditor>{ fn-bea:trim(data($recordprt/@Acreedor)) }</ns2:Creditor>
					<ns2:ReferenceNumber>{ data($recordprt/@noReferencia) }</ns2:ReferenceNumber>
					<ns2:Type>{ data($recordprt/@TipoReferencia) }</ns2:Type>
					<ns2:CreditType>{ fn-bea:trim(data($recordprt/@TipoPrestamo)) }</ns2:CreditType>
					<ns2:Status>{ fn-bea:trim(data($recordprt/@Estado)) }</ns2:Status>
					<ns2:Limit>{ xs:float(data($recordprt/@LimiteMonto)) }</ns2:Limit>
					<ns2:Currency>{ fn-bea:trim(data($recordprt/@Moneda)) }</ns2:Currency>
					<ns2:ExchangeFactor>{ xs:float(data($recordprt/@FactorCambio)) }</ns2:ExchangeFactor>
					<ns2:Balance>{ xs:float(data($recordprt/@SaldoActual)) }</ns2:Balance>
					<ns2:ArrearBalance>{ xs:float(data($recordprt/@SaldoMora)) }</ns2:ArrearBalance>
					<ns2:ArrearLevel>{ data($recordprt/@nivelMora) }</ns2:ArrearLevel>
					<ns2:Period>{ data($recordprt/@periodoInfo) }</ns2:Period>
					<ns2:OpeningDate>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordprt/@FechaApertura))) }</ns2:OpeningDate>
					{
					if(data($recordprt/@FechaCancelacion) != "00/00/0000")then (
					<ns2:CancelationDate>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordprt/@FechaCancelacion))) }</ns2:CancelationDate>
					) else ()
					}
					{
					if(data($recordprt/@FechaVencimiento) != "00/00/0000")then (
					<ns2:ExpirationDate>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("yyyyMMdd",data($recordprt/@FechaVencimiento))) }</ns2:ExpirationDate>
					) else ()
					}
					<ns2:Installment>{ xs:float(data($recordprt/@Cuota)) }</ns2:Installment>
					<ns2:HistoricalArrear>{ fn-bea:trim(data($recordprt/@MoraHistorica)) }</ns2:HistoricalArrear>
					<ns2:HistoricalCountLoc>{ fn-bea:trim(data($recordprt/@conteoHistoricoLoc)) }</ns2:HistoricalCountLoc>
					<ns2:HistoricalCountDol>{ fn-bea:trim(data($recordprt/@conteoHistoricoDol)) }</ns2:HistoricalCountDol>
				</ns2:Reference>
				)
				)else()
				}
			</ns2:HistoricalReferences>
		</ns2:ReferencesDetails>
	</ns2:LoanOriginations>        </ns2:GetConsolidatedCustomerRisk>
    </ns2:getConsolidatedCustomerRiskResponse>
};

xq:Tx_consulta_ONBASE_V2_To_GetConsolidatedCustomerRiskResponse($responseData,$uuid)