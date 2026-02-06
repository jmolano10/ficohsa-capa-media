xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns1:consultaConsolidadaRiesgoClienteResponse" location="../xsd/consultaConsolidadaRiesgoClienteTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaConsolidadaRiesgoCliente/xq/consultaConsolidadaRiesgoClienteOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes";

declare function xf:consultaConsolidadaRiesgoClienteOut($responseData as element(*))
    as element(ns1:consultaConsolidadaRiesgoClienteResponse) {
         

<ns1:consultaConsolidadaRiesgoClienteResponse>
    <LOAN_MAINTENANCE>
        <CUSTOMER_INFO>
        			{
        				for $IDENTIDAD in $responseData/IDENTIDAD
        				return
        				
            
            <ID>{ data($IDENTIDAD) }</ID>
        			}
        			{
        				for $TARGET in $responseData/SEGMENTOCLIENTE
        				return
        				
            
            <TARGET>{ data($TARGET) }</TARGET>        				
        			}
        			{
        				for $DATE_OF_BIRTH in $responseData/FECHANACIMIENTO
        				return
        				
            
            <DATE_OF_BIRTH>{ fn-bea:date-from-string-with-format("yyyy-MM-dd",data($DATE_OF_BIRTH)) }</DATE_OF_BIRTH>
        			}
        			{
        				for $AGE in $responseData/EDAD
        				return
        				
            
            <AGE>{ xs:int(data($AGE)) }</AGE>
        			}
        			{
        				for $TYPE in $responseData/TIPOCLIENTE
        				return
        				
            
            <TYPE>{ data($TYPE) }</TYPE>
        			}
        			{
        				for $SALARY in $responseData/SALARIOCLIENTE
        				return
        				
            
            <SALARY>{ data($SALARY) }</SALARY>
        			}
        			{
        				for $PAYROLL_SALARY in $responseData/MONTOLPSPLANILLA
        				return
        				
            
            <PAYROLL_SALARY>{ data($PAYROLL_SALARY) }</PAYROLL_SALARY>
        			}
        			{
        				for $CREDIT_MONTHS in $responseData/MESPLANILLA
        				return
        				
            
            <CREDIT_MONTHS>{ data($CREDIT_MONTHS) }</CREDIT_MONTHS>
        			}
        			{
        				for $FLAG_BLAZE in $responseData/FLAGBLAZE
        				return
        				
            
            <FLAG_BLAZE>{ data($FLAG_BLAZE) }</FLAG_BLAZE>
        			}
        			{
        				for $FLAG_HIT in $responseData/FLAGHIT
        				return
        				
            
            <FLAG_HIT>{ data($FLAG_HIT) }</FLAG_HIT>
        			}
                    {
        				for $EVALUATION_RESULT in $responseData/RECORDEVALUACION/CUENTA[1]
        				return
        				
            
            <EVALUATION_RESULT>{ data($EVALUATION_RESULT/@resultadoEvaluacion) }</EVALUATION_RESULT>
        			}
                    { 
                       if(count($responseData/RECORDA/CUENTA) > 0) then (
                       
            
            <ADDRESSES_INFO>
                    {
                       for $recorda in $responseData/RECORDA/CUENTA
        			    return(
                        
                
                <ADDRESS_ITEM>
                    <PERIOD>{ data($recorda/@informationPeriod) }</PERIOD>
                    <ADDRESS>{ fn-bea:trim(data($recorda/@debtorAddress)) }</ADDRESS>
                </ADDRESS_ITEM>
                        )
                    }
                      
            
            </ADDRESSES_INFO>
                    )else ()
                    }
                    {
                      if(count($responseData/RECORDTEL/CUENTA) > 0) then (
                       
            
            <PHONES_INFO>
                      {
                       for $recordtel in $responseData/RECORDTEL/CUENTA
        			    return(
                        
                
                <PHONE_ITEM>
                    <PERIOD>{ data($recordtel/@periodoInformacion) }</PERIOD>
                    <PHONE>{ fn-bea:trim(data($recordtel/@numeroTelefono)) }</PHONE>
                </PHONE_ITEM>
                        )
                      }
                     
            
            </PHONES_INFO>
                    )else ()
                    }
                    {
                      if(count($responseData/RECORDH/CUENTA) > 0) then (
                       
            
            <ADMINISTRATIVE_CHARGES>
                       {
                       for $recordh in $responseData/RECORDH/CUENTA
        			    return(
                          
                
                <CHARGE>
                    <ID>{ data($recordh/@viewId) }</ID>
                           {
                              if(data($recordh/@infoDate) != "00/00/0000")then (
      
                               
                    
                    <INFORMATION_DATE>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordh/@infoDate))) }</INFORMATION_DATE>
                               )else ()
                           }
                           {
                              if(data($recordh/@inDate) != "00/00/0000")then (
      
                               
                    
                    <IN_DATE>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordh/@inDate))) }</IN_DATE>
                               )else ()
                           }
                           
                    
                    <CREDITOR>{ fn-bea:trim(data($recordh/@creditor)) }</CREDITOR>
                    <MOTIVATION>{ fn-bea:trim(data($recordh/@inMotivation)) }</MOTIVATION>
                    <CURRENCY>{ fn-bea:trim(data($recordh/@currency)) }</CURRENCY>
                    <TOTAL_DEBT_AMOUNT>{ xs:decimal(data($recordh/@totalDebtAmount)) }</TOTAL_DEBT_AMOUNT>
                    <EXCHANGE_FACTOR>{ xs:decimal(data($recordh/@changeFactor)) }</EXCHANGE_FACTOR>
                </CHARGE>
                        )
                        }
                       
            
            </ADMINISTRATIVE_CHARGES>
                      )else ()
                    }
                    {
                      if(count($responseData/RECORDS/CUENTA) > 0) then (
                       
            
            <CURRENT_ARREAR_SUMMARY>
                       {
                       for $records in $responseData/RECORDS/CUENTA
        			    return(
                        
                          
                
                <ARREAR>
                    <ID>{ data($records/@viewId) }</ID>
                           {
                              if(data($records/@infoDate) != "00/00/0000")then (
      
                               
                    
                    <INFORMATION_DATE>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($records/@infoDate))) }</INFORMATION_DATE>
                               )else ()
                           }
                           {
                              if(data($records/@dwellDate) != "00/00/0000")then (
      
                               
                    
                    <DATE>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($records/@dwellDate))) }</DATE>
                               )else ()
                           }
                           
                    
                    <CREDITOR>{ fn-bea:trim(data($records/@creditor)) }</CREDITOR>
                    <ACCOUNT_TYPE>{ fn-bea:trim(data($records/@accountType)) }</ACCOUNT_TYPE>
                    <CURRENCY>{ fn-bea:trim(data($records/@currency)) }</CURRENCY>
                    <DAYS>{ xs:int(data($records/@dwellDays)) }</DAYS>
                    <AMOUNT>{ xs:decimal(data($records/@dwellAmount)) }</AMOUNT>
                    <EXCHANGE_FACTOR>{ xs:decimal(data($records/@changeFactor)) }</EXCHANGE_FACTOR>
                </ARREAR>
                        )
                        }
                       
            
            </CURRENT_ARREAR_SUMMARY>
                      )else ()
                    }
                    {
        				for $EXTERNAL_SCORE in $responseData/EQX_CONTROL/CUENTA
        				return
        				
            
            <EXTERNAL_SCORE>{ data($EXTERNAL_SCORE/@ValorScore) }</EXTERNAL_SCORE>
        			}
        			
            
            <SCORE_INFO>
        				{
        					for $SCORE_CALCULATION in $responseData/BLAZE_DATA_PTMO/CUENTA/@scoreMC
        					return
        					
                
                <SCORE_CALCULATION>{ xs:float(data($SCORE_CALCULATION)) }</SCORE_CALCULATION>	
        				}
        				{
        					for $QUALIFICATION in $responseData/CALIFICACIONSCORE
        					return
        					
                
                <QUALIFICATION>{ data($QUALIFICATION) }</QUALIFICATION>	
        				}
        				{
        					for $RISK_LEVEL in $responseData/NIVELRIESGO
        					return
        					
                
                <RISK_LEVEL>{ data($RISK_LEVEL) }</RISK_LEVEL>
        				}
        			
            
            </SCORE_INFO>
        			{
        				if(count($responseData/PASIVOS/CUENTA) > 0) then (
        					
            
            <ASSETS>
        						{
        							for $asset in $responseData/PASIVOS/CUENTA
        							return(
        								
                
                <ASSET>
                    <NUMBER>{ data($asset/@NUMEROCUENTA) }</NUMBER>
                    <CATEGORY>{ data($asset/@CATEGORIA) }</CATEGORY>
                    <CURRENCY>{ data($asset/@MONEDA) }</CURRENCY>
                    <OPENING_DATE>{ fn-bea:date-from-string-with-format("yyyy-MM-dd",data($asset/@FECHAAPERTURA)) }</OPENING_DATE>
                    <CURRENT_BALANCE>{ xs:float(data($asset/@SALDOACTUAL)) }</CURRENT_BALANCE>
                    <END_OF_MONTH_BALANCE>{ xs:float(data($asset/@SALDOFINMES)) }</END_OF_MONTH_BALANCE>
                    <AVERAGE_BALANCE>{ xs:float(data($asset/@SALDOPROMEDIO)) }</AVERAGE_BALANCE>
        								    {
                                                if($responseData/TRANSACCIONESPASIVOS/CUENTA/@Cuenta = $asset/@NUMEROCUENTA) then (
                                                
                    
                    <PRODUCT_TRANSACTIONS>
                                                {
        										for $transaction in $responseData/TRANSACCIONESPASIVOS/CUENTA[@Cuenta = $asset/@NUMEROCUENTA]
        										return(
        											
                        
                        <TRANSACTION>
                            <PERIOD_DATE>{ fn-bea:dateTime-from-string-with-format("yyyy-MM-dd",data($transaction/@FECHAFINDEPERIODO)) }</PERIOD_DATE>
                            <PERIOD_BALANCE>{ data($transaction/@SALDOFIN) }</PERIOD_BALANCE>
                            <MAX_BALANCE>{ data($transaction/@SALDOMAX) }</MAX_BALANCE>
                            <MIN_BALANCE>{ data($transaction/@SALDOMIN) }</MIN_BALANCE>
                            <AVERAGE_BALANCE>{ data($transaction/@SALDOPROMEDIO) }</AVERAGE_BALANCE>
                            <LAST_CREDIT_DATE>{ data($transaction/@FECHAULTIMOCREDITO) }</LAST_CREDIT_DATE>
                            <LAST_DEBIT_DATE>{ data($transaction/@FECHAULTIMODEBITO) }</LAST_DEBIT_DATE>
                            <FACILITIES>{ data($transaction/@FLAGFACILIDADESCUENTA) }</FACILITIES>
                            <LEGAL_REPRESENTATIVE>{ data($transaction/@FLAGREPRESENTANTELEGAL) }</LEGAL_REPRESENTATIVE>
                            <PAYROLL_ACCOUNTS>{ data($transaction/@FLAGCUENTAPLANILLA) }</PAYROLL_ACCOUNTS>
                            <PAYROLL_CREDIT_AMOUNT>{ data($transaction/@MONTOACREDITADOPLANILLA) }</PAYROLL_CREDIT_AMOUNT>
                            <JOINT_ACCOUNTS>{ data($transaction/@FLAGCUENTAMANCOMUNADA) }</JOINT_ACCOUNTS>
                            <PRODUCT_BLOCK>{ data($transaction/@FLAGBLOQUEOCUENTA) }</PRODUCT_BLOCK>
                            <CREDITS_INFO>
                                <AMOUNT_ON_PERIOD>{ data($transaction/@MONTOCREDITOS) }</AMOUNT_ON_PERIOD>
                                <SUMMATION>{ data($transaction/@NUMEROCREDITOS) }</SUMMATION>
                                <INTEREST_ON_PERIOD>{ data($transaction/@NUMEROINTERESESCREDITOS) }</INTEREST_ON_PERIOD>
                                <INTERESTS_SUMMATION>{ data($transaction/@MONTOINTERESESCREDITOS) }</INTERESTS_SUMMATION>
                            </CREDITS_INFO>
                            <DEBITS_INFO>
                                <AMOUNT_ON_PERIOD>{ data($transaction/@MONTODEBITOS) }</AMOUNT_ON_PERIOD>
                                <SUMMATION>{ data($transaction/@NUMERODEBITOS) }</SUMMATION>
                                <INTEREST_ON_PERIOD>{ data($transaction/@NUMEROINTERESESDEBITOS) }</INTEREST_ON_PERIOD>
                                <INTERESTS_SUMMATION>{ data($transaction/@MONTOINTERESESDEBITOS) }</INTERESTS_SUMMATION>
                            </DEBITS_INFO>
                        </TRANSACTION>
        										  )
                                                 }
                                                
                                               
                    
                    </PRODUCT_TRANSACTIONS>
                                               )else ()
        								  }
        								
                
                </ASSET>
        							)
        						}
        					
            
            </ASSETS>
        				) else()
        			}
        			
            
            <LIABILITIES>
        				{
        					if(count($responseData/TARJETAS/CUENTA) > 0) then (
        						
                
                <CREDIT_CARDS_INFO>
        							{
        								for $card in $responseData/TARJETAS/CUENTA
        								return(
        									
                    
                    <CREDIT_CARD>
                        <ACCOUNT>{ data($card/@NUMEROCUENTA) }</ACCOUNT>
                        <BEHAVIOR_SCORE>{ xs:float(data($card/@BEHAVIORSCORE)) }</BEHAVIOR_SCORE>
                        <QUALIFICATION_SCORE>{ xs:string(data($card/@CALIFICACIONSCORE)) }</QUALIFICATION_SCORE>
                        <QUALIFICATION_CUSTOMER_SCORE>{ xs:string(data($card/@CALIFICACIONSCORECLIENTE)) }</QUALIFICATION_CUSTOMER_SCORE>
                        <STATUS>{ data($card/@ESTADO) }</STATUS>
                        <AFFINITY_GROUP>{ data($card/@GRUPOAFINIDAD) }</AFFINITY_GROUP>
                        <PRODUCT>{ data($card/@PRODUCTO) }</PRODUCT>
                        <CLEARING_MODEL>{ xs:int(data($card/@MODELOLIQUIDACION)) }</CLEARING_MODEL>
                        <OPENING_DATE>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", data($card/@FECHAAPERTURA)) }</OPENING_DATE>
                        <CANCELATION_DATE>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", data($card/@FECHACANCELACION)) }</CANCELATION_DATE>
                        <LAST_EXTRA_DATE>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", data($card/@FECHAULTIMOEXTRA)) }</LAST_EXTRA_DATE>
                        <CURRENT_DUE>{ xs:int(data($card/@MORAACTUAL)) }</CURRENT_DUE>
                        <CURRENT_LIMIT>{ xs:float(data($card/@LIMITEACTUAL)) }</CURRENT_LIMIT>
                        <CURRENT_BALANCE>{ xs:float(data($card/@SALDOACTUAL)) }</CURRENT_BALANCE>
                        <CLOSING_BALANCE>{ xs:float(data($card/@SALDOCORTE)) }</CLOSING_BALANCE>
                        <EXTRA_BALANCE>{ xs:float(data($card/@SALDOEXTRA)) }</EXTRA_BALANCE>
                        <INTRA_BALANCE>{ xs:float(data($card/@SALDOINTRA)) }</INTRA_BALANCE>
                        <ACTIVE_EXTRA_INSTALLMENTS>{ xs:float(data($card/@CUOTASEXTRAVIGENTES)) }</ACTIVE_EXTRA_INSTALLMENTS>
                        <LOCKCODE1>{ data($card/@CODBLOQUE1) }</LOCKCODE1>
                        <LOCKCODE2>{ data($card/@CODBLOQUE2) }</LOCKCODE2>
                        <LOGO>{ data($card/@GRUPOAFINIDAD) }</LOGO>
        										{
	        										let $disponible := (data($card/@DISPONIBLE_1), data($card/@DISPONIBLE_2), data($card/@DISPONIBLE_3), data($card/@DISPONIBLE_4), data($card/@DISPONIBLE_5), data($card/@DISPONIBLE_6), data($card/@DISPONIBLE_7),
	        										data($card/@DISPONIBLE_8), data($card/@DISPONIBLE_9), data($card/@DISPONIBLE_10), data($card/@DISPONIBLE_11), data($card/@DISPONIBLE_12) )
	        										return
	        											
                        
                        <AVAILABLE_CASH>{ sum($disponible) }</AVAILABLE_CASH>
	        									}
        										
                        
                        <LOCK_DATE1>{ data($card/@FECBLOQUE1) }</LOCK_DATE1>
                        <LOCK_DATE2>{ data($card/@FECBLOQUE2) }</LOCK_DATE2>
                        <BIN>{ data($card/@PRODUCTO) }</BIN>
                        <EXTRA_APPROVAL_DATE>{ data($card/@FECHA_APROBACION_EXTRA) }</EXTRA_APPROVAL_DATE>
                        <INTRA_APPROVAL_DATE>{ data($card/@FECHA_APROBACION_EXTRA) }</INTRA_APPROVAL_DATE>
                        <PIL_APPROVAL_DATE>{ data($card/@FECHA_APROBACION_INTRA) }</PIL_APPROVAL_DATE>
                        <PRIOR_LIMIT>{ data($card/@LIMITE_PREVIO) }</PRIOR_LIMIT>
                        <AUTH_BALANCE>{ data($card/@SALDO_AUTORIZACION) }</AUTH_BALANCE>
                        <PRODUCT_TRANSACTIONS>{ data($card/@SALDO_AUTORIZACION ) }</PRODUCT_TRANSACTIONS>
        										{
                                                    if($responseData/TRANSACCIONESTARJETA/CUENTA/@NUMEROCUENTA = $card/@NUMEROCUENTA) then (
                                                      
                        
                        <PRODUCT_TRANSACTIONS>
                                                      {
        												for $transaction in $responseData/TRANSACCIONESTARJETA/CUENTA[@NUMEROCUENTA = $card/@NUMEROCUENTA]
        												return(
        													
                            
                            <TRANSACTION>
                                <PERIOD_DATE>{ data($transaction/@FECHACORTE_1) }</PERIOD_DATE>
                                <PERIOD_BALANCE>{ data($transaction/@SALDOCORTE_1) }</PERIOD_BALANCE>
                                <AMOUNT_DUE>{ data($transaction/@PAGOMINIMO_1) }</AMOUNT_DUE>
                                <PAYMENTS>{ data($transaction/@PAGOS_1) }</PAYMENTS>
                                <MERCH_SALES>{ data($transaction/@CONSUMOS_1) }</MERCH_SALES>
                                <CASH_WITHDRAWAL>{ data($transaction/@RETIROS_1) }</CASH_WITHDRAWAL>
                                <LIMIT>{ data($transaction/@LIMITE_1) }</LIMIT>
                                <OTHER_TRANSACTIONS>{ data($transaction/@OTRASTRANSACCIONES_1) }</OTHER_TRANSACTIONS>
                                <INTEREST>{ data($transaction/@INTERESES_1) }</INTEREST>
                                <TOTAL_FEES>{ data($transaction/@TOTALCARGOS_1) }</TOTAL_FEES>
                                <OTHER_DEBITS>{ data($transaction/@OTROSDEBITOS_1) }</OTHER_DEBITS>
                                <CYCLE_DUE>{ data($transaction/@MORA_1) }</CYCLE_DUE>
                                <CYCLE_TOTAL_BALANCE>{ data($transaction/@SALDOTOTAL_1) }</CYCLE_TOTAL_BALANCE>
                                <EXTRA_CASH_INFO>
                                    <BALANCE>{ data($transaction/@SALDOEXTRA_1) }</BALANCE>
                                    <INSTALLMENT>{ data($transaction/@CUOTAEXTRA_1) }</INSTALLMENT>
                                    <INTEREST>{ data($transaction/@INTERESESEXTRA_1) }</INTEREST>
                                    <FEE>{ data($transaction/@CARGOSINTRA_1) }</FEE>
                                </EXTRA_CASH_INFO>
                                <INTRA_CASH_INFO>
                                    <BALANCE>{ data($transaction/@SALDOINTRA_1) }</BALANCE>
                                    <INSTALLMENT>{ data($transaction/@CUOTAINTRA_1) }</INSTALLMENT>
                                    <INTEREST>{ data($transaction/@INTERESESINTRA_1) }</INTEREST>
                                    <FEE>{ data($transaction/@CARGOSINTRA_1) }</FEE>
                                </INTRA_CASH_INFO>
                                <EXTRA_FEE>{ data($transaction/@CUOTAEXTRA_1) }</EXTRA_FEE>
                                <INTRA_FEE>{ data($transaction/@COUTAINTRA_1) }</INTRA_FEE>
                                <EXTRA_BALANCE>{ data($transaction/@SALDOEXTRA_1) }</EXTRA_BALANCE>
                                <INTRA_BALANCE>{ data($transaction/@SALDOINTRA_1) }</INTRA_BALANCE>
                            </TRANSACTION>,
                                                            
                            
                            <TRANSACTION>
                                <PERIOD_DATE>{ data($transaction/@FECHACORTE_2) }</PERIOD_DATE>
                                <PERIOD_BALANCE>{ data($transaction/@SALDOCORTE_2) }</PERIOD_BALANCE>
                                <AMOUNT_DUE>{ data($transaction/@PAGOMINIMO_2) }</AMOUNT_DUE>
                                <PAYMENTS>{ data($transaction/@PAGOS_2) }</PAYMENTS>
                                <MERCH_SALES>{ data($transaction/@CONSUMOS_2) }</MERCH_SALES>
                                <CASH_WITHDRAWAL>{ data($transaction/@RETIROS_2) }</CASH_WITHDRAWAL>
                                <LIMIT>{ data($transaction/@LIMITE_2) }</LIMIT>
                                <OTHER_TRANSACTIONS>{ data($transaction/@OTRASTRANSACCIONES_2) }</OTHER_TRANSACTIONS>
                                <INTEREST>{ data($transaction/@INTERESES_2) }</INTEREST>
                                <TOTAL_FEES>{ data($transaction/@TOTALCARGOS_2) }</TOTAL_FEES>
                                <OTHER_DEBITS>{ data($transaction/@OTROSDEBITOS_2) }</OTHER_DEBITS>
                                <CYCLE_DUE>{ data($transaction/@MORA_2) }</CYCLE_DUE>
                                <CYCLE_TOTAL_BALANCE>{ data($transaction/@SALDOTOTAL_2) }</CYCLE_TOTAL_BALANCE>
                                <EXTRA_CASH_INFO>
                                    <BALANCE>{ data($transaction/@SALDOEXTRA_2) }</BALANCE>
                                    <INSTALLMENT>{ data($transaction/@CUOTAEXTRA_2) }</INSTALLMENT>
                                    <INTEREST>{ data($transaction/@INTERESESEXTRA_2) }</INTEREST>
                                    <FEE>{ data($transaction/@CARGOSINTRA_2) }</FEE>
                                </EXTRA_CASH_INFO>
                                <INTRA_CASH_INFO>
                                    <BALANCE>{ data($transaction/@SALDOINTRA_2) }</BALANCE>
                                    <INSTALLMENT>{ data($transaction/@CUOTAINTRA_2) }</INSTALLMENT>
                                    <INTEREST>{ data($transaction/@INTERESESINTRA_2) }</INTEREST>
                                    <FEE>{ data($transaction/@CARGOSINTRA_2) }</FEE>
                                </INTRA_CASH_INFO>
                                <EXTRA_FEE>{ data($transaction/@CUOTAEXTRA_2) }</EXTRA_FEE>
                                <INTRA_FEE>{ data($transaction/@COUTAINTRA_2) }</INTRA_FEE>
                                <EXTRA_BALANCE>{ data($transaction/@SALDOEXTRA_2) }</EXTRA_BALANCE>
                                <INTRA_BALANCE>{ data($transaction/@SALDOINTRA_2) }</INTRA_BALANCE>
                            </TRANSACTION>,
                                                           
                            
                            <TRANSACTION>
                                <PERIOD_DATE>{ data($transaction/@FECHACORTE_3) }</PERIOD_DATE>
                                <PERIOD_BALANCE>{ data($transaction/@SALDOCORTE_3) }</PERIOD_BALANCE>
                                <AMOUNT_DUE>{ data($transaction/@PAGOMINIMO_3) }</AMOUNT_DUE>
                                <PAYMENTS>{ data($transaction/@PAGOS_3) }</PAYMENTS>
                                <MERCH_SALES>{ data($transaction/@CONSUMOS_3) }</MERCH_SALES>
                                <CASH_WITHDRAWAL>{ data($transaction/@RETIROS_3) }</CASH_WITHDRAWAL>
                                <LIMIT>{ data($transaction/@LIMITE_3) }</LIMIT>
                                <OTHER_TRANSACTIONS>{ data($transaction/@OTRASTRANSACCIONES_3) }</OTHER_TRANSACTIONS>
                                <INTEREST>{ data($transaction/@INTERESES_3) }</INTEREST>
                                <TOTAL_FEES>{ data($transaction/@TOTALCARGOS_3) }</TOTAL_FEES>
                                <OTHER_DEBITS>{ data($transaction/@OTROSDEBITOS_3) }</OTHER_DEBITS>
                                <CYCLE_DUE>{ data($transaction/@MORA_3) }</CYCLE_DUE>
                                <CYCLE_TOTAL_BALANCE>{ data($transaction/@SALDOTOTAL_3) }</CYCLE_TOTAL_BALANCE>
                                <EXTRA_CASH_INFO>
                                    <BALANCE>{ data($transaction/@SALDOEXTRA_3) }</BALANCE>
                                    <INSTALLMENT>{ data($transaction/@CUOTAEXTRA_3) }</INSTALLMENT>
                                    <INTEREST>{ data($transaction/@INTERESESEXTRA_3) }</INTEREST>
                                    <FEE>{ data($transaction/@CARGOSINTRA_3) }</FEE>
                                </EXTRA_CASH_INFO>
                                <INTRA_CASH_INFO>
                                    <BALANCE>{ data($transaction/@SALDOINTRA_3) }</BALANCE>
                                    <INSTALLMENT>{ data($transaction/@CUOTAINTRA_3) }</INSTALLMENT>
                                    <INTEREST>{ data($transaction/@INTERESESINTRA_3) }</INTEREST>
                                    <FEE>{ data($transaction/@CARGOSINTRA_3) }</FEE>
                                </INTRA_CASH_INFO>
                                <EXTRA_FEE>{ data($transaction/@CUOTAEXTRA_3) }</EXTRA_FEE>
                                <INTRA_FEE>{ data($transaction/@COUTAINTRA_3) }</INTRA_FEE>
                                <EXTRA_BALANCE>{ data($transaction/@SALDOEXTRA_3) }</EXTRA_BALANCE>
                                <INTRA_BALANCE>{ data($transaction/@SALDOINTRA_3) }</INTRA_BALANCE>
                            </TRANSACTION>,
                                                            
                            
                            <TRANSACTION>
                                <PERIOD_DATE>{ data($transaction/@FECHACORTE_4) }</PERIOD_DATE>
                                <PERIOD_BALANCE>{ data($transaction/@SALDOCORTE_4) }</PERIOD_BALANCE>
                                <AMOUNT_DUE>{ data($transaction/@PAGOMINIMO_4) }</AMOUNT_DUE>
                                <PAYMENTS>{ data($transaction/@PAGOS_4) }</PAYMENTS>
                                <MERCH_SALES>{ data($transaction/@CONSUMOS_4) }</MERCH_SALES>
                                <CASH_WITHDRAWAL>{ data($transaction/@RETIROS_4) }</CASH_WITHDRAWAL>
                                <LIMIT>{ data($transaction/@LIMITE_4) }</LIMIT>
                                <OTHER_TRANSACTIONS>{ data($transaction/@OTRASTRANSACCIONES_4) }</OTHER_TRANSACTIONS>
                                <INTEREST>{ data($transaction/@INTERESES_4) }</INTEREST>
                                <TOTAL_FEES>{ data($transaction/@TOTALCARGOS_4) }</TOTAL_FEES>
                                <OTHER_DEBITS>{ data($transaction/@OTROSDEBITOS_4) }</OTHER_DEBITS>
                                <CYCLE_DUE>{ data($transaction/@MORA_4) }</CYCLE_DUE>
                                <CYCLE_TOTAL_BALANCE>{ data($transaction/@SALDOTOTAL_4) }</CYCLE_TOTAL_BALANCE>
                                <EXTRA_CASH_INFO>
                                    <BALANCE>{ data($transaction/@SALDOEXTRA_4) }</BALANCE>
                                    <INSTALLMENT>{ data($transaction/@CUOTAEXTRA_4) }</INSTALLMENT>
                                    <INTEREST>{ data($transaction/@INTERESESEXTRA_4) }</INTEREST>
                                    <FEE>{ data($transaction/@CARGOSINTRA_4) }</FEE>
                                </EXTRA_CASH_INFO>
                                <INTRA_CASH_INFO>
                                    <BALANCE>{ data($transaction/@SALDOINTRA_4) }</BALANCE>
                                    <INSTALLMENT>{ data($transaction/@CUOTAINTRA_4) }</INSTALLMENT>
                                    <INTEREST>{ data($transaction/@INTERESESINTRA_4) }</INTEREST>
                                    <FEE>{ data($transaction/@CARGOSINTRA_4) }</FEE>
                                </INTRA_CASH_INFO>
                                <EXTRA_FEE>{ data($transaction/@CUOTAEXTRA_4) }</EXTRA_FEE>
                                <INTRA_FEE>{ data($transaction/@COUTAINTRA_4) }</INTRA_FEE>
                                <EXTRA_BALANCE>{ data($transaction/@SALDOEXTRA_4) }</EXTRA_BALANCE>
                                <INTRA_BALANCE>{ data($transaction/@SALDOINTRA_4) }</INTRA_BALANCE>
                            </TRANSACTION>,
                                                            
                            
                            <TRANSACTION>
                                <PERIOD_DATE>{ data($transaction/@FECHACORTE_5) }</PERIOD_DATE>
                                <PERIOD_BALANCE>{ data($transaction/@SALDOCORTE_5) }</PERIOD_BALANCE>
                                <AMOUNT_DUE>{ data($transaction/@PAGOMINIMO_5) }</AMOUNT_DUE>
                                <PAYMENTS>{ data($transaction/@PAGOS_5) }</PAYMENTS>
                                <MERCH_SALES>{ data($transaction/@CONSUMOS_5) }</MERCH_SALES>
                                <CASH_WITHDRAWAL>{ data($transaction/@RETIROS_5) }</CASH_WITHDRAWAL>
                                <LIMIT>{ data($transaction/@LIMITE_5) }</LIMIT>
                                <OTHER_TRANSACTIONS>{ data($transaction/@OTRASTRANSACCIONES_5) }</OTHER_TRANSACTIONS>
                                <INTEREST>{ data($transaction/@INTERESES_5) }</INTEREST>
                                <TOTAL_FEES>{ data($transaction/@TOTALCARGOS_5) }</TOTAL_FEES>
                                <OTHER_DEBITS>{ data($transaction/@OTROSDEBITOS_5) }</OTHER_DEBITS>
                                <CYCLE_DUE>{ data($transaction/@MORA_5) }</CYCLE_DUE>
                                <CYCLE_TOTAL_BALANCE>{ data($transaction/@SALDOTOTAL_5) }</CYCLE_TOTAL_BALANCE>
                                <EXTRA_CASH_INFO>
                                    <BALANCE>{ data($transaction/@SALDOEXTRA_5) }</BALANCE>
                                    <INSTALLMENT>{ data($transaction/@CUOTAEXTRA_5) }</INSTALLMENT>
                                    <INTEREST>{ data($transaction/@INTERESESEXTRA_5) }</INTEREST>
                                    <FEE>{ data($transaction/@CARGOSINTRA_5) }</FEE>
                                </EXTRA_CASH_INFO>
                                <INTRA_CASH_INFO>
                                    <BALANCE>{ data($transaction/@SALDOINTRA_5) }</BALANCE>
                                    <INSTALLMENT>{ data($transaction/@CUOTAINTRA_5) }</INSTALLMENT>
                                    <INTEREST>{ data($transaction/@INTERESESINTRA_5) }</INTEREST>
                                    <FEE>{ data($transaction/@CARGOSINTRA_5) }</FEE>
                                </INTRA_CASH_INFO>
                                <EXTRA_FEE>{ data($transaction/@CUOTAEXTRA_5) }</EXTRA_FEE>
                                <INTRA_FEE>{ data($transaction/@COUTAINTRA_5) }</INTRA_FEE>
                                <EXTRA_BALANCE>{ data($transaction/@SALDOEXTRA_5) }</EXTRA_BALANCE>
                                <INTRA_BALANCE>{ data($transaction/@SALDOINTRA_5) }</INTRA_BALANCE>
                            </TRANSACTION>,
                                                            
                            
                            <TRANSACTION>
                                <PERIOD_DATE>{ data($transaction/@FECHACORTE_6) }</PERIOD_DATE>
                                <PERIOD_BALANCE>{ data($transaction/@SALDOCORTE_6) }</PERIOD_BALANCE>
                                <AMOUNT_DUE>{ data($transaction/@PAGOMINIMO_6) }</AMOUNT_DUE>
                                <PAYMENTS>{ data($transaction/@PAGOS_6) }</PAYMENTS>
                                <MERCH_SALES>{ data($transaction/@CONSUMOS_6) }</MERCH_SALES>
                                <CASH_WITHDRAWAL>{ data($transaction/@RETIROS_6) }</CASH_WITHDRAWAL>
                                <LIMIT>{ data($transaction/@LIMITE_6) }</LIMIT>
                                <OTHER_TRANSACTIONS>{ data($transaction/@OTRASTRANSACCIONES_6) }</OTHER_TRANSACTIONS>
                                <INTEREST>{ data($transaction/@INTERESES_6) }</INTEREST>
                                <TOTAL_FEES>{ data($transaction/@TOTALCARGOS_6) }</TOTAL_FEES>
                                <OTHER_DEBITS>{ data($transaction/@OTROSDEBITOS_6) }</OTHER_DEBITS>
                                <CYCLE_DUE>{ data($transaction/@MORA_6) }</CYCLE_DUE>
                                <CYCLE_TOTAL_BALANCE>{ data($transaction/@SALDOTOTAL_6) }</CYCLE_TOTAL_BALANCE>
                                <EXTRA_CASH_INFO>
                                    <BALANCE>{ data($transaction/@SALDOEXTRA_6) }</BALANCE>
                                    <INSTALLMENT>{ data($transaction/@CUOTAEXTRA_6) }</INSTALLMENT>
                                    <INTEREST>{ data($transaction/@INTERESESEXTRA_6) }</INTEREST>
                                    <FEE>{ data($transaction/@CARGOSINTRA_6) }</FEE>
                                </EXTRA_CASH_INFO>
                                <INTRA_CASH_INFO>
                                    <BALANCE>{ data($transaction/@SALDOINTRA_6) }</BALANCE>
                                    <INSTALLMENT>{ data($transaction/@CUOTAINTRA_6) }</INSTALLMENT>
                                    <INTEREST>{ data($transaction/@INTERESESINTRA_6) }</INTEREST>
                                    <FEE>{ data($transaction/@CARGOSINTRA_6) }</FEE>
                                </INTRA_CASH_INFO>
                                <EXTRA_FEE>{ data($transaction/@CUOTAEXTRA_6) }</EXTRA_FEE>
                                <INTRA_FEE>{ data($transaction/@COUTAINTRA_6) }</INTRA_FEE>
                                <EXTRA_BALANCE>{ data($transaction/@SALDOEXTRA_6) }</EXTRA_BALANCE>
                                <INTRA_BALANCE>{ data($transaction/@SALDOINTRA_6) }</INTRA_BALANCE>
                            </TRANSACTION>,
                                                            
                            
                            <TRANSACTION>
                                <PERIOD_DATE>{ data($transaction/@FECHACORTE_7) }</PERIOD_DATE>
                                <PERIOD_BALANCE>{ data($transaction/@SALDOCORTE_7) }</PERIOD_BALANCE>
                                <AMOUNT_DUE>{ data($transaction/@PAGOMINIMO_7) }</AMOUNT_DUE>
                                <PAYMENTS>{ data($transaction/@PAGOS_7) }</PAYMENTS>
                                <MERCH_SALES>{ data($transaction/@CONSUMOS_7) }</MERCH_SALES>
                                <CASH_WITHDRAWAL>{ data($transaction/@RETIROS_7) }</CASH_WITHDRAWAL>
                                <LIMIT>{ data($transaction/@LIMITE_7) }</LIMIT>
                                <OTHER_TRANSACTIONS>{ data($transaction/@OTRASTRANSACCIONES_7) }</OTHER_TRANSACTIONS>
                                <INTEREST>{ data($transaction/@INTERESES_7) }</INTEREST>
                                <TOTAL_FEES>{ data($transaction/@TOTALCARGOS_7) }</TOTAL_FEES>
                                <OTHER_DEBITS>{ data($transaction/@OTROSDEBITOS_7) }</OTHER_DEBITS>
                                <CYCLE_DUE>{ data($transaction/@MORA_7) }</CYCLE_DUE>
                                <CYCLE_TOTAL_BALANCE>{ data($transaction/@SALDOTOTAL_7) }</CYCLE_TOTAL_BALANCE>
                                <EXTRA_CASH_INFO>
                                    <BALANCE>{ data($transaction/@SALDOEXTRA_7) }</BALANCE>
                                    <INSTALLMENT>{ data($transaction/@CUOTAEXTRA_7) }</INSTALLMENT>
                                    <INTEREST>{ data($transaction/@INTERESESEXTRA_7) }</INTEREST>
                                    <FEE>{ data($transaction/@CARGOSINTRA_7) }</FEE>
                                </EXTRA_CASH_INFO>
                                <INTRA_CASH_INFO>
                                    <BALANCE>{ data($transaction/@SALDOINTRA_7) }</BALANCE>
                                    <INSTALLMENT>{ data($transaction/@CUOTAINTRA_7) }</INSTALLMENT>
                                    <INTEREST>{ data($transaction/@INTERESESINTRA_7) }</INTEREST>
                                    <FEE>{ data($transaction/@CARGOSINTRA_7) }</FEE>
                                </INTRA_CASH_INFO>
                                <EXTRA_FEE>{ data($transaction/@CUOTAEXTRA_7) }</EXTRA_FEE>
                                <INTRA_FEE>{ data($transaction/@COUTAINTRA_7) }</INTRA_FEE>
                                <EXTRA_BALANCE>{ data($transaction/@SALDOEXTRA_7) }</EXTRA_BALANCE>
                                <INTRA_BALANCE>{ data($transaction/@SALDOINTRA_7) }</INTRA_BALANCE>
                            </TRANSACTION>,
                                                            
                            
                            <TRANSACTION>
                                <PERIOD_DATE>{ data($transaction/@FECHACORTE_8) }</PERIOD_DATE>
                                <PERIOD_BALANCE>{ data($transaction/@SALDOCORTE_8) }</PERIOD_BALANCE>
                                <AMOUNT_DUE>{ data($transaction/@PAGOMINIMO_8) }</AMOUNT_DUE>
                                <PAYMENTS>{ data($transaction/@PAGOS_8) }</PAYMENTS>
                                <MERCH_SALES>{ data($transaction/@CONSUMOS_8) }</MERCH_SALES>
                                <CASH_WITHDRAWAL>{ data($transaction/@RETIROS_8) }</CASH_WITHDRAWAL>
                                <LIMIT>{ data($transaction/@LIMITE_8) }</LIMIT>
                                <OTHER_TRANSACTIONS>{ data($transaction/@OTRASTRANSACCIONES_8) }</OTHER_TRANSACTIONS>
                                <INTEREST>{ data($transaction/@INTERESES_8) }</INTEREST>
                                <TOTAL_FEES>{ data($transaction/@TOTALCARGOS_8) }</TOTAL_FEES>
                                <OTHER_DEBITS>{ data($transaction/@OTROSDEBITOS_8) }</OTHER_DEBITS>
                                <CYCLE_DUE>{ data($transaction/@MORA_8) }</CYCLE_DUE>
                                <CYCLE_TOTAL_BALANCE>{ data($transaction/@SALDOTOTAL_8) }</CYCLE_TOTAL_BALANCE>
                                <EXTRA_CASH_INFO>
                                    <BALANCE>{ data($transaction/@SALDOEXTRA_8) }</BALANCE>
                                    <INSTALLMENT>{ data($transaction/@CUOTAEXTRA_8) }</INSTALLMENT>
                                    <INTEREST>{ data($transaction/@INTERESESEXTRA_8) }</INTEREST>
                                    <FEE>{ data($transaction/@CARGOSINTRA_8) }</FEE>
                                </EXTRA_CASH_INFO>
                                <INTRA_CASH_INFO>
                                    <BALANCE>{ data($transaction/@SALDOINTRA_8) }</BALANCE>
                                    <INSTALLMENT>{ data($transaction/@CUOTAINTRA_8) }</INSTALLMENT>
                                    <INTEREST>{ data($transaction/@INTERESESINTRA_8) }</INTEREST>
                                    <FEE>{ data($transaction/@CARGOSINTRA_8) }</FEE>
                                </INTRA_CASH_INFO>
                                <EXTRA_FEE>{ data($transaction/@CUOTAEXTRA_8) }</EXTRA_FEE>
                                <INTRA_FEE>{ data($transaction/@COUTAINTRA_8) }</INTRA_FEE>
                                <EXTRA_BALANCE>{ data($transaction/@SALDOEXTRA_8) }</EXTRA_BALANCE>
                                <INTRA_BALANCE>{ data($transaction/@SALDOINTRA_8) }</INTRA_BALANCE>
                            </TRANSACTION>,
                                                            
                            
                            <TRANSACTION>
                                <PERIOD_DATE>{ data($transaction/@FECHACORTE_9) }</PERIOD_DATE>
                                <PERIOD_BALANCE>{ data($transaction/@SALDOCORTE_9) }</PERIOD_BALANCE>
                                <AMOUNT_DUE>{ data($transaction/@PAGOMINIMO_9) }</AMOUNT_DUE>
                                <PAYMENTS>{ data($transaction/@PAGOS_9) }</PAYMENTS>
                                <MERCH_SALES>{ data($transaction/@CONSUMOS_9) }</MERCH_SALES>
                                <CASH_WITHDRAWAL>{ data($transaction/@RETIROS_9) }</CASH_WITHDRAWAL>
                                <LIMIT>{ data($transaction/@LIMITE_9) }</LIMIT>
                                <OTHER_TRANSACTIONS>{ data($transaction/@OTRASTRANSACCIONES_9) }</OTHER_TRANSACTIONS>
                                <INTEREST>{ data($transaction/@INTERESES_9) }</INTEREST>
                                <TOTAL_FEES>{ data($transaction/@TOTALCARGOS_9) }</TOTAL_FEES>
                                <OTHER_DEBITS>{ data($transaction/@OTROSDEBITOS_9) }</OTHER_DEBITS>
                                <CYCLE_DUE>{ data($transaction/@MORA_9) }</CYCLE_DUE>
                                <CYCLE_TOTAL_BALANCE>{ data($transaction/@SALDOTOTAL_9) }</CYCLE_TOTAL_BALANCE>
                                <EXTRA_CASH_INFO>
                                    <BALANCE>{ data($transaction/@SALDOEXTRA_9) }</BALANCE>
                                    <INSTALLMENT>{ data($transaction/@CUOTAEXTRA_9) }</INSTALLMENT>
                                    <INTEREST>{ data($transaction/@INTERESESEXTRA_9) }</INTEREST>
                                    <FEE>{ data($transaction/@CARGOSINTRA_9) }</FEE>
                                </EXTRA_CASH_INFO>
                                <INTRA_CASH_INFO>
                                    <BALANCE>{ data($transaction/@SALDOINTRA_9) }</BALANCE>
                                    <INSTALLMENT>{ data($transaction/@CUOTAINTRA_9) }</INSTALLMENT>
                                    <INTEREST>{ data($transaction/@INTERESESINTRA_9) }</INTEREST>
                                    <FEE>{ data($transaction/@CARGOSINTRA_9) }</FEE>
                                </INTRA_CASH_INFO>
                                <EXTRA_FEE>{ data($transaction/@CUOTAEXTRA_9) }</EXTRA_FEE>
                                <INTRA_FEE>{ data($transaction/@COUTAINTRA_9) }</INTRA_FEE>
                                <EXTRA_BALANCE>{ data($transaction/@SALDOEXTRA_9) }</EXTRA_BALANCE>
                                <INTRA_BALANCE>{ data($transaction/@SALDOINTRA_9) }</INTRA_BALANCE>
                            </TRANSACTION>,
                                                            
                            
                            <TRANSACTION>
                                <PERIOD_DATE>{ data($transaction/@FECHACORTE_10) }</PERIOD_DATE>
                                <PERIOD_BALANCE>{ data($transaction/@SALDOCORTE_10) }</PERIOD_BALANCE>
                                <AMOUNT_DUE>{ data($transaction/@PAGOMINIMO_10) }</AMOUNT_DUE>
                                <PAYMENTS>{ data($transaction/@PAGOS_10) }</PAYMENTS>
                                <MERCH_SALES>{ data($transaction/@CONSUMOS_10) }</MERCH_SALES>
                                <CASH_WITHDRAWAL>{ data($transaction/@RETIROS_10) }</CASH_WITHDRAWAL>
                                <LIMIT>{ data($transaction/@LIMITE_10) }</LIMIT>
                                <OTHER_TRANSACTIONS>{ data($transaction/@OTRASTRANSACCIONES_10) }</OTHER_TRANSACTIONS>
                                <INTEREST>{ data($transaction/@INTERESES_10) }</INTEREST>
                                <TOTAL_FEES>{ data($transaction/@TOTALCARGOS_10) }</TOTAL_FEES>
                                <OTHER_DEBITS>{ data($transaction/@OTROSDEBITOS_10) }</OTHER_DEBITS>
                                <CYCLE_DUE>{ data($transaction/@MORA_10) }</CYCLE_DUE>
                                <CYCLE_TOTAL_BALANCE>{ data($transaction/@SALDOTOTAL_10) }</CYCLE_TOTAL_BALANCE>
                                <EXTRA_CASH_INFO>
                                    <BALANCE>{ data($transaction/@SALDOEXTRA_10) }</BALANCE>
                                    <INSTALLMENT>{ data($transaction/@CUOTAEXTRA_10) }</INSTALLMENT>
                                    <INTEREST>{ data($transaction/@INTERESESEXTRA_10) }</INTEREST>
                                    <FEE>{ data($transaction/@CARGOSINTRA_10) }</FEE>
                                </EXTRA_CASH_INFO>
                                <INTRA_CASH_INFO>
                                    <BALANCE>{ data($transaction/@SALDOINTRA_10) }</BALANCE>
                                    <INSTALLMENT>{ data($transaction/@CUOTAINTRA_10) }</INSTALLMENT>
                                    <INTEREST>{ data($transaction/@INTERESESINTRA_10) }</INTEREST>
                                    <FEE>{ data($transaction/@CARGOSINTRA_10) }</FEE>
                                </INTRA_CASH_INFO>
                                <EXTRA_FEE>{ data($transaction/@CUOTAEXTRA_10) }</EXTRA_FEE>
                                <INTRA_FEE>{ data($transaction/@COUTAINTRA_10) }</INTRA_FEE>
                                <EXTRA_BALANCE>{ data($transaction/@SALDOEXTRA_10) }</EXTRA_BALANCE>
                                <INTRA_BALANCE>{ data($transaction/@SALDOINTRA_10) }</INTRA_BALANCE>
                            </TRANSACTION>,
                                                            
                            
                            <TRANSACTION>
                                <PERIOD_DATE>{ data($transaction/@FECHACORTE_11) }</PERIOD_DATE>
                                <PERIOD_BALANCE>{ data($transaction/@SALDOCORTE_11) }</PERIOD_BALANCE>
                                <AMOUNT_DUE>{ data($transaction/@PAGOMINIMO_11) }</AMOUNT_DUE>
                                <PAYMENTS>{ data($transaction/@PAGOS_11) }</PAYMENTS>
                                <MERCH_SALES>{ data($transaction/@CONSUMOS_11) }</MERCH_SALES>
                                <CASH_WITHDRAWAL>{ data($transaction/@RETIROS_11) }</CASH_WITHDRAWAL>
                                <LIMIT>{ data($transaction/@LIMITE_11) }</LIMIT>
                                <OTHER_TRANSACTIONS>{ data($transaction/@OTRASTRANSACCIONES_11) }</OTHER_TRANSACTIONS>
                                <INTEREST>{ data($transaction/@INTERESES_11) }</INTEREST>
                                <TOTAL_FEES>{ data($transaction/@TOTALCARGOS_11) }</TOTAL_FEES>
                                <OTHER_DEBITS>{ data($transaction/@OTROSDEBITOS_11) }</OTHER_DEBITS>
                                <CYCLE_DUE>{ data($transaction/@MORA_11) }</CYCLE_DUE>
                                <CYCLE_TOTAL_BALANCE>{ data($transaction/@SALDOTOTAL_11) }</CYCLE_TOTAL_BALANCE>
                                <EXTRA_CASH_INFO>
                                    <BALANCE>{ data($transaction/@SALDOEXTRA_11) }</BALANCE>
                                    <INSTALLMENT>{ data($transaction/@CUOTAEXTRA_11) }</INSTALLMENT>
                                    <INTEREST>{ data($transaction/@INTERESESEXTRA_11) }</INTEREST>
                                    <FEE>{ data($transaction/@CARGOSINTRA_11) }</FEE>
                                </EXTRA_CASH_INFO>
                                <INTRA_CASH_INFO>
                                    <BALANCE>{ data($transaction/@SALDOINTRA_11) }</BALANCE>
                                    <INSTALLMENT>{ data($transaction/@CUOTAINTRA_11) }</INSTALLMENT>
                                    <INTEREST>{ data($transaction/@INTERESESINTRA_11) }</INTEREST>
                                    <FEE>{ data($transaction/@CARGOSINTRA_11) }</FEE>
                                </INTRA_CASH_INFO>
                                <EXTRA_FEE>{ data($transaction/@CUOTAEXTRA_11) }</EXTRA_FEE>
                                <INTRA_FEE>{ data($transaction/@COUTAINTRA_11) }</INTRA_FEE>
                                <EXTRA_BALANCE>{ data($transaction/@SALDOEXTRA_11) }</EXTRA_BALANCE>
                                <INTRA_BALANCE>{ data($transaction/@SALDOINTRA_11) }</INTRA_BALANCE>
                            </TRANSACTION>,
                                                           
                            
                            <TRANSACTION>
                                <PERIOD_DATE>{ data($transaction/@FECHACORTE_12) }</PERIOD_DATE>
                                <PERIOD_BALANCE>{ data($transaction/@SALDOCORTE_12) }</PERIOD_BALANCE>
                                <AMOUNT_DUE>{ data($transaction/@PAGOMINIMO_12) }</AMOUNT_DUE>
                                <PAYMENTS>{ data($transaction/@PAGOS_12) }</PAYMENTS>
                                <MERCH_SALES>{ data($transaction/@CONSUMOS_12) }</MERCH_SALES>
                                <CASH_WITHDRAWAL>{ data($transaction/@RETIROS_12) }</CASH_WITHDRAWAL>
                                <LIMIT>{ data($transaction/@LIMITE_12) }</LIMIT>
                                <OTHER_TRANSACTIONS>{ data($transaction/@OTRASTRANSACCIONES_12) }</OTHER_TRANSACTIONS>
                                <INTEREST>{ data($transaction/@INTERESES_12) }</INTEREST>
                                <TOTAL_FEES>{ data($transaction/@TOTALCARGOS_12) }</TOTAL_FEES>
                                <OTHER_DEBITS>{ data($transaction/@OTROSDEBITOS_12) }</OTHER_DEBITS>
                                <CYCLE_DUE>{ data($transaction/@MORA_12) }</CYCLE_DUE>
                                <CYCLE_TOTAL_BALANCE>{ data($transaction/@SALDOTOTAL_12) }</CYCLE_TOTAL_BALANCE>
                                <EXTRA_CASH_INFO>
                                    <BALANCE>{ data($transaction/@SALDOEXTRA_12) }</BALANCE>
                                    <INSTALLMENT>{ data($transaction/@CUOTAEXTRA_12) }</INSTALLMENT>
                                    <INTEREST>{ data($transaction/@INTERESESEXTRA_12) }</INTEREST>
                                    <FEE>{ data($transaction/@CARGOSINTRA_12) }</FEE>
                                </EXTRA_CASH_INFO>
                                <INTRA_CASH_INFO>
                                    <BALANCE>{ data($transaction/@SALDOINTRA_12) }</BALANCE>
                                    <INSTALLMENT>{ data($transaction/@CUOTAINTRA_12) }</INSTALLMENT>
                                    <INTEREST>{ data($transaction/@INTERESESINTRA_12) }</INTEREST>
                                    <FEE>{ data($transaction/@CARGOSINTRA_12) }</FEE>
                                </INTRA_CASH_INFO>
                                <EXTRA_FEE>{ data($transaction/@CUOTAEXTRA_12) }</EXTRA_FEE>
                                <INTRA_FEE>{ data($transaction/@COUTAINTRA_12) }</INTRA_FEE>
                                <EXTRA_BALANCE>{ data($transaction/@SALDOEXTRA_12) }</EXTRA_BALANCE>
                                <INTRA_BALANCE>{ data($transaction/@SALDOINTRA_12) }</INTRA_BALANCE>
                            </TRANSACTION>  
        													)
                                                        }
                                                        
                        
                        </PRODUCT_TRANSACTIONS>
                                                        )else ()
        											}
        									
                    
                    </CREDIT_CARD>
        								)
        							}
        						
                
                </CREDIT_CARDS_INFO>
                                ) else ()
        				       }
                                {
                                      if(count($responseData/PRESTAMOS/CUENTA) > 0) then (
                                
                
                <LOANS_INFO>
                                {
                                    for $prestamos in $responseData/PRESTAMOS/CUENTA
                                        return(
                                       
                    
                    <LOAN>
                        <NUMBER>{ data($prestamos/@NUMEROPRESTAMO) }</NUMBER>
                        <AGENCY_CODE>{ data($prestamos/@CODIGOAGENCIA) }</AGENCY_CODE>
                        <SUB_APPLICATION>{ data($prestamos/@CODIGOSUBAPLICACION) }</SUB_APPLICATION>
                        <OPENING_DATE>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", data($prestamos/@FECHAAPERTURA)) }</OPENING_DATE>
                                           {
                                             if(data($prestamos/@FECHACANCELACION) != "") then(
                                            
                                           
                        
                        <CANCELATION_DATE>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", data($prestamos/@FECHACANCELACION)) }</CANCELATION_DATE>
                                           
                                           )else ()
                                           }
                                           
                                           
                        
                        <INITIAL_AMOUNT>{ xs:float(data($prestamos/@MONTOINICIAL)) }</INITIAL_AMOUNT>
                        <CURRENT_BALANCE>{ xs:float(data($prestamos/@SALDOACTUAL)) }</CURRENT_BALANCE>
                        <PAYMENT_AMOUNT>{ xs:float(data($prestamos/@VALORCUOTA)) }</PAYMENT_AMOUNT>
                        <RATE>{ xs:float(data($prestamos/@TASA)) }</RATE>
                        <TERM>{ xs:float(data($prestamos/@PLAZO)) }</TERM>
                        <PAYMENT_NUMBER>{ xs:float(data($prestamos/@NUMEROCUOTAS)) }</PAYMENT_NUMBER>
                        <FIRST_CAPITAL_PAYMENT_DATE>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", data($prestamos/@FECHAPRIMERPAGOCAPITAL)) }</FIRST_CAPITAL_PAYMENT_DATE>
                        <LAST_PAYMENT_DATE>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", data($prestamos/@FECHAULTIMOPAGO)) }</LAST_PAYMENT_DATE>
                        <PAID_PAYMENTS>{ data($prestamos/@CANTIDADCUOTASPAGADAS) }</PAID_PAYMENTS>
                        <CAPITAL_FREQUENCY>{ data($prestamos/@FRECUENCIACAPITAL) }</CAPITAL_FREQUENCY>
                        <DESTINATION_CODE>{ data($prestamos/@CODIGODESTINO) }</DESTINATION_CODE>
                        <MONTHLY_PRIME>{ data($prestamos/@PRIMAMENSUAL) }</MONTHLY_PRIME>
                        <CONTRACT_NUMBER>{ xs:int(data($prestamos/@NUMEROCONTRATO)) }</CONTRACT_NUMBER>
                        <CHARGES>{ xs:float(data($prestamos/@CARGOS)) }</CHARGES>
                        <INTEREST>{ xs:float(data($prestamos/@INTERES)) }</INTEREST>
                        <INSURANCE>{ xs:float(data($prestamos/@SEGUROS)) }</INSURANCE>
                        <OTHER_CHARGES>{ xs:float(data($prestamos/@OTROSCARGOS)) }</OTHER_CHARGES>
                        <CURRENT_DUE>{ xs:int(xs:decimal(data($prestamos/@MORAACTUAL))) }</CURRENT_DUE>
                        <DEBTOR_TYPE>{ data($prestamos/@TIPODEUDOR) }</DEBTOR_TYPE>
                        <CODE_TYPE>{ data($prestamos/@CODIGOTIPOPRESTAMO) }</CODE_TYPE>
                        <GUARANTEE_TYPE>{ data($prestamos/@CODIGOTIPOGARANTIA) }</GUARANTEE_TYPE>
                                           {
                                              if(data($prestamos/@NUMEROPRESTAMO) = data($responseData/TRANSACCIONESPRESTAMO/CUENTA/@NUMEROPRESTAMO))then (
                                             
                                           
                        
                        <PRODUCT_TRANSACTIONS>
                                                  {
                                                     for $transaccionesPrestamo in $responseData/TRANSACCIONESPRESTAMO/CUENTA order by  $transaccionesPrestamo/@FECHACIERRE descending
                                                        return(
                                                        
                            
                            <TRANSACTION>
                                <PERIOD_DATE>{ fn-bea:dateTime-from-string-with-format("yyyy-MM-dd", data($transaccionesPrestamo/@FECHACIERRE)) }</PERIOD_DATE>
                                <PERIOD_BALANCE>{ xs:float(data($transaccionesPrestamo/@ALDOTOTAL)) }</PERIOD_BALANCE>
                                <CAPITAL_BALANCE>{ xs:float(data($transaccionesPrestamo/@SALDOCAPITAL)) }</CAPITAL_BALANCE>
                                <DUE_BALANCE>{ xs:int(xs:decimal(data($transaccionesPrestamo/@SALDOVENCIDO))) }</DUE_BALANCE>
                                <CHARGES>{ data($transaccionesPrestamo/@CARGOS) }</CHARGES>
                                <INTEREST>{ data($transaccionesPrestamo/@INTERESES) }</INTEREST>
                                <PAYMENT>{ data($transaccionesPrestamo/@PAGOS) }</PAYMENT>
                                <INSURANCE>{ data($transaccionesPrestamo/@SEGUROS) }</INSURANCE>
                                <OTHER_CHARGES>{ data($transaccionesPrestamo/@OTROSCARGOS) }</OTHER_CHARGES>
                                <CYCLE_DUE>{ data($transaccionesPrestamo/@MORACIERRE) }</CYCLE_DUE>
                            </TRANSACTION>
                                                    )
                                                  }
                                           
                        
                        </PRODUCT_TRANSACTIONS>
                                             )else()
                                          }
                                       
                    
                    </LOAN>
                                   )
                                }
                                
                
                </LOANS_INFO>
                                ) else ()
                             }
        					
        			
            
            </LIABILITIES>
        </CUSTOMER_INFO>
    </LOAN_MAINTENANCE>
    <LOAN_ORIGINATIONS>
             {
                           if(count($responseData/OFERTAPREAPROBADA/OFERTA) > 0) then (
                           
        
        <PRE_APPROVED_OFFERS>
                           {
                            for $oferta in $responseData/OFERTAPREAPROBADA/OFERTA
        			         return(
                             
                               
            
            <OFFER>
                <INFORMATION_DATE>{ fn-bea:dateTime-from-string-with-format("yyyy-MM-dd",data($oferta/@FECHAINFORMACION)) }</INFORMATION_DATE>
                <TYPE>FICOCREDITO</TYPE>
                <DETAILS>
                                {
                                  
                    
                    <FOR_12_MONTHS>{ xs:float(data($oferta/@OFERTAFICOCREDITO12)) }</FOR_12_MONTHS>,
                                  
                    
                    <FOR_18_MONTHS>{ xs:float(data($oferta/@OFERTAFICOCREDITO18)) }</FOR_18_MONTHS>,
                                  
                    
                    <FOR_24_MONTHS>{ xs:float(data($oferta/@OFERTAFICOCREDITO24)) }</FOR_24_MONTHS>,
                                  
                    
                    <FOR_36_MONTHS>{ xs:float(data($oferta/@OFERTAFICOCREDITO36)) }</FOR_36_MONTHS>,
                                  
                    
                    <FOR_48_MONTHS>{ xs:float(data($oferta/@OFERTAFICOCREDITO48)) }</FOR_48_MONTHS>,
                                  
                    
                    <FOR_60_MONTHS>{ xs:float(data($oferta/@OFERTAFICOCREDITO60)) }</FOR_60_MONTHS>
                                }
                                
                
                </DETAILS>
                <INSTALLMENT>{ xs:float(($oferta/@CUOTAFICOCREDITO)) }</INSTALLMENT>
                <RATE>{ xs:int(xs:decimal(data($oferta/@TASAFICOCREDITO))*100) }</RATE>
                <TIMES_INCOME>{ xs:int(data($oferta/@TIMESINCOMEFICOCREDITO)) }</TIMES_INCOME>
            </OFFER>,
                               
            
            <OFFER>
                <INFORMATION_DATE>{ fn-bea:dateTime-from-string-with-format("yyyy-MM-dd",data($oferta/@FECHAINFORMACION)) }</INFORMATION_DATE>
                <TYPE>FICOYA</TYPE>
                <DETAILS>
                                {
                                  
                    
                    <FOR_12_MONTHS>{ xs:float(data($oferta/@OFERTAFICOYA12)) }</FOR_12_MONTHS>,
                                  
                    
                    <FOR_18_MONTHS>{ xs:float(data($oferta/@OFERTAFICOYA18)) }</FOR_18_MONTHS>,
                                  
                    
                    <FOR_24_MONTHS>{ xs:float(data($oferta/@OFERTAFICOYA24)) }</FOR_24_MONTHS>,
                                  
                    
                    <FOR_36_MONTHS>{ xs:float(data($oferta/@OFERTAFICOYA36)) }</FOR_36_MONTHS>,
                                  
                    
                    <FOR_48_MONTHS>{ xs:float(data($oferta/@OFERTAFICOYA48)) }</FOR_48_MONTHS>,
                                  
                    
                    <FOR_60_MONTHS>{ xs:float(data($oferta/@OFERTAFICOYA60)) }</FOR_60_MONTHS>
                                }
                                
                
                </DETAILS>
                <INSTALLMENT>{ xs:float(($oferta/@CUOTAFICOYA)) }</INSTALLMENT>
                <RATE>{ xs:int(xs:decimal(data($oferta/@TASAFICOYA))*100) }</RATE>
                <TIMES_INCOME>{ xs:int(data($oferta/@TIMESINCOMEFICOYA)) }</TIMES_INCOME>
            </OFFER>,
                               
            
            <OFFER>
                <INFORMATION_DATE>{ fn-bea:dateTime-from-string-with-format("yyyy-MM-dd",data($oferta/@FECHAINFORMACION)) }</INFORMATION_DATE>
                <TYPE>OPI</TYPE>
                <DETAILS>
                                {
                                  
                    
                    <FOR_12_MONTHS>{ xs:float(data($oferta/@OFERTAOPI12)) }</FOR_12_MONTHS>,
                                  
                    
                    <FOR_18_MONTHS>{ xs:float(data($oferta/@OFERTAOPI18)) }</FOR_18_MONTHS>,
                                  
                    
                    <FOR_24_MONTHS>{ xs:float(data($oferta/@OFERTAOPI24)) }</FOR_24_MONTHS>,
                                  
                    
                    <FOR_36_MONTHS>{ xs:float(data($oferta/@OFERTAOPI36)) }</FOR_36_MONTHS>,
                                  
                    
                    <FOR_48_MONTHS>{ xs:float(data($oferta/@OFERTAOPI48)) }</FOR_48_MONTHS>,
                                  
                    
                    <FOR_60_MONTHS>{ xs:float(data($oferta/@OFERTAOPI60)) }</FOR_60_MONTHS>
                                }
                                
                
                </DETAILS>
                <INSTALLMENT>{ xs:float(($oferta/@CUOTAOPI)) }</INSTALLMENT>
                <RATE>{ xs:int(xs:decimal(data($oferta/@TASAOPI))*100) }</RATE>
                <TIMES_INCOME>{ xs:int(data($oferta/@TIMESINCOMEOPI)) }</TIMES_INCOME>
            </OFFER>,
                               
            
            <OFFER>
                <INFORMATION_DATE>{ fn-bea:dateTime-from-string-with-format("yyyy-MM-dd",data($oferta/@FECHAINFORMACION)) }</INFORMATION_DATE>
                <TYPE>RETANQUEO</TYPE>
                <DETAILS>
                                {
                                  
                    
                    <FOR_12_MONTHS>{ xs:float(data($oferta/@OFERTARETANQUEO12)) }</FOR_12_MONTHS>,
                                  
                    
                    <FOR_18_MONTHS>{ xs:float(data($oferta/@OFERTARETANQUEO18)) }</FOR_18_MONTHS>,
                                  
                    
                    <FOR_24_MONTHS>{ xs:float(data($oferta/@OFERTARETANQUEO24)) }</FOR_24_MONTHS>,
                                  
                    
                    <FOR_36_MONTHS>{ xs:float(data($oferta/@OFERTARETANQUEO36)) }</FOR_36_MONTHS>,
                                  
                    
                    <FOR_48_MONTHS>{ xs:float(data($oferta/@OFERTARETANQUEO48)) }</FOR_48_MONTHS>,
                                  
                    
                    <FOR_60_MONTHS>{ xs:float(data($oferta/@OFERTARETANQUEO60)) }</FOR_60_MONTHS>
                                }
                                
                
                </DETAILS>
                <INSTALLMENT>{ xs:float(($oferta/@CUOTARETANQUEO)) }</INSTALLMENT>
                <RATE>{ xs:int(xs:decimal(data($oferta/@TASARETANQUEO))*100) }</RATE>
                <TIMES_INCOME>{ xs:int(data($oferta/@TIMESINCOMERETANQUEO)) }</TIMES_INCOME>
            </OFFER>
                            
                             )
                             }
                           
        
        </PRE_APPROVED_OFFERS>
                           )else ()
                 }
                 {
                           if(count($responseData/EXTRAFIN/CUENTA) > 0) then (
                           
        
        <INTERNAL_EXTRAS>
                           {
                            for $extrafin in $responseData/EXTRAFIN/CUENTA
        			         return(
                             
                               
            
            <EXTRA>
                <ACCOUNT_NUMBER>{ data($extrafin/@NUMEROCUENTA) }</ACCOUNT_NUMBER>
                <DATE>{ data($extrafin/@FECHAEXTRA) }</DATE>
                <RATE>{ data($extrafin/@TASAEXTRA) }</RATE>
                <AMOUNT>{ data($extrafin/@MONTOTOMADO) }</AMOUNT>
                <INSTALLMENT>{ data($extrafin/@CUOTAEXTRA) }</INSTALLMENT>
                <INSTALLMENT_COUNT>{ data($extrafin/@CUOTANUMERO) }</INSTALLMENT_COUNT>
                <TOTAL_INSTALLMENT>{ data($extrafin/@TOTALCUOTAS) }</TOTAL_INSTALLMENT>
            </EXTRA>
                            
                             )
                             }
                           
        
        </INTERNAL_EXTRAS>
                           )else (
                           
        
        <INTERNAL_EXTRAS/>
                           )
                 }
        		 
        
        <REFERENCES_DETAILS>
                         {
                           if(count($responseData/RECORDC/CUENTA) > 0) then (
                           
            
            <QUERIES>
                           {
                            for $recordc in $responseData/RECORDC/CUENTA
        			         return(
                             
                               
                
                <QUERY_ITEM>
                    <ID>{ data($recordc/@viewId) }</ID>
                                {
                                   if(data($recordc/@queryDate) != "00/00/0000")then (
                           
                                    
                    
                    <DATE>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordc/@queryDate))) }</DATE>
                                    )else ()
                                }
                                
                    
                    <ENTITY>{ fn-bea:trim(data($recordc/@whoMadeQuery)) }</ENTITY>
                </QUERY_ITEM>
                            
                             )
                             }
                           
            
            </QUERIES>
                           )else ()
                        }
        				
            
            <ACTIVE_REFERENCES>
                         {
                                    if(count($responseData/RECORDB/CUENTA) > 0) then (
                                     for $recordb in $responseData/RECORDB/CUENTA
                                     return(
                                     
                
                <REFERENCE>
                                       {
                                          if(data($recordb/@idEstudio) != "") then (
                                            
                    
                    <QUERY_ID>{ data($recordb/@idEstudio) }</QUERY_ID>
                                          ) else ()
                                        }
                                        
                    
                    <CREDITOR>{ fn-bea:trim(data($recordb/@Acreedor)) }</CREDITOR>
                    <REFERENCE_NUMBER>{ fn-bea:trim(data($recordb/@noReferencia)) }</REFERENCE_NUMBER>
                    <TYPE>{ data($recordb/@TipoReferencia) }</TYPE>
                    <OBLIGATION_TYPE>{ fn-bea:trim(data($recordb/@tipoObligacion)) }</OBLIGATION_TYPE>
                    <CREDIT_TYPE>{ fn-bea:trim(data($recordb/@TipoPrestamo)) }</CREDIT_TYPE>
                    <STATUS>{ fn-bea:trim(data($recordb/@Estado)) }</STATUS>
                    <LIMIT>{ xs:float(data($recordb/@LimiteMonto)) }</LIMIT>
                    <CURRENCY>{ fn-bea:trim(data($recordb/@Moneda)) }</CURRENCY>
                    <BALANCE>{ xs:float(data($recordb/@SaldoActual)) }</BALANCE>
                    <PAYMENT_METHOD>{ fn-bea:trim(data($recordb/@FormaPago)) }</PAYMENT_METHOD>
                    <GUARANTEE>{ xs:float(data($recordb/@ValorGarantia)) }</GUARANTEE>
                    <GUARANTEE_TYPE>{ fn-bea:trim(data($recordb/@TipoGarantia)) }</GUARANTEE_TYPE>
                    <ARREAR_BALANCE>{ xs:float(data($recordb/@SaldoMora)) }</ARREAR_BALANCE>
                    <ARREAR_LEVEL>{ fn-bea:trim(data($recordb/@nivelMora)) }</ARREAR_LEVEL>
                    <DUE_BALANCE>{ xs:float(data($recordb/@SaldoVencido)) }</DUE_BALANCE>
                    <IN_EXECUTION>{ xs:float(data($recordb/@SaldoCobroJudicial)) }</IN_EXECUTION>
                    <PUNISHED_BALANCE>{ xs:float(data($recordb/@SaldoCastigado)) }</PUNISHED_BALANCE>
                    <PERIOD>{ data($recordb/@periodoInfo) }</PERIOD>
                    <OPENING_DATE>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordb/@FechaApertura))) }</OPENING_DATE>
                                        {
                                          if(data($recordb/@FechaCancelacion) != "00/00/0000")then (
      
                                           
                    
                    <CANCELATION_DATE>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordb/@FechaCancelacion))) }</CANCELATION_DATE>
                                            )else ()
                                        }
                                        {
                                          if(data($recordb/@FechaVencimiento) != "00/00/0000")then (
      
                                          
                    
                    <EXPIRATION_DATE>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordb/@FechaVencimiento))) }</EXPIRATION_DATE>
                                           )else ()
                                        }
                                        
                    
                    <INSTALLMENT>{ xs:float(data($recordb/@Cuota)) }</INSTALLMENT>
                                        {
                                          for $recordhb in $responseData/RECORDHB/CUENTA[@noReferencia = $recordb/@noReferencia]
        							      return(
                                            
                    
                    <HISTORICAL_ARREAR>{ data($recordhb/@MoraHistorica) }</HISTORICAL_ARREAR>,
                                            
                    
                    <HISTORICAL_COUNT_LOC>{ data($recordhb/@conteoHistoricoLoc) }</HISTORICAL_COUNT_LOC>,
                                            
                    
                    <HISTORICAL_COUNT_DOL>{ data($recordhb/@conteoHistoricoDol) }</HISTORICAL_COUNT_DOL>
                                          
                                        )
                                       }
                                     
                
                </REFERENCE>
                             )
                             )else()
                           }
                           {
                           if(count($responseData/RECORDD/CUENTA) > 0) then (
                             for $recordd in $responseData/RECORDD/CUENTA
                             return(
                              
                
                <REFERENCE>
        						{
                                   if(data($recordd/@idEstudio) != "") then (
                                     
                    
                    <QUERY_ID>{ data($recordd/@idEstudio) }</QUERY_ID>
                                   )else ()
                                }
        						
                    
                    <CREDITOR>{ fn-bea:trim(data($recordd/@Acreedor)) }</CREDITOR>
                    <REFERENCE_NUMBER>{ data($recordd/@noReferencia) }</REFERENCE_NUMBER>
                    <TYPE>{ data($recordd/@TipoReferencia) }</TYPE>
                    <CREDIT_TYPE>{ fn-bea:trim(data($recordd/@TipoPrestamo)) }</CREDIT_TYPE>
                    <STATUS>{ fn-bea:trim(data($recordd/@Estado)) }</STATUS>
                    <LIMIT>{ xs:float(data($recordd/@LimiteMonto)) }</LIMIT>
                    <TERM>{ xs:float(data($recordd/@Plazo)) }</TERM>
                    <CURRENCY>{ fn-bea:trim(data($recordd/@Moneda)) }</CURRENCY>
                    <EXCHANGE_FACTOR>{ xs:float(data($recordd/@FactorCambio)) }</EXCHANGE_FACTOR>
                    <BALANCE>{ xs:float(data($recordd/@SaldoActual)) }</BALANCE>
                    <MIN_PAYMENT>{ xs:float(data($recordd/@Cuota)) }</MIN_PAYMENT>
                    <GUARANTEE_TYPE>{ fn-bea:trim(data($recordd/@TipoGarantia)) }</GUARANTEE_TYPE>
                    <ARREAR_BALANCE>{ xs:float(data($recordd/@SaldoMora)) }</ARREAR_BALANCE>
                    <ARREAR_LEVEL>{ data($recordd/@nivelMora) }</ARREAR_LEVEL>
                    <PERIOD>{ data($recordd/@periodoInfo) }</PERIOD>
                    <OPENING_DATE>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordd/@FechaApertura))) }</OPENING_DATE>
                                {
                                   if(data($recordd/@FechaCancelacion) != "00/00/0000")then (
      
                                   
                    
                    <CANCELATION_DATE>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordd/@FechaCancelacion))) }</CANCELATION_DATE>
                                     )else ()
                                }
                                {
                                   if(data($recordd/@FechaVencimiento) != "00/00/0000")then (
      
                                   
                    
                    <EXPIRATION_DATE>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordd/@FechaVencimiento))) }</EXPIRATION_DATE>
                                     )else ()
                                }
                                
                    
                    <INSTALLMENT>{ xs:float(data($recordd/@Cuota)) }</INSTALLMENT>
                                 {
                                    for $recordhd in $responseData/RECORDHD/CUENTA[@noReferencia = $recordd/@noReferencia]
        							return(
                                            
                    
                    <HISTORICAL_ARREAR>{ data($recordhd/@MoraHistorica) }</HISTORICAL_ARREAR>,
                                            
                    
                    <HISTORICAL_COUNT_LOC>{ data($recordhd/@conteoHistoricoLoc) }</HISTORICAL_COUNT_LOC>,
                                            
                    
                    <HISTORICAL_COUNT_DOL>{ data($recordhd/@conteoHistoricoDol) }</HISTORICAL_COUNT_DOL>
                                          
                                )
                                }
                              
                
                </REFERENCE>
                              )
                              )else()
                           }
                           {
                           if(count($responseData/RECORDT/CUENTA) > 0) then (
                             for $recordt in $responseData/RECORDT/CUENTA
                             return(
                              
                
                <REFERENCE>
        						{
                                   if(data($recordt/@idEstudio) != "") then (
                                     
                    
                    <QUERY_ID>{ data($recordt/@idEstudio) }</QUERY_ID>
                                   )else ()
                                }
        						
                    
                    <CREDITOR>{ fn-bea:trim(data($recordt/@Acreedor)) }</CREDITOR>
                    <REFERENCE_NUMBER>{ fn-bea:trim(data($recordt/@noReferencia)) }</REFERENCE_NUMBER>
                    <TYPE>{ data($recordt/@TipoReferencia) }</TYPE>
                    <CREDIT_TYPE>{ fn-bea:trim(data($recordt/@TipoPrestamo)) }</CREDIT_TYPE>
                    <STATUS>{ fn-bea:trim(data($recordt/@Estado)) }</STATUS>
                    <LIMIT>{ xs:float(data($recordt/@LimiteMonto)) }</LIMIT>
                    <CURRENCY>{ fn-bea:trim(data($recordt/@Moneda)) }</CURRENCY>
                    <EXCHANGE_FACTOR>{ xs:float(data($recordt/@FactorCambio)) }</EXCHANGE_FACTOR>
                    <BALANCE>{ xs:float(data($recordt/@SaldoActual)) }</BALANCE>
                    <ARREAR_BALANCE>{ xs:float(data($recordt/@SaldoMora)) }</ARREAR_BALANCE>
                    <ARREAR_LEVEL>{ data($recordt/@nivelMora) }</ARREAR_LEVEL>
                    <PERIOD>{ data($recordt/@periodoInfo) }</PERIOD>
                    <OPENING_DATE>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordt/@FechaApertura))) }</OPENING_DATE>
        						{
                                   if(data($recordt/@FechaCancelacion) != "00/00/0000")then (
      
                                   
                    
                    <CANCELATION_DATE>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordt/@FechaCancelacion))) }</CANCELATION_DATE>
                                     )else ()
                                }
                                
                    
                    <INSTALLMENT>{ xs:float(data($recordt/@Cuota)) }</INSTALLMENT>
                                {
                                    for $recordht in $responseData/RECORDHT/CUENTA[@noReferencia = $recordt/@noReferencia]
        							return(
                                            
                    
                    <HISTORICAL_ARREAR>{ data($recordht/@MoraHistorica) }</HISTORICAL_ARREAR>,
                                            
                    
                    <HISTORICAL_COUNT_LOC>{ data($recordht/@conteoHistoricoLoc) }</HISTORICAL_COUNT_LOC>,
                                            
                    
                    <HISTORICAL_COUNT_DOL>{ data($recordht/@conteoHistoricoDol) }</HISTORICAL_COUNT_DOL>
                                          
                                )
                                }
                              
                
                </REFERENCE>
                              )
                              )else()
                         }
        				
            
            </ACTIVE_REFERENCES>
            <HISTORICAL_REFERENCES>
                           {
                                    if(count($responseData/RECORDPRB/CUENTA) > 0) then (
                                     for $recordprb in $responseData/RECORDPRB/CUENTA
                                     return(
                                     
                
                <REFERENCE>
                                        {
                                          if(data($recordprb/@idEstudio) != "") then (
                                            
                    
                    <QUERY_ID>{ data($recordprb/@idEstudio) }</QUERY_ID>
                                          )else ()
                                        }
                                        
                    
                    <CREDITOR>{ fn-bea:trim(data($recordprb/@Acreedor)) }</CREDITOR>
                    <REFERENCE_NUMBER>{ fn-bea:trim(data($recordprb/@noReferencia)) }</REFERENCE_NUMBER>
                    <TYPE>{ data($recordprb/@TipoReferencia) }</TYPE>
                    <CREDIT_TYPE>{ fn-bea:trim(data($recordprb/@TipoPrestamo)) }</CREDIT_TYPE>
                    <STATUS>{ fn-bea:trim(data($recordprb/@Estado)) }</STATUS>
                    <LIMIT>{ xs:float(data($recordprb/@LimiteMonto)) }</LIMIT>
                    <CURRENCY>{ fn-bea:trim(data($recordprb/@Moneda)) }</CURRENCY>
                    <BALANCE>{ xs:float(data($recordprb/@SaldoActual)) }</BALANCE>
                    <PAYMENT_METHOD>{ fn-bea:trim(data($recordprb/@FormaPago)) }</PAYMENT_METHOD>
                    <GUARANTEE>{ xs:float(data($recordprb/@ValorGarantia)) }</GUARANTEE>
                    <GUARANTEE_TYPE>{ fn-bea:trim(data($recordprb/@TipoGarantia)) }</GUARANTEE_TYPE>
                    <ARREAR_BALANCE>{ xs:float(data($recordprb/@SaldoMora)) }</ARREAR_BALANCE>
                    <ARREAR_LEVEL>{ fn-bea:trim(data($recordprb/@nivelMora)) }</ARREAR_LEVEL>
                    <DUE_BALANCE>{ xs:float(data($recordprb/@SaldoVencido)) }</DUE_BALANCE>
                    <IN_EXECUTION>{ xs:float(data($recordprb/@SaldoCobroJudicial)) }</IN_EXECUTION>
                    <PUNISHED_BALANCE>{ xs:float(data($recordprb/@SaldoCastigado)) }</PUNISHED_BALANCE>
                    <PERIOD>{ data($recordprb/@periodoInfo) }</PERIOD>
                    <OPENING_DATE>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordprb/@FechaApertura))) }</OPENING_DATE>
                                        {
                                          if(data($recordprb/@FechaCancelacion) != "00/00/0000")then (
      
                                           
                    
                    <CANCELATION_DATE>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("yyyyMMdd",data($recordprb/@FechaCancelacion))) }</CANCELATION_DATE>
                                            ) else ()
                                        }
                                        {
                                          if(data($recordprb/@FechaVencimiento) != "00/00/0000")then (
      
                                          
                    
                    <EXPIRATION_DATE>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordprb/@FechaVencimiento))) }</EXPIRATION_DATE>
                                           ) else ()
                                        }
                                        
                    
                    <INSTALLMENT>{ xs:float(data($recordprb/@Cuota)) }</INSTALLMENT>
                    <HISTORICAL_ARREAR>{ fn-bea:trim(data($recordprb/@MoraHistorica)) }</HISTORICAL_ARREAR>
                    <HISTORICAL_COUNT_LOC>{ fn-bea:trim(data($recordprb/@conteoHistoricoLoc)) }</HISTORICAL_COUNT_LOC>
                    <HISTORICAL_COUNT_DOL>{ fn-bea:trim(data($recordprb/@conteoHistoricoDol)) }</HISTORICAL_COUNT_DOL>
                </REFERENCE>
                             )
                             )else()
                          }
                          {
                                    if(count($responseData/RECORDPRD/CUENTA) > 0) then (
                                     for $recordprd in $responseData/RECORDPRD/CUENTA
                                     return(
                                     
                
                <REFERENCE>
                                        {
                                          if(data($recordprd/@idEstudio) != "") then (
                                            
                    
                    <QUERY_ID>{ data($recordprd/@idEstudio) }</QUERY_ID>
                                          )else ()
                                        }
                                        
                    
                    <CREDITOR>{ fn-bea:trim(data($recordprd/@Acreedor)) }</CREDITOR>
                    <REFERENCE_NUMBER>{ data($recordprd/@noReferencia) }</REFERENCE_NUMBER>
                    <TYPE>{ data($recordprd/@TipoReferencia) }</TYPE>
                    <CREDIT_TYPE>{ fn-bea:trim(data($recordprd/@TipoPrestamo)) }</CREDIT_TYPE>
                    <STATUS>{ data($recordprd/@Estado) }</STATUS>
                    <LIMIT>{ xs:float(data($recordprd/@LimiteMonto)) }</LIMIT>
                    <TERM>{ xs:float(data($recordprd/@Plazo)) }</TERM>
                    <CURRENCY>{ fn-bea:trim(data($recordprd/@Moneda)) }</CURRENCY>
                    <EXCHANGE_FACTOR>{ xs:float(data($recordprd/@FactorCambio)) }</EXCHANGE_FACTOR>
                    <BALANCE>{ xs:float(data($recordprd/@SaldoActual)) }</BALANCE>
                    <MIN_PAYMENT>{ xs:float(data($recordprd/@Cuota)) }</MIN_PAYMENT>
                    <GUARANTEE_TYPE>{ fn-bea:trim(data($recordprd/@TipoGarantia)) }</GUARANTEE_TYPE>
                    <ARREAR_BALANCE>{ xs:float(data($recordprd/@SaldoMora)) }</ARREAR_BALANCE>
                    <ARREAR_LEVEL>{ data($recordprd/@nivelMora) }</ARREAR_LEVEL>
                    <PERIOD>{ data($recordprd/@periodoInfo) }</PERIOD>
                    <OPENING_DATE>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordprd/@FechaApertura))) }</OPENING_DATE>
                                        {
                                          if(data($recordprd/@FechaCancelacion) != "00/00/0000")then (
      
                                           
                    
                    <CANCELATION_DATE>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordprd/@FechaCancelacion))) }</CANCELATION_DATE>
                                            ) else ()
                                        }
                                        {
                                          if(data($recordprd/@FechaVencimiento) != "00/00/0000")then (
      
                                          
                    
                    <EXPIRATION_DATE>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordprd/@FechaVencimiento))) }</EXPIRATION_DATE>
                                           ) else ()
                                        }
                                        
                    
                    <INSTALLMENT>{ xs:float(data($recordprd/@Cuota)) }</INSTALLMENT>
                    <HISTORICAL_ARREAR>{ fn-bea:trim(data($recordprd/@MoraHistorica)) }</HISTORICAL_ARREAR>
                    <HISTORICAL_COUNT_LOC>{ fn-bea:trim(data($recordprd/@conteoHistoricoLoc)) }</HISTORICAL_COUNT_LOC>
                    <HISTORICAL_COUNT_DOL>{ fn-bea:trim(data($recordprd/@conteoHistoricoDol)) }</HISTORICAL_COUNT_DOL>
                </REFERENCE>
                             )
                             )else()
                          }
                          {
                                    if(count($responseData/RECORDPRT/CUENTA) > 0) then (
                                     for $recordprt in $responseData/RECORDPRT/CUENTA
                                     return(
                                     
                
                <REFERENCE>
                                        {
                                          if(data($recordprt/@idEstudio) != "") then (
                                            
                    
                    <QUERY_ID>{ data($recordprt/@idEstudio) }</QUERY_ID>
                                          ) else ()
                                        }
                                        
                    
                    <CREDITOR>{ fn-bea:trim(data($recordprt/@Acreedor)) }</CREDITOR>
                    <REFERENCE_NUMBER>{ data($recordprt/@noReferencia) }</REFERENCE_NUMBER>
                    <TYPE>{ data($recordprt/@TipoReferencia) }</TYPE>
                    <CREDIT_TYPE>{ fn-bea:trim(data($recordprt/@TipoPrestamo)) }</CREDIT_TYPE>
                    <STATUS>{ fn-bea:trim(data($recordprt/@Estado)) }</STATUS>
                    <LIMIT>{ xs:float(data($recordprt/@LimiteMonto)) }</LIMIT>
                    <CURRENCY>{ fn-bea:trim(data($recordprt/@Moneda)) }</CURRENCY>
                    <EXCHANGE_FACTOR>{ xs:float(data($recordprt/@FactorCambio)) }</EXCHANGE_FACTOR>
                    <BALANCE>{ xs:float(data($recordprt/@SaldoActual)) }</BALANCE>
                    <ARREAR_BALANCE>{ xs:float(data($recordprt/@SaldoMora)) }</ARREAR_BALANCE>
                    <ARREAR_LEVEL>{ data($recordprt/@nivelMora) }</ARREAR_LEVEL>
                    <PERIOD>{ data($recordprt/@periodoInfo) }</PERIOD>
                    <OPENING_DATE>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordprt/@FechaApertura))) }</OPENING_DATE>
                                        {
                                          if(data($recordprt/@FechaCancelacion) != "00/00/0000")then (
      
                                           
                    
                    <CANCELATION_DATE>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordprt/@FechaCancelacion))) }</CANCELATION_DATE>
                                            ) else ()
                                        }
                                        {
                                          if(data($recordprt/@FechaVencimiento) != "00/00/0000")then (
      
                                          
                    
                    <EXPIRATION_DATE>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("yyyyMMdd",data($recordprt/@FechaVencimiento))) }</EXPIRATION_DATE>
                                           ) else ()
                                        }
                                        
                    
                    <INSTALLMENT>{ xs:float(data($recordprt/@Cuota)) }</INSTALLMENT>
                    <HISTORICAL_ARREAR>{ fn-bea:trim(data($recordprt/@MoraHistorica)) }</HISTORICAL_ARREAR>
                    <HISTORICAL_COUNT_LOC>{ fn-bea:trim(data($recordprt/@conteoHistoricoLoc)) }</HISTORICAL_COUNT_LOC>
                    <HISTORICAL_COUNT_DOL>{ fn-bea:trim(data($recordprt/@conteoHistoricoDol)) }</HISTORICAL_COUNT_DOL>
                </REFERENCE>
                             )
                             )else()
                          }
                        
            
            </HISTORICAL_REFERENCES>
        </REFERENCES_DETAILS>
    </LOAN_ORIGINATIONS>
</ns1:consultaConsolidadaRiesgoClienteResponse>
};

declare variable $responseData as element(*) external;

xf:consultaConsolidadaRiesgoClienteOut($responseData)