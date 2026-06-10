<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns5="http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes";
(:: import schema at "../../../BusinessServices/DWConsultaConsolidada/SJS/xsd/sjConsultaConsolidadaRiesgoClienteHNTypes.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/integracionConsultaExtraFin";
(:: import schema at "../../../BusinessServices/DWConsultaConsolidada/integracionConsultaExtraFin/xsd/integracionConsultaExtraFin_sp.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/integracionConsultaTrxPasivos";
(:: import schema at "../../../BusinessServices/DWConsultaConsolidada/integracionConsultaTrxPasivos/xsd/integracionConsultaTrxPasivos_sp.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/integracionConsultaTrxPrestamos";
(:: import schema at "../../../BusinessServices/DWConsultaConsolidada/integracionConsultaTrxPrestamos/xsd/integracionConsultaTrxPrestamos_sp.xsd" ::)
declare namespace ns4="http://xmlns.oracle.com/pcbpel/adapter/db/sp/integracionConsultaTrxTarjetas";
(:: import schema at "../../../BusinessServices/DWConsultaConsolidada/integracionConsultaTrxTarjetas/xsd/integracionConsultaTrxTarjetas_sp.xsd" ::)

declare variable $InputIntegrationConsultaExtraFin as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $InputIntegrationConsultaTrxPasivo as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $InputIntegrationConsultaTrxPrestamos as element() (:: schema-element(ns3:OutputParameters) ::) external;
declare variable $InputIntegrationTrxTarjeta as element() (:: schema-element(ns4:OutputParameters) ::) external;

declare function local:func($InputIntegrationConsultaExtraFin as element() (:: schema-element(ns1:OutputParameters) ::), 
                            $InputIntegrationConsultaTrxPasivo as element() (:: schema-element(ns2:OutputParameters) ::), 
                            $InputIntegrationConsultaTrxPrestamos as element() (:: schema-element(ns3:OutputParameters) ::), 
                            $InputIntegrationTrxTarjeta as element() (:: schema-element(ns4:OutputParameters) ::)) 
                            as element() (:: schema-element(ns5:consultaConsolidadaRiesgoClienteResponse) ::) {
    <ns5:consultaConsolidadaRiesgoClienteResponse>
    
        <statusInfo>
             <tagInfo> 
                  <CODE>{fn:data($InputIntegrationConsultaExtraFin/ns1:CODIGO_RESPUESTA)}</CODE>  
                 <MESSAGE>{fn:data($InputIntegrationConsultaExtraFin/ns1:MENSAJE_RESPUESTA)}</MESSAGE>
                 <NAME>SP EXTRA FIN</NAME>
             </tagInfo>
               <tagInfo>
                 <CODE>{fn:data($InputIntegrationConsultaTrxPasivo/ns2:CODIGO_RESPUESTA)}</CODE>
                 <MESSAGE>{fn:data($InputIntegrationConsultaTrxPasivo/ns2:MENSAJE_RESPUESTA)}</MESSAGE>
                 <NAME>SP TRX PASIVO</NAME>
             </tagInfo>
               <tagInfo>
                 <CODE>{fn:data($InputIntegrationConsultaTrxPrestamos/ns3:CODIGO_RESPUESTA)}</CODE>
                 <MESSAGE>{fn:data($InputIntegrationConsultaTrxPrestamos/ns3:MENSAJE_RESPUESTA)}</MESSAGE>
                 <NAME>SP TRX PRESTAMOS</NAME>
             </tagInfo>
               <tagInfo>
                 <CODE>{fn:data($InputIntegrationTrxTarjeta/ns4:CODIGO_RESPUESTA)}</CODE>
                 <MESSAGE>{fn:data($InputIntegrationTrxTarjeta/ns4:MENSAJE_RESPUESTA)}</MESSAGE>
                 <NAME>SP TRX TARJETAS</NAME>
             </tagInfo>
         </statusInfo>
         
        
        <LOAN_MAINTENANCE>
            <CUSTOMER_INFO>
                <ID></ID>
                <FISCAL_ID></FISCAL_ID>
                <FIRST_NAME></FIRST_NAME>
                <LAST_NAME></LAST_NAME>
                <BIRTH_DATE></BIRTH_DATE>
                <TARGET></TARGET>
                <DATE_OF_BIRTH></DATE_OF_BIRTH>
                <AGE></AGE>
                <TYPE></TYPE>
                <SALARY></SALARY>
                <PAYROLL_SALARY></PAYROLL_SALARY>
                <CREDIT_MONTHS></CREDIT_MONTHS>
                <FLAG_BLAZE></FLAG_BLAZE>
                <FLAG_HIT></FLAG_HIT>
                <EVALUATION_RESULT></EVALUATION_RESULT>
                <ADDRESSES_INFO>
                    <ADDRESS_ITEM>
                        <PERIOD></PERIOD>
                        <ADDRESS></ADDRESS>
                    </ADDRESS_ITEM>
                </ADDRESSES_INFO>
                <PHONES_INFO>
                    <PHONE_ITEM>
                        <PERIOD></PERIOD>
                        <PHONE></PHONE>
                    </PHONE_ITEM>
                </PHONES_INFO>
                <ADMINISTRATIVE_CHARGES>
                    <CHARGE>
                        <ID></ID>
                        <INFORMATION_DATE></INFORMATION_DATE>
                        <IN_DATE></IN_DATE>
                        <CREDITOR></CREDITOR>
                        <MOTIVATION></MOTIVATION>
                        <CURRENCY></CURRENCY>
                        <TOTAL_DEBT_AMOUNT></TOTAL_DEBT_AMOUNT>
                        <EXCHANGE_FACTOR></EXCHANGE_FACTOR>
                    </CHARGE>
                </ADMINISTRATIVE_CHARGES>
                <CURRENT_ARREAR_SUMMARY>
                    <ARREAR>
                        <ID></ID>
                        <INFORMATION_DATE></INFORMATION_DATE>
                        <DATE></DATE>
                        <CREDITOR></CREDITOR>
                        <ACCOUNT_TYPE></ACCOUNT_TYPE>
                        <CURRENCY></CURRENCY>
                        <DAYS></DAYS>
                        <AMOUNT></AMOUNT>
                        <EXCHANGE_FACTOR></EXCHANGE_FACTOR>
                    </ARREAR>
                </CURRENT_ARREAR_SUMMARY>
                <EXTERNAL_SCORE></EXTERNAL_SCORE>
                <SCORE_INFO>
                    <SCORE_CALCULATION></SCORE_CALCULATION>
                    <QUALIFICATION></QUALIFICATION>
                    <RISK_LEVEL></RISK_LEVEL>
                </SCORE_INFO>
                <OFFERS>
                    <OFFER>
                        <PRODUCT_CODE></PRODUCT_CODE>
                        <MAX_AMOUNT></MAX_AMOUNT>
                        <INSTALLMENT></INSTALLMENT>
                        <RATE></RATE>
                        <AMOUNT_CALCULATIONS>
                            <FOR_12_MONTHS></FOR_12_MONTHS>
                            <FOR_18_MONTHS></FOR_18_MONTHS>
                            <FOR_24_MONTHS></FOR_24_MONTHS>
                            <FOR_36_MONTHS></FOR_36_MONTHS>
                            <FOR_48_MONTHS></FOR_48_MONTHS>
                            <FOR_60_MONTHS></FOR_60_MONTHS>
                        </AMOUNT_CALCULATIONS>
                        <TIMES_INCOME></TIMES_INCOME>
                        <RESOLUTION>
                            <CODE></CODE>
                            <DESCRIPTION></DESCRIPTION>
                        </RESOLUTION>
                    </OFFER>
                </OFFERS>
                <ASSETS>
                    <ASSET>
                        <NUMBER></NUMBER>
                        <CATEGORY></CATEGORY>
                        <CURRENCY></CURRENCY>
                        <OPENING_DATE></OPENING_DATE>
                        <CANCELATION_DATE></CANCELATION_DATE>
                        <CURRENT_BALANCE></CURRENT_BALANCE>
                        <END_OF_MONTH_BALANCE></END_OF_MONTH_BALANCE>
                        <AVERAGE_BALANCE></AVERAGE_BALANCE>
                         <PRODUCT_TRANSACTIONS>
                        {
                          for $row at $pos in $InputIntegrationConsultaTrxPasivo/ns2:RowSet/ns2:Row
                          return
                            <TRANSACTION>
                              <FLAG>{ concat('ROW_', $pos) }</FLAG>
                              <ASSET_NUMBER>{data($row/ns2:Column[upper-case(@name) = 'CUENTA']) }</ASSET_NUMBER>
                              <PERIOD_DATE>{ data($row/ns2:Column[upper-case(@name) = 'FECHAFINDEPERIODO']) }</PERIOD_DATE>
                              <PERIOD_BALANCE>{ data($row/ns2:Column[upper-case(@name) = 'SALDOFIN']) }</PERIOD_BALANCE>
                              <MAX_BALANCE>{ data($row/ns2:Column[upper-case(@name) = 'SALDOMAX']) }</MAX_BALANCE>
                              <MIN_BALANCE>{ data($row/ns2:Column[upper-case(@name) = 'SALDOMIN']) }</MIN_BALANCE>
                              <AVERAGE_BALANCE>{ data($row/ns2:Column[upper-case(@name) = 'SALDOPROMEDIO']) }</AVERAGE_BALANCE>
                              <LAST_CREDIT_DATE>{ data($row/ns2:Column[upper-case(@name) = 'FECHAULTIMOCREDITO']) }</LAST_CREDIT_DATE>
                              <LAST_DEBIT_DATE>{ data($row/ns2:Column[upper-case(@name) = 'FECHAULTIMODEBITO']) }</LAST_DEBIT_DATE>
                              <FACILITIES>{ data($row/ns2:Column[upper-case(@name) = 'FLAGFACILIDADESCUENTA']) }</FACILITIES>
                              <LEGAL_REPRESENTATIVE>{ data($row/ns2:Column[upper-case(@name) = 'FLAGREPRESENTANTELEGAL']) }</LEGAL_REPRESENTATIVE>
                              <PAYROLL_ACCOUNTS>{ data($row/ns2:Column[upper-case(@name) = 'FLAGCUENTAPLANILLA']) }</PAYROLL_ACCOUNTS>
                              <PAYROLL_CREDIT_AMOUNT>{ data($row/ns2:Column[upper-case(@name) = 'MONTOACREDITADOPLANILLA']) }</PAYROLL_CREDIT_AMOUNT>
                              <JOINT_ACCOUNTS>{ data($row/ns2:Column[upper-case(@name) = 'FLAGCUENTAMANCOMUNADA']) }</JOINT_ACCOUNTS>
                              <PRODUCT_BLOCK>{ data($row/ns2:Column[upper-case(@name) = 'FLAGBLOQUEOCUENTA']) }</PRODUCT_BLOCK>
                      
                              <CREDITS_INFO>
                                <AMOUNT_ON_PERIOD>{ data($row/ns2:Column[upper-case(@name) = 'MONTOCREDITOS']) }</AMOUNT_ON_PERIOD>
                                <SUMMATION>{ data($row/ns2:Column[upper-case(@name) = 'NUMEROCREDITOS']) }</SUMMATION>
                                <INTEREST_ON_PERIOD>{ data($row/ns2:Column[upper-case(@name) = 'NUMEROINTERESESCREDITOS']) }</INTEREST_ON_PERIOD>
                                <INTERESTS_SUMMATION>{ data($row/ns2:Column[upper-case(@name) = 'NUMEROCREDITOS']) }</INTERESTS_SUMMATION>
                              </CREDITS_INFO>
                      
                              <DEBITS_INFO>
                                <AMOUNT_ON_PERIOD>{ data($row/ns2:Column[upper-case(@name) = 'MONTODEBITOS']) }</AMOUNT_ON_PERIOD>
                                <SUMMATION>{ data($row/ns2:Column[upper-case(@name) = 'NUMERODEBITOS']) }</SUMMATION>
                                <INTEREST_ON_PERIOD>{ data($row/ns2:Column[upper-case(@name) = 'NUMEROINTERESESDEBITOS']) }</INTEREST_ON_PERIOD>
                                <INTERESTS_SUMMATION>{ data($row/ns2:Column[upper-case(@name) = 'MONTOINTERESESDEBITOS']) }</INTERESTS_SUMMATION>
                              </DEBITS_INFO>
                            </TRANSACTION>
                        }
                        </PRODUCT_TRANSACTIONS>
                    </ASSET>
                </ASSETS>
                <LIABILITIES>
                    <CREDIT_CARDS_INFO>
                    {
                        for $row in $InputIntegrationTrxTarjeta/ns4:RowSet/ns4:Row
                        return
                        <CREDIT_CARD>
                            <ACCOUNT></ACCOUNT>
                            <BEHAVIOR_SCORE></BEHAVIOR_SCORE>
                            <QUALIFICATION_SCORE></QUALIFICATION_SCORE>
                            <QUALIFICATION_CUSTOMER_SCORE></QUALIFICATION_CUSTOMER_SCORE>
                            <STATUS></STATUS>
                            <AFFINITY_GROUP></AFFINITY_GROUP>
                            <PRODUCT></PRODUCT>
                            <CLEARING_MODEL></CLEARING_MODEL>
                            <OPENING_DATE></OPENING_DATE>
                            <CANCELATION_DATE></CANCELATION_DATE>
                            <LAST_EXTRA_DATE></LAST_EXTRA_DATE>
                            <CURRENT_DUE></CURRENT_DUE>
                            <CURRENT_LIMIT></CURRENT_LIMIT>
                            <CURRENT_BALANCE></CURRENT_BALANCE>
                            <CLOSING_BALANCE></CLOSING_BALANCE>
                            <EXTRA_BALANCE></EXTRA_BALANCE>
                            <INTRA_BALANCE></INTRA_BALANCE>
                            <ACTIVE_EXTRA_INSTALLMENTS></ACTIVE_EXTRA_INSTALLMENTS>
                            <CASH_DISCOUNT_DATE></CASH_DISCOUNT_DATE>
                            <SECOND_ACCOUNT_NEW_LIMIT></SECOND_ACCOUNT_NEW_LIMIT>
                            <SECOND_ACCOUNT_REJECTION></SECOND_ACCOUNT_REJECTION>
                            <LOCKCODE1></LOCKCODE1>
                            <LOCKCODE2></LOCKCODE2>
                            <LOGO></LOGO>
                            {
                                let $disponible := (data($row/ns4:Column[upper-case(@name) = 'Disponible_1']),data($row/ns4:Column[upper-case(@name) = 'Disponible_2']),data($row/ns4:Column[upper-case(@name) = 'Disponible_3'])
                                ,data($row/ns4:Column[upper-case(@name) = 'Disponible_4']), data($row/ns4:Column[upper-case(@name) = 'Disponible_5']),data($row/ns4:Column[upper-case(@name) = 'Disponible_6']),data($row/ns4:Column[upper-case(@name) = 'Disponible_7']),
                                data($row/ns4:Column[upper-case(@name) = 'Disponible_8']), data($row/ns4:Column[upper-case(@name) = 'Disponible_9']), data($row/ns4:Column[upper-case(@name) = 'Disponible_10']), data($row/ns4:Column[upper-case(@name) = 'Disponible_11']),
                                data($row/ns4:Column[upper-case(@name) = 'Disponible_12']))
                                return
	        											
                        
                           <AVAILABLE_CASH>{ sum($disponible) }</AVAILABLE_CASH>
                           }
                            <LOCK_DATE1></LOCK_DATE1>
                            <LOCK_DATE2></LOCK_DATE2>
                            <BIN></BIN>
                            <EXTRA_APPROVAL_DATE></EXTRA_APPROVAL_DATE>
                            <INTRA_APPROVAL_DATE></INTRA_APPROVAL_DATE>
                            <PIL_APPROVAL_DATE></PIL_APPROVAL_DATE>
                            <PRIOR_LIMIT></PRIOR_LIMIT>
                            <AUTH_BALANCE></AUTH_BALANCE>
                            <PRODUCT_TRANSACTIONS>
                              
                      {   
                      for $i in 1 to 12
                      where exists($row/ns4:Column[upper-case(@name)=concat('FECHACORTE_',$i)])
                      return
                        <TRANSACTION>
                          <CORTE_INDEX>{$i}</CORTE_INDEX>
                          <CARD_NUMBER>{data($row/ns4:Column[upper-case(@name) = 'NUMEROCUENTA'])}</CARD_NUMBER>
                          <PERIOD_DATE>{ data($row/ns4:Column[upper-case(@name) = concat('FECHACORTE_', $i)]) }</PERIOD_DATE>
                          <PERIOD_BALANCE>{ data($row/ns4:Column[upper-case(@name) = concat('SALDOCORTE_', $i)])}</PERIOD_BALANCE>
                          <AMOUNT_DUE>{ data($row/ns4:Column[upper-case(@name) = concat('PAGOMINIMO_', $i)])}</AMOUNT_DUE>
                          <PAYMENTS>{ data($row/ns4:Column[upper-case(@name) = concat('PAGOS_', $i)])}</PAYMENTS>
                          <MERCH_SALES>{ data($row/ns4:Column[upper-case(@name) = concat('CONSUMOS_', $i)]) }</MERCH_SALES>
                          <CASH_WITHDRAWAL>{data($row/ns4:Column[upper-case(@name) = concat('RETIROS_', $i)]) }</CASH_WITHDRAWAL>
                          <LIMIT>{data($row/ns4:Column[upper-case(@name) = concat('LIMITE_', $i)]) }</LIMIT>
                          <INTEREST>{data($row/ns4:Column[upper-case(@name) = concat('INTERESES_', $i)]) }</INTEREST>
                          <TOTAL_FEES>{data($row/ns4:Column[upper-case(@name) = concat('TOTALCARGOS_', $i)])}</TOTAL_FEES>
                          <CYCLE_DUE>{data($row/ns4:Column[upper-case(@name) = concat('MORA_', $i)])} </CYCLE_DUE>
                          <CYCLE_TOTAL_BALANCE>{data($row/ns4:Column[upper-case(@name) = concat('SALDOTOTAL_', $i)])}</CYCLE_TOTAL_BALANCE>
                          <EXTRA_CASH_INFO>
                            <BALANCE>{ data($row/ns4:Column[upper-case(@name) = concat('SALDOEXTRA_', $i)]) }</BALANCE>
                            <INSTALLMENT>{ data($row/ns4:Column[upper-case(@name) = concat('CUOTAEXTRA_', $i)]) }</INSTALLMENT>
                            <INTEREST>{ data($row/ns4:Column[upper-case(@name) = concat('INTERESESEXTRA_', $i)]) }</INTEREST>
                            <FEE>{ data($row/ns4:Column[upper-case(@name) = concat('CARGOSEXTRA_', $i)]) }</FEE>
                          </EXTRA_CASH_INFO>
                    
                          <INTRA_CASH_INFO>
                            <BALANCE>{ data($row/ns4:Column[upper-case(@name) = concat('SALDOINTRA_', $i)]) }</BALANCE>
                            <INSTALLMENT>{ data($row/ns4:Column[upper-case(@name) = concat('CUOTAINTRA_', $i)]) }</INSTALLMENT>
                            <INTEREST>{ data($row/ns4:Column[upper-case(@name) = concat('INTERESESINTRA_', $i)]) }</INTEREST>
                            <FEE>{ data($row/ns4:Column[upper-case(@name) = concat('CARGOSINTRA_', $i)]) }</FEE>
                          </INTRA_CASH_INFO>
                    
                          <EXTRA_FEE>{ data($row/ns4:Column[upper-case(@name) = concat('CUOTAEXTRA_', $i)]) }</EXTRA_FEE>
                          <INTRA_FEE>{ data($row/ns4:Column[upper-case(@name) = concat('CUOTAINTRA_', $i)]) }</INTRA_FEE>
                          <EXTRA_BALANCE>{ data($row/ns4:Column[upper-case(@name) = concat('SALDOEXTRA_', $i)]) }</EXTRA_BALANCE>
                          <INTRA_BALANCE>{ data($row/ns4:Column[upper-case(@name) = concat('SALDOINTRA_', $i)]) }</INTRA_BALANCE>

                        </TRANSACTION>
                    }
                            </PRODUCT_TRANSACTIONS>
                            <LAST_INTRA_DATE></LAST_INTRA_DATE>
                            <LAST_PIL_DATE></LAST_PIL_DATE>
                            <HISTORICAL_ARREA_LOC></HISTORICAL_ARREA_LOC>
                            <HISTORICAL_ARREA_USD></HISTORICAL_ARREA_USD>
                            <CHARGE_OFF_FLAG></CHARGE_OFF_FLAG>
                        </CREDIT_CARD>
                    }
                    </CREDIT_CARDS_INFO>
                    <LOANS_INFO>
                        <LOAN>
                            <NUMBER></NUMBER>
                            <AGENCY_CODE></AGENCY_CODE>
                            <SUB_APPLICATION></SUB_APPLICATION>
                            <OPENING_DATE></OPENING_DATE>
                            <CANCELATION_DATE></CANCELATION_DATE>
                            <INITIAL_AMOUNT></INITIAL_AMOUNT>
                            <CURRENT_BALANCE></CURRENT_BALANCE>
                            <PAYMENT_AMOUNT></PAYMENT_AMOUNT>
                            <RATE></RATE>
                            <TERM></TERM>
                            <PAYMENT_NUMBER></PAYMENT_NUMBER>
                            <FIRST_CAPITAL_PAYMENT_DATE></FIRST_CAPITAL_PAYMENT_DATE>
                            <LAST_PAYMENT_DATE></LAST_PAYMENT_DATE>
                            <PAID_PAYMENTS></PAID_PAYMENTS>
                            <CAPITAL_FREQUENCY></CAPITAL_FREQUENCY>
                            <DESTINATION_CODE></DESTINATION_CODE>
                            <MONTHLY_PRIME></MONTHLY_PRIME>
                            <CONTRACT_NUMBER></CONTRACT_NUMBER>
                            <CHARGES></CHARGES>
                            <INTEREST></INTEREST>
                            <INSURANCE></INSURANCE>
                            <OTHER_CHARGES></OTHER_CHARGES>
                            <CURRENT_DUE></CURRENT_DUE>
                            <DEBTOR_TYPE></DEBTOR_TYPE>
                            <CODE_TYPE></CODE_TYPE>
                            <GUARANTEE_TYPE></GUARANTEE_TYPE>
                            <PRODUCT_TRANSACTIONS>
                            {
                                for $row at $pos in $InputIntegrationConsultaTrxPrestamos/ns3:RowSet/ns3:Row
                                return
                                <TRANSACTION>
                                      <FLAG>{ concat('ROW_', $pos) }</FLAG>
                                      <LOAN_NUMBER>{ data($row/ns3:Column[upper-case(@name) = 'NUMEROPRESTAMO']) }</LOAN_NUMBER>
                                      <PERIOD_DATE>{ data($row/ns3:Column[upper-case(@name) = 'FECHACIERRE']) }</PERIOD_DATE>
                                      <PERIOD_BALANCE>{ data($row/ns3:Column[upper-case(@name) = 'SALDOTOTAL']) }</PERIOD_BALANCE>
                                      <CAPITAL_BALANCE>{ data($row/ns3:Column[upper-case(@name) = 'SALDOCAPITAL']) }</CAPITAL_BALANCE>
                                      <DUE_BALANCE>{ data($row/ns3:Column[upper-case(@name) = 'SALDOVENCIDO']) }</DUE_BALANCE>
                                      <CHARGES>{ data($row/ns3:Column[upper-case(@name) = 'CARGOS']) }</CHARGES>
                                      <INTEREST>{ data($row/ns3:Column[upper-case(@name) = 'INTERESES']) }</INTEREST>
                                      <PAYMENT>{ data($row/ns3:Column[upper-case(@name) = 'PAGOS']) }</PAYMENT>
                                      <INSURANCE>{ data($row/ns3:Column[upper-case(@name) = 'SEGUROS']) }</INSURANCE>
                                      <OTHER_CHARGES>{ data($row/ns3:Column[upper-case(@name) = 'OTROSCARGOS']) }</OTHER_CHARGES>
                                      <CYCLE_DUE>{ data($row/ns3:Column[upper-case(@name) = 'MORACIERRE']) }</CYCLE_DUE>
                                </TRANSACTION>
                            }
                            </PRODUCT_TRANSACTIONS>
                        </LOAN>
                    </LOANS_INFO>
                </LIABILITIES>
                <REFERENCIA_SIB></REFERENCIA_SIB>
            </CUSTOMER_INFO>
        </LOAN_MAINTENANCE>
        
      
        <LOAN_ORIGINATIONS>
            <PRE_APPROVED_OFFERS>
                <OFFER>
                    <INFORMATION_DATE></INFORMATION_DATE>
                    <TYPE></TYPE>
                    <DETAILS>
                        <FOR_12_MONTHS></FOR_12_MONTHS>
                        <FOR_18_MONTHS></FOR_18_MONTHS>
                        <FOR_24_MONTHS></FOR_24_MONTHS>
                        <FOR_36_MONTHS></FOR_36_MONTHS>
                        <FOR_48_MONTHS></FOR_48_MONTHS>
                        <FOR_60_MONTHS></FOR_60_MONTHS>
                    </DETAILS>
                    <INSTALLMENT></INSTALLMENT>
                    <RATE></RATE>
                    <TIMES_INCOME></TIMES_INCOME>
                </OFFER>
            </PRE_APPROVED_OFFERS>
            <INTERNAL_EXTRAS>
            {for $row at $pos in $InputIntegrationConsultaExtraFin/ns1:RowSet/ns1:Row
                  return
                  <EXTRA>
                      <FLAG>{ concat('ROW_', $pos) }</FLAG>
                      <ACCOUNT_NUMBER>{data($row/ns1:Column[upper-case(@name)="NUMEROCUENTA"])}</ACCOUNT_NUMBER>
                      <DATE>{data($row/ns1:Column[upper-case(@name)="FECHAEXTRA"])}</DATE>
                      <RATE>{data($row/ns1:Column[upper-case(@name)="TASAEXTRA"])}</RATE>
                      <AMOUNT>{data($row/ns1:Column[upper-case(@name)="MONTOTOMADO"])}</AMOUNT>
                      <INSTALLMENT>{data($row/ns1:Column[upper-case(@name)="CUOTAEXTRA"])}</INSTALLMENT>
                      <INSTALLMENT_COUNT>{data($row/ns1:Column[upper-case(@name)="CUOTANUMERO"])}</INSTALLMENT_COUNT>
                      <TOTAL_INSTALLMENT>{data($row/ns1:Column[upper-case(@name)="TOTALCUOTAS"])}</TOTAL_INSTALLMENT>
                  </EXTRA>
                 }
            </INTERNAL_EXTRAS>
            <REFERENCES_DETAILS>
                <QUERIES>
                    <QUERY_ITEM>
                        <ID></ID>
                        <DATE></DATE>
                        <ENTITY></ENTITY>
                        <TYPE></TYPE>
                        <MOTIVE></MOTIVE>
                    </QUERY_ITEM>
                </QUERIES>
                <REFERENCE_BUREAU_TUCA>
                    <REFERENCE>
                        <QUERY_ID></QUERY_ID>
                        <TYPE></TYPE>
                        <REFERENCE_NUMBER></REFERENCE_NUMBER>
                        <OBLIGATION_CODE></OBLIGATION_CODE>
                        <OBLIGATION_TYPE></OBLIGATION_TYPE>
                        <OBLIGATION_SECTOR></OBLIGATION_SECTOR>
                        <CREDITOR></CREDITOR>
                        <CREDIT_TYPE></CREDIT_TYPE>
                        <GUARANTEE_TYPE></GUARANTEE_TYPE>
                        <OPENING_DATE></OPENING_DATE>
                        <CANCELATION_DATE></CANCELATION_DATE>
                        <INFORMATION_DATE></INFORMATION_DATE>
                        <PAYMENT_METHOD></PAYMENT_METHOD>
                        <CATEGORY></CATEGORY>
                        <CURRENCY></CURRENCY>
                        <CREDIT_STATUS></CREDIT_STATUS>
                        <STATUS></STATUS>
                        <LIMIT></LIMIT>
                        <BALANCE></BALANCE>
                        <ARREAR_BALANCE></ARREAR_BALANCE>
                        <INSTALLMENT></INSTALLMENT>
                        <LAST_MOVEMENT_MONTH></LAST_MOVEMENT_MONTH>
                        <LAST_MOVEMENT_YEAR></LAST_MOVEMENT_YEAR>
                        <HISTORICAL_ARREAR></HISTORICAL_ARREAR>
                    </REFERENCE>
                </REFERENCE_BUREAU_TUCA>
                <REFERENCE_BUREAU_SIRC>
                    <REFERENCE>
                        <QUERY_ID></QUERY_ID>
                        <CREDITOR></CREDITOR>
                        <ASSET_TYPE></ASSET_TYPE>
                        <WARRANTY_TYPE></WARRANTY_TYPE>
                        <CURRENCY></CURRENCY>
                        <AMOUNT></AMOUNT>
                        <BALANCE></BALANCE>
                        <DUE_BALANCE></DUE_BALANCE>
                        <OPENING_DATE></OPENING_DATE>
                        <CONSESSION_DATE></CONSESSION_DATE>
                        <EXPIRATION_DATE></EXPIRATION_DATE>
                        <CANCELATION_DATE></CANCELATION_DATE>
                        <HISTORICAL_ARREAR></HISTORICAL_ARREAR>
                        <CATEGORY></CATEGORY>
                        <STATUS></STATUS>
                        <TYPE></TYPE>
                        <DEBTOR_TYPE></DEBTOR_TYPE>
                    </REFERENCE>
                </REFERENCE_BUREAU_SIRC>
                <ACTIVE_REFERENCES>
                    <REFERENCE>
                        <QUERY_ID></QUERY_ID>
                        <CREDITOR></CREDITOR>
                        <REFERENCE_NUMBER></REFERENCE_NUMBER>
                        <TYPE></TYPE>
                        <OBLIGATION_TYPE></OBLIGATION_TYPE>
                        <CREDIT_TYPE></CREDIT_TYPE>
                        <STATUS></STATUS>
                        <LIMIT></LIMIT>
                        <TERM></TERM>
                        <CURRENCY></CURRENCY>
                        <EXCHANGE_FACTOR></EXCHANGE_FACTOR>
                        <BALANCE></BALANCE>
                        <MIN_PAYMENT></MIN_PAYMENT>
                        <PAYMENT_DUE></PAYMENT_DUE>
                        <PAYMENT_METHOD></PAYMENT_METHOD>
                        <GUARANTEE></GUARANTEE>
                        <GUARANTEE_TYPE></GUARANTEE_TYPE>
                        <AMOUNT></AMOUNT>
                        <ARREAR_BALANCE></ARREAR_BALANCE>
                        <ARREAR_LEVEL></ARREAR_LEVEL>
                        <DUE_BALANCE></DUE_BALANCE>
                        <IN_EXECUTION></IN_EXECUTION>
                        <PUNISHED></PUNISHED>
                        <PUNISHED_BALANCE></PUNISHED_BALANCE>
                        <CATEGORY></CATEGORY>
                        <PERIOD></PERIOD>
                        <INFORMATION_DATE></INFORMATION_DATE>
                        <OPENING_DATE></OPENING_DATE>
                        <CANCELATION_DATE></CANCELATION_DATE>
                        <EXPIRATION_DATE></EXPIRATION_DATE>
                        <INSTALLMENT></INSTALLMENT>
                        <HISTORICAL_ARREAR></HISTORICAL_ARREAR>
                        <HISTORICAL_COUNT_LOC></HISTORICAL_COUNT_LOC>
                        <HISTORICAL_COUNT_DOL></HISTORICAL_COUNT_DOL>
                    </REFERENCE>
                </ACTIVE_REFERENCES>
                <HISTORICAL_REFERENCES>
                    <REFERENCE>
                        <QUERY_ID></QUERY_ID>
                        <CREDITOR></CREDITOR>
                        <REFERENCE_NUMBER></REFERENCE_NUMBER>
                        <TYPE></TYPE>
                        <OBLIGATION_TYPE></OBLIGATION_TYPE>
                        <CREDIT_TYPE></CREDIT_TYPE>
                        <STATUS></STATUS>
                        <LIMIT></LIMIT>
                        <TERM></TERM>
                        <CURRENCY></CURRENCY>
                        <EXCHANGE_FACTOR></EXCHANGE_FACTOR>
                        <BALANCE></BALANCE>
                        <MIN_PAYMENT></MIN_PAYMENT>
                        <PAYMENT_DUE></PAYMENT_DUE>
                        <PAYMENT_METHOD></PAYMENT_METHOD>
                        <GUARANTEE></GUARANTEE>
                        <GUARANTEE_TYPE></GUARANTEE_TYPE>
                        <AMOUNT></AMOUNT>
                        <ARREAR_BALANCE></ARREAR_BALANCE>
                        <ARREAR_LEVEL></ARREAR_LEVEL>
                        <DUE_BALANCE></DUE_BALANCE>
                        <IN_EXECUTION></IN_EXECUTION>
                        <PUNISHED></PUNISHED>
                        <PUNISHED_BALANCE></PUNISHED_BALANCE>
                        <CATEGORY></CATEGORY>
                        <PERIOD></PERIOD>
                        <INFORMATION_DATE></INFORMATION_DATE>
                        <OPENING_DATE></OPENING_DATE>
                        <CANCELATION_DATE></CANCELATION_DATE>
                        <EXPIRATION_DATE></EXPIRATION_DATE>
                        <INSTALLMENT></INSTALLMENT>
                        <HISTORICAL_ARREAR></HISTORICAL_ARREAR>
                        <HISTORICAL_COUNT_LOC></HISTORICAL_COUNT_LOC>
                        <HISTORICAL_COUNT_DOL></HISTORICAL_COUNT_DOL>
                    </REFERENCE>
                </HISTORICAL_REFERENCES>
            </REFERENCES_DETAILS>
        </LOAN_ORIGINATIONS>
        
    </ns5:consultaConsolidadaRiesgoClienteResponse>
};

local:func($InputIntegrationConsultaExtraFin, $InputIntegrationConsultaTrxPasivo, $InputIntegrationConsultaTrxPrestamos, $InputIntegrationTrxTarjeta)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../../BusinessServices/DWConsultaConsolidada/SJS/xsd/sjConsultaConsolidadaRiesgoClienteHNTypes.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/DWConsultaConsolidada/SJS/xsd/sjConsultaConsolidadaRiesgoClienteHNTypes"/>
        </con:importSchema>
        <con:importSchema location="../../../BusinessServices/DWConsultaConsolidada/integracionConsultaExtraFin/xsd/integracionConsultaExtraFin_sp.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/DWConsultaConsolidada/integracionConsultaExtraFin/xsd/integracionConsultaExtraFin_sp"/>
        </con:importSchema>
        <con:importSchema location="../../../BusinessServices/DWConsultaConsolidada/integracionConsultaTrxPasivos/xsd/integracionConsultaTrxPasivos_sp.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/DWConsultaConsolidada/integracionConsultaTrxPasivos/xsd/integracionConsultaTrxPasivos_sp"/>
        </con:importSchema>
        <con:importSchema location="../../../BusinessServices/DWConsultaConsolidada/integracionConsultaTrxPrestamos/xsd/integracionConsultaTrxPrestamos_sp.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/DWConsultaConsolidada/integracionConsultaTrxPrestamos/xsd/integracionConsultaTrxPrestamos_sp"/>
        </con:importSchema>
        <con:importSchema location="../../../BusinessServices/DWConsultaConsolidada/integracionConsultaTrxTarjetas/xsd/integracionConsultaTrxTarjetas_sp.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/DWConsultaConsolidada/integracionConsultaTrxTarjetas/xsd/integracionConsultaTrxTarjetas_sp"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>