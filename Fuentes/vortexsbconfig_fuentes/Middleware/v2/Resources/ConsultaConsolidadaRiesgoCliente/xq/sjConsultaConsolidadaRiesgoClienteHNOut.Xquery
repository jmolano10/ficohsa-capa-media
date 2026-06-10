<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns6="http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes";
(:: import schema at "../../../BusinessServices/DWConsultaConsolidada/SJS/xsd/sjConsultaConsolidadaRiesgoClienteHNTypes.xsd" ::)
declare namespace ns5="http://xmlns.oracle.com/pcbpel/adapter/db/sp/integracionConsultaOfertaPreaprobada";
(:: import schema at "../../../BusinessServices/DWConsultaConsolidada/integracionConsultaOfertaPreaprobada/xsd/integracionConsultaOfertaPreaprobada_sp.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/integracionConsultaPasivo";
(:: import schema at "../../../BusinessServices/DWConsultaConsolidada/integracionConsultaPasivo/xsd/integracionConsultaPasivo_sp.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/integracionConsultaPrestamos";
(:: import schema at "../../../BusinessServices/DWConsultaConsolidada/integracionConsultaPrestamos/xsd/integracionConsultaPrestamos_sp.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/integracionConsultaSolicitante";
(:: import schema at "../../../BusinessServices/DWConsultaConsolidada/integracionConsultaSolicitante/xsd/integracionConsultaSolicitante_sp.xsd" ::)
declare namespace ns4="http://xmlns.oracle.com/pcbpel/adapter/db/sp/integracionConsultaTarjetas";
(:: import schema at "../../../BusinessServices/DWConsultaConsolidada/integracionConsultaTarjetas/xsd/integracionConsultaTarjetas_sp.xsd" ::)

declare variable $InputIntegrationConsultaPasivo as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $InputIntegrationConsultaPrestamo as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $InputIntegrationConsultaSolicitante as element() (:: schema-element(ns3:OutputParameters) ::) external;
declare variable $InputIntegrationConsultaTarjeta as element() (:: schema-element(ns4:OutputParameters) ::) external;
declare variable $InputIntegrationConsultaOfertaPreAprobada as element() (:: schema-element(ns5:OutputParameters) ::) external;
declare variable $InputSjConsultaInformacionExtraFinTRX as element() (:: schema-element(ns6:consultaConsolidadaRiesgoClienteResponse) ::) external;

declare function local:func($InputIntegrationConsultaPasivo as element() (:: schema-element(ns1:OutputParameters) ::), 
                            $InputIntegrationConsultaPrestamo as element() (:: schema-element(ns2:OutputParameters) ::), 
                            $InputIntegrationConsultaSolicitante as element() (:: schema-element(ns3:OutputParameters) ::), 
                            $InputIntegrationConsultaTarjeta as element() (:: schema-element(ns4:OutputParameters) ::), 
                            $InputIntegrationConsultaOfertaPreAprobada as element() (:: schema-element(ns5:OutputParameters) ::), 
                            $InputSjConsultaInformacionExtraFinTRX as element() (:: schema-element(ns6:consultaConsolidadaRiesgoClienteResponse) ::)) 
                            as element() (:: schema-element(ns6:consultaConsolidadaRiesgoClienteResponse) ::) {
    <ns6:consultaConsolidadaRiesgoClienteResponse>
    
            <!-- ***************************************Bloque de mapeo de errores ****************************************--> 
    
           
           <statusInfo>
               <tagInfo> 
                    <CODE>{fn:data($InputIntegrationConsultaPasivo/ns1:CODIGO_RESPUESTA)}</CODE>  
                   <MESSAGE>{fn:data($InputIntegrationConsultaPasivo/ns1:MENSAJE_RESPUESTA)}</MESSAGE>
                   <NAME>SP CONSULTA PASIVO</NAME>
               </tagInfo>
                 <tagInfo>
                   <CODE>{fn:data($InputIntegrationConsultaPrestamo/ns2:CODIGO_RESPUESTA)}</CODE>
                   <MESSAGE>{fn:data($InputIntegrationConsultaPrestamo/ns2:MENSAJE_RESPUESTA)}</MESSAGE>
                   <NAME>SP CONSULTA PRESTAMO</NAME>
               </tagInfo>
                 <tagInfo>
                   <CODE>{fn:data($InputIntegrationConsultaSolicitante /ns3:CODIGO_RESPUESTA)}</CODE>
                   <MESSAGE>{fn:data($InputIntegrationConsultaSolicitante/ns3:MENSAJE_RESPUESTA)}</MESSAGE>
                   <NAME>SP CONSULTA SOLICITANTE</NAME>
               </tagInfo>
                 <tagInfo>
                   <CODE>{fn:data($InputIntegrationConsultaTarjeta/ns4:CODIGO_RESPUESTA)}</CODE>
                   <MESSAGE>{fn:data($InputIntegrationConsultaTarjeta/ns4:MENSAJE_RESPUESTA)}</MESSAGE>
                   <NAME>SP CONSULTA TARJETA</NAME>
               </tagInfo>
                <tagInfo>
                   <CODE>{fn:data($InputIntegrationConsultaOfertaPreAprobada/ns5:CODIGO_RESPUESTA)}</CODE>
                   <MESSAGE>{fn:data($InputIntegrationConsultaOfertaPreAprobada/ns5:MENSAJE_RESPUESTA)}</MESSAGE>
                   <NAME>SP CONSULTA OFERTA PREA PROBADA</NAME>
               </tagInfo>
                 <!-- ***************** Llamado a Mapeo de error de los sp del hijo  **************************-->
                <tagInfo>
                {
                for $hj in $InputSjConsultaInformacionExtraFinTRX/statusInfo/tagInfo 
                where $hj/NAME = 'SP EXTRA FIN'
                return
                (
                   <CODE>{data($hj/CODE)}</CODE>,
                   <MESSAGE>{data($hj/MESSAGE)}</MESSAGE>,
                   <NAME>{data($hj/NAME)}</NAME>
                )
                }
               </tagInfo>
               <tagInfo>
               {
                for $hj in $InputSjConsultaInformacionExtraFinTRX/statusInfo/tagInfo 
                where $hj/NAME = 'SP TRX PASIVO'
                return
                (
                   <CODE>{data($hj/CODE)}</CODE>,
                   <MESSAGE>{data($hj/MESSAGE)}</MESSAGE>,
                   <NAME>{data($hj/NAME)}</NAME>
                )
                }
               </tagInfo>
               <tagInfo>
               {
                for $hj in $InputSjConsultaInformacionExtraFinTRX/statusInfo/tagInfo 
                where $hj/NAME = 'SP TRX PRESTAMOS'
                return
                (
                   <CODE>{data($hj/CODE)}</CODE>,
                   <MESSAGE>{data($hj/MESSAGE)}</MESSAGE>,
                   <NAME>{data($hj/NAME)}</NAME>
                )
                }
               </tagInfo>
               <tagInfo>
               {
                for $hj in $InputSjConsultaInformacionExtraFinTRX/statusInfo/tagInfo 
                where $hj/NAME = 'SP TRX TARJETAS'
                return
                (
                   <CODE>{data($hj/CODE)}</CODE>,
                   <MESSAGE>{data($hj/MESSAGE)}</MESSAGE>,
                   <NAME>{data($hj/NAME)}</NAME>
                )
                }
               </tagInfo>
           </statusInfo>
         
            <!-- *************************************************** Llamado a cada SP LOAN MAINTANCE******************************************************************-->


        <LOAN_MAINTENANCE>
        {
            for $row in $InputIntegrationConsultaSolicitante/ns3:RowSet/ns3:Row
            return
            <CUSTOMER_INFO>
                <ID>{ data($row/ns3:Column[upper-case(@name) = "IDENTIDAD"]) }</ID>
                <FISCAL_ID></FISCAL_ID>
                <FIRST_NAME></FIRST_NAME>
                <LAST_NAME></LAST_NAME>
                <BIRTH_DATE></BIRTH_DATE>
                <TARGET>{ data($row/ns3:Column[upper-case(@name) = "SEGMENTOCLIENTE"]) }</TARGET>
                <DATE_OF_BIRTH>{ data($row/ns3:Column[upper-case(@name) = "FECHANACIMIENTO"]) }</DATE_OF_BIRTH>
                <AGE>{ data($row/ns3:Column[upper-case(@name) = "EDAD"]) }</AGE>
                <TYPE>{ data($row/ns3:Column[upper-case(@name) = "TIPOCLIENTE"]) }</TYPE>
                <SALARY>{ data($row/ns3:Column[upper-case(@name) = "SALARIOCLIENTE"]) }</SALARY>
                <PAYROLL_SALARY>{  
                             if(data($row/ns3:Column[upper-case(@name) = "MONTOLPSPLANILLA"]) != "") then
                             (data($row/ns3:Column[upper-case(@name) = "MONTOLPSPLANILLA"]) )
                             else 0}
                </PAYROLL_SALARY>
                <CREDIT_MONTHS>{  
                if(data($row/ns3:Column[upper-case(@name) = "MESPLANILLA"]) != "") then
                             (data($row/ns3:Column[upper-case(@name) = "MESPLANILLA"]) )
                             else 0
                }</CREDIT_MONTHS>
                <FLAG_BLAZE>{ data($row/ns3:Column[upper-case(@name) = "FLAGBLAZE"]) }</FLAG_BLAZE>
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
                {
                     for $row in $InputIntegrationConsultaOfertaPreAprobada/ns5:RowSet/ns5:Row
                     return
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
                }
                </OFFERS>
                <ASSETS>
                {
                    for $row at $post in  $InputIntegrationConsultaPasivo/ns1:RowSet/ns1:Row
                    return         
                    <ASSET>
                        <NUMBER>{ data($row/ns1:Column[upper-case(@name) = "NUMEROCUENTA"]) }</NUMBER>
                        <CATEGORY>{ data($row/ns1:Column[upper-case(@name) = "CATEGORIA"]) }</CATEGORY>
                        <CURRENCY>{ data($row/ns1:Column[upper-case(@name) = "MONEDA"]) }</CURRENCY>
                        <OPENING_DATE>{ data($row/ns1:Column[upper-case(@name) = "FECHAAPERTURA"]) }</OPENING_DATE>
                        <CANCELATION_DATE>{ data($row/ns1:Column[upper-case(@name) = "FECHACANCELACION"]) }</CANCELATION_DATE>
                        <CURRENT_BALANCE>{ data($row/ns1:Column[upper-case(@name) = "SALDOACTUAL"]) }</CURRENT_BALANCE>
                        <END_OF_MONTH_BALANCE>{ data($row/ns1:Column[upper-case(@name) = "SALDOFINMES"]) }</END_OF_MONTH_BALANCE>
                        <AVERAGE_BALANCE>{ data($row/ns1:Column[upper-case(@name) = "SALDOPROMEDIO"]) }</AVERAGE_BALANCE>
                        <PRODUCT_TRANSACTIONS>
                            { for $RHJ in $InputSjConsultaInformacionExtraFinTRX/LOAN_MAINTENANCE/CUSTOMER_INFO/ASSETS/ASSET/PRODUCT_TRANSACTIONS/TRANSACTION
                                where some $r in $row satisfies data($RHJ/ASSET_NUMBER) =  data($r/ns1:Column[upper-case(@name) = "NUMEROCUENTA"])
                        return
                            <TRANSACTION>
                                <ASSET_NUMBER>{data($RHJ/ASSET_NUMBER)}</ASSET_NUMBER>
                                <PERIOD_DATE>{data($RHJ/PERIOD_DATE) }</PERIOD_DATE>
                                <PERIOD_BALANCE>{data($RHJ/PERIOD_BALANCE)}</PERIOD_BALANCE>
                                <MAX_BALANCE>{data($RHJ/MAX_BALANCE)}</MAX_BALANCE>
                                <MIN_BALANCE>{data($RHJ/MIN_BALANCE)}</MIN_BALANCE>
                                <AVERAGE_BALANCE>{data($RHJ/AVERAGE_BALANCE)}</AVERAGE_BALANCE>
                                <LAST_CREDIT_DATE>{data($RHJ/LAST_CREDIT_DATE)}</LAST_CREDIT_DATE>
                                <LAST_DEBIT_DATE>{data($RHJ/LAST_DEBIT_DATE)}</LAST_DEBIT_DATE>
                                <FACILITIES>{data($RHJ/FACILITIES)}</FACILITIES>
                                <LEGAL_REPRESENTATIVE>{data($RHJ/LEGAL_REPRESENTATIVE)}</LEGAL_REPRESENTATIVE>
                                <PAYROLL_ACCOUNTS>{data($RHJ/PAYROLL_ACCOUNTS)}</PAYROLL_ACCOUNTS>
                                <PAYROLL_CREDIT_AMOUNT>{data($RHJ/PAYROLL_CREDIT_AMOUNT)}</PAYROLL_CREDIT_AMOUNT>
                                <JOINT_ACCOUNTS>{data($RHJ/JOINT_ACCOUNTS)}</JOINT_ACCOUNTS>
                                <PRODUCT_BLOCK>{data($RHJ/PRODUCT_BLOCK)}</PRODUCT_BLOCK>
                                <CREDITS_INFO>
                                    <AMOUNT_ON_PERIOD>{data($RHJ/CREDITS_INFO/AMOUNT_ON_PERIOD)}</AMOUNT_ON_PERIOD>
                                    <SUMMATION>{$RHJ/CREDITS_INFO/SUMMATION/text()}</SUMMATION>
                                    <INTEREST_ON_PERIOD>{data($RHJ/CREDITS_INFO/AMOUNT_ON_PERIOD)}</INTEREST_ON_PERIOD>
                                    <INTERESTS_SUMMATION>{data($RHJ/CREDITS_INFO/INTERESTS_SUMMATION)}</INTERESTS_SUMMATION>
                                </CREDITS_INFO>
                                <DEBITS_INFO>
                                    <AMOUNT_ON_PERIOD>{data($RHJ/DEBITS_INFO/AMOUNT_ON_PERIOD)}</AMOUNT_ON_PERIOD>
                                    <SUMMATION>{data($RHJ/DEBITS_INFO/SUMMATION)}</SUMMATION>
                                    <INTEREST_ON_PERIOD>{data($RHJ/DEBITS_INFO/INTEREST_ON_PERIOD)}</INTEREST_ON_PERIOD>
                                    <INTERESTS_SUMMATION>{data($RHJ/DEBITS_INFO/INTERESTS_SUMMATION)}</INTERESTS_SUMMATION>
                                </DEBITS_INFO>
                            </TRANSACTION>
                            }
                        </PRODUCT_TRANSACTIONS>
                    </ASSET>
                  }
                </ASSETS>
                <LIABILITIES>
                    <CREDIT_CARDS_INFO>
                    {
                        for $row at $pos in $InputIntegrationConsultaTarjeta/ns4:RowSet/ns4:Row
                        return
                        <CREDIT_CARD>
                            <TYPE>{ concat('ROW_', $pos) }</TYPE>
                            <ACCOUNT>{ data($row/ns4:Column[upper-case(@name) = "NUMEROCUENTA"]) }</ACCOUNT>
                            <BEHAVIOR_SCORE>{ data($row/ns4:Column[upper-case(@name) = "BEHAVIORSCORE"]) }</BEHAVIOR_SCORE>
                            <QUALIFICATION_SCORE>{ data($row/ns4:Column[upper-case(@name) = "CALIFICACIONSCORE"]) }</QUALIFICATION_SCORE>
                            <QUALIFICATION_CUSTOMER_SCORE>{ data($row/ns4:Column[upper-case(@name) = "CALIFICACIONSCORECLIENTE"]) }</QUALIFICATION_CUSTOMER_SCORE>
                            <STATUS>{ data($row/ns4:Column[upper-case(@name) = "ESTADO"]) }</STATUS>
                            <AFFINITY_GROUP>{ data($row/ns4:Column[upper-case(@name) = "GRUPOAFINIDAD"]) }</AFFINITY_GROUP>
                            <PRODUCT>{ data($row/ns4:Column[upper-case(@name) = "PRODUCTO"]) }</PRODUCT>
                            <CLEARING_MODEL></CLEARING_MODEL>
                            <OPENING_DATE>{ data($row/ns4:Column[upper-case(@name) = "FECHAAPERTURA"]) }</OPENING_DATE>
                            <CANCELATION_DATE>{ data($row/ns4:Column[upper-case(@name) = "FECHACANCELACION"]) }</CANCELATION_DATE>
                            <LAST_EXTRA_DATE>{ data($row/ns4:Column[upper-case(@name) = "FECHAULTIMOEXTRA"]) }</LAST_EXTRA_DATE>
                            <CURRENT_DUE>{ data($row/ns4:Column[upper-case(@name) = "MORAACTUAL"]) }</CURRENT_DUE>
                            <CURRENT_LIMIT>{ data($row/ns4:Column[upper-case(@name) = "LIMITEACTUAL"]) }</CURRENT_LIMIT>
                            <CURRENT_BALANCE>{ data($row/ns4:Column[upper-case(@name) = "SALDOACTUAL"]) }</CURRENT_BALANCE>
                            <CLOSING_BALANCE>{ data($row/ns4:Column[upper-case(@name) = "SALDOCORTE"]) }</CLOSING_BALANCE>
                            <EXTRA_BALANCE>{ data($row/ns4:Column[upper-case(@name) = "SALDOEXTRA"]) }</EXTRA_BALANCE>
                            <INTRA_BALANCE>{ data($row/ns4:Column[upper-case(@name) = "SALDOINTRA"]) }</INTRA_BALANCE>
                            <ACTIVE_EXTRA_INSTALLMENTS>{ data($row/ns4:Column[upper-case(@name) = "CUOTASEXTRAVIGENTES"]) }</ACTIVE_EXTRA_INSTALLMENTS>
                            <CASH_DISCOUNT_DATE></CASH_DISCOUNT_DATE>
                            <SECOND_ACCOUNT_NEW_LIMIT></SECOND_ACCOUNT_NEW_LIMIT>
                            <SECOND_ACCOUNT_REJECTION></SECOND_ACCOUNT_REJECTION>
                            <LOCKCODE1>{ data($row/ns4:Column[upper-case(@name) = "CODBLOQUE1"]) }</LOCKCODE1>
                            <LOCKCODE2>{ data($row/ns4:Column[upper-case(@name) = "CODBLOQUE2"]) }</LOCKCODE2>
                            <LOGO>{ data($row/ns4:Column[upper-case(@name) = "GRUPOAFINIDAD"]) }</LOGO>
                          
                            <AVAILABLE_CASH>{data($InputSjConsultaInformacionExtraFinTRX/LOAN_MAINTENANCE/CUSTOMER_INFO/LIABILITIES/CREDIT_CARDS_INFO/CREDIT_CARD/AVAILABLE_CASH)[$pos]}</AVAILABLE_CASH>
                         
                            <LOCK_DATE1>{ data($row/ns4:Column[upper-case(@name) = "FECBLOQUE1"]) }</LOCK_DATE1>
                            <LOCK_DATE2>{ data($row/ns4:Column[upper-case(@name) = "FECBLOQUE2"]) }</LOCK_DATE2>
                            <BIN></BIN>
                            <EXTRA_APPROVAL_DATE>{ data($row/ns4:Column[upper-case(@name) = "FECHA_APROBACION_EXTRA"]) }</EXTRA_APPROVAL_DATE>   
                            <INTRA_APPROVAL_DATE>{ data($row/ns4:Column[upper-case(@name) = "FECHA_APROBACION_EXTRA"]) }</INTRA_APPROVAL_DATE>
                            <PIL_APPROVAL_DATE>{ data($row/ns4:Column[upper-case(@name) = "FECHA_APROBACION_INTRA"]) }</PIL_APPROVAL_DATE>
                            <PRIOR_LIMIT>{ data($row/ns4:Column[upper-case(@name) = "LIMITE_PREVIO"]) }</PRIOR_LIMIT>
                            <AUTH_BALANCE>{ data($row/ns4:Column[upper-case(@name) = "SALDO_AUTORIZACION"]) }</AUTH_BALANCE>
                            <PRODUCT_TRANSACTIONS>
                                {
                                for $RHJ in $InputSjConsultaInformacionExtraFinTRX/LOAN_MAINTENANCE/CUSTOMER_INFO/LIABILITIES/CREDIT_CARDS_INFO/CREDIT_CARD/PRODUCT_TRANSACTIONS/TRANSACTION
                                let $pd := $InputIntegrationConsultaTarjeta/ns4:RowSet/ns4:Row
                                where some $r in $pd satisfies data($RHJ/CARD_NUMBER) =  replace(data($r/ns4:Column[upper-case(@name) = "NUMEROCUENTA"]),'^0+','')
                                return
                                <TRANSACTION>
                                    <CARD_NUMBER>{data($RHJ/CARD_NUMBER)}</CARD_NUMBER>
                                    <PERIOD_DATE>{data($RHJ/PERIOD_DATE)}</PERIOD_DATE>
                                    <PERIOD_BALANCE>{data($RHJ/PERIOD_BALANCE)}</PERIOD_BALANCE>
                                    <AMOUNT_DUE>{data($RHJ/AMOUNT_DUE)}</AMOUNT_DUE>
                                    <PAYMENTS>{data($RHJ/PAYMENTS)}</PAYMENTS>
                                    <MERCH_SALES>{data($RHJ/MERCH_SALES)}</MERCH_SALES>
                                    <CASH_WITHDRAWAL>{data($RHJ/CASH_WITHDRAWAL)}</CASH_WITHDRAWAL>
                                    <LIMIT>{data($RHJ/LIMIT)}</LIMIT>
                                    <OTHER_TRANSACTIONS>{data($RHJ/OTHER_TRANSACTIONS)}</OTHER_TRANSACTIONS>
                                    <INTEREST>{data($RHJ/INTEREST)}</INTEREST>
                                    <TOTAL_FEES>{data($RHJ/TOTAL_FEES)}</TOTAL_FEES>
                                    <OTHER_DEBITS>{data($RHJ/OTHER_DEBITS)}</OTHER_DEBITS>
                                    <CYCLE_DUE>{data($RHJ/CYCLE_DUE)}</CYCLE_DUE>
                                    <CYCLE_TOTAL_BALANCE>{data($RHJ/CYCLE_TOTAL_BALANCE)}</CYCLE_TOTAL_BALANCE>
                                    <EXTRA_CASH_INFO>
                                        <BALANCE>{data($RHJ/EXTRA_CASH_INFO/BALANCE)}</BALANCE>
                                        <INSTALLMENT>{data($RHJ/EXTRA_CASH_INFO/INSTALLMENT)}</INSTALLMENT>
                                        <INTEREST>{data($RHJ/EXTRA_CASH_INFO/INTEREST)}</INTEREST>
                                        <FEE>{data($RHJ/EXTRA_CASH_INFO/FEE)}</FEE>
                                    </EXTRA_CASH_INFO>
                                    <INTRA_CASH_INFO>
                                        <BALANCE>{data($RHJ/INTRA_CASH_INFO/BALANCE)}</BALANCE>
                                        <INSTALLMENT>{data($RHJ/INTRA_CASH_INFO/INSTALLMENT)}</INSTALLMENT>
                                        <INTEREST>{data($RHJ/INTRA_CASH_INFO/INTEREST)}</INTEREST>
                                        <FEE>{data($RHJ/INTRA_CASH_INFO/FEE)}</FEE>
                                    </INTRA_CASH_INFO>
                                    <EXTRA_FEE>{data($RHJ/EXTRA_FEE)}</EXTRA_FEE>
                                    <INTRA_FEE>{data($RHJ/INTRA_FEE)}</INTRA_FEE>
                                    <EXTRA_BALANCE>{data($RHJ/EXTRA_BALANCE)}</EXTRA_BALANCE>
                                    <INTRA_BALANCE>{data($RHJ/INTRA_BALANCE)}</INTRA_BALANCE>
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
                    {
                        for $row at $pos in $InputIntegrationConsultaPrestamo/ns2:RowSet/ns2:Row
                        return
                        <LOAN>
                            <FLAG>{ concat('ROW_', $pos) }</FLAG>
                            <NUMBER>{ data($row/ns2:Column[upper-case(@name) = 'NUMEROPRESTAMO']) }</NUMBER>
                            <AGENCY_CODE>{ data($row/ns2:Column[upper-case(@name) = "CODIGOAGENCIA"]) }</AGENCY_CODE>
                            <SUB_APPLICATION>{ data($row/ns2:Column[upper-case(@name) = "CODIGOSUBAPLICACION"]) }</SUB_APPLICATION>
                            <OPENING_DATE>{ data($row/ns2:Column[upper-case(@name) = "FECHAAPERTURA"]) }</OPENING_DATE>
                            <CANCELATION_DATE>{ data($row/ns2:Column[upper-case(@name) = "FECHACANCELACION"]) }</CANCELATION_DATE>
                            <INITIAL_AMOUNT>{ data($row/ns2:Column[upper-case(@name) = "MONTOINICIAL"]) }</INITIAL_AMOUNT>
                            <CURRENT_BALANCE>{ data($row/ns2:Column[upper-case(@name) = "SALDOACTUAL"]) }</CURRENT_BALANCE>
                            <PAYMENT_AMOUNT>{ data($row/ns2:Column[upper-case(@name) = "VALORCUOTA"]) }</PAYMENT_AMOUNT>
                            <RATE>{ data($row/ns2:Column[upper-case(@name) = "TASA"]) }</RATE>
                            <TERM>{ data($row/ns2:Column[upper-case(@name) = "PLAZO"]) }</TERM>
                            <PAYMENT_NUMBER>{ data($row/ns2:Column[upper-case(@name) = "NUMEROCUOTAS"]) }</PAYMENT_NUMBER>
                            <FIRST_CAPITAL_PAYMENT_DATE>{ data($row/ns2:Column[upper-case(@name) = "FECHAPRIMERPAGOCAPITAL"]) }</FIRST_CAPITAL_PAYMENT_DATE>
                            <LAST_PAYMENT_DATE>{ data($row/ns2:Column[upper-case(@name) = "FECHAULTIMOPAGO"]) }</LAST_PAYMENT_DATE>
                            <PAID_PAYMENTS>{ data($row/ns2:Column[upper-case(@name) = "CANTIDADCUOTASPAGADAS"]) }</PAID_PAYMENTS>
                            <CAPITAL_FREQUENCY>{ data($row/ns2:Column[upper-case(@name) = "FRECUENCIACAPITAL"]) }</CAPITAL_FREQUENCY>
                            <DESTINATION_CODE>{ data($row/ns2:Column[upper-case(@name) = "CODIGODESTINO"]) }</DESTINATION_CODE>
                            <MONTHLY_PRIME>{ data($row/ns2:Column[upper-case(@name) = "PRIMAMENSUAL"]) }</MONTHLY_PRIME>
                            <CONTRACT_NUMBER>{ data($row/ns2:Column[upper-case(@name) = "NUMEROCONTRATO"]) }</CONTRACT_NUMBER>
                            <CHARGES>{ data($row/ns2:Column[upper-case(@name) = "CARGOS"]) }</CHARGES>
                            <INTEREST>{ data($row/ns2:Column[upper-case(@name) = "INTERES"]) }</INTEREST>
                            <INSURANCE>{ data($row/ns2:Column[upper-case(@name) = "SEGUROS"]) }</INSURANCE>
                            <OTHER_CHARGES>{ data($row/ns2:Column[upper-case(@name) = "OTROSCARGOS"]) }</OTHER_CHARGES>
                            <CURRENT_DUE>{ data($row/ns2:Column[upper-case(@name) = "MORAACTUAL"]) }</CURRENT_DUE>
                            <DEBTOR_TYPE>{ data($row/ns2:Column[upper-case(@name) = "TIPODEUDOR"]) }</DEBTOR_TYPE>
                            <CODE_TYPE>{ data($row/ns2:Column[upper-case(@name) = "CODIGOTIPOPRESTAMO"]) }</CODE_TYPE>
                            <GUARANTEE_TYPE>{ data($row/ns2:Column[upper-case(@name) = "CODIGOTIPOGARANTIA"]) }</GUARANTEE_TYPE>
                            <PRODUCT_TRANSACTIONS>
                                    {for $RHJ in $InputSjConsultaInformacionExtraFinTRX/LOAN_MAINTENANCE/CUSTOMER_INFO/LIABILITIES/LOANS_INFO/LOAN/PRODUCT_TRANSACTIONS/TRANSACTION
                                    
                                return
                                <TRANSACTION>
                                    <LOAN_NUMBER>{$RHJ/LOAN_NUMBER/text()}</LOAN_NUMBER>
                                    <PERIOD_DATE>{$RHJ/PERIOD_DATE/text()}</PERIOD_DATE>
                                    <PERIOD_BALANCE>{$RHJ/PERIOD_BALANCE/text()}</PERIOD_BALANCE>
                                    <CAPITAL_BALANCE>{$RHJ/CAPITAL_BALANCE/text()}</CAPITAL_BALANCE>
                                    <DUE_BALANCE>{$RHJ/DUE_BALANCE/text()}</DUE_BALANCE>
                                    <CHARGES>{$RHJ/CHARGES/text()}</CHARGES>
                                    <INTEREST>{$RHJ/INTEREST/text()}</INTEREST>
                                    <PAYMENT>{$RHJ/PAYMENT/text()}</PAYMENT>
                                    <INSURANCE>{$RHJ/INSURANCE/text()}</INSURANCE>
                                    <OTHER_CHARGES>{$RHJ/OTHER_CHARGES/text()}</OTHER_CHARGES>
                                    <CYCLE_DUE>{$RHJ/CYCLE_DUE/text()}</CYCLE_DUE>
                                </TRANSACTION>
                                }
                            </PRODUCT_TRANSACTIONS>
                        </LOAN>
                    }
                    </LOANS_INFO>
                </LIABILITIES>
                <REFERENCIA_SIB></REFERENCIA_SIB>
            </CUSTOMER_INFO>
        }
        </LOAN_MAINTENANCE>
        
        <!-- *************************************************** Llamado a cada SP LOAN ORIGINATION *****************************************************************-->
        
         <LOAN_ORIGINATIONS>
                <PRE_APPROVED_OFFERS>
                {
                    let $tipos := ('FICOCREDITO', 'FICOYA', 'OPI', 'RETANQUEO')
                    for $row at $pos in $InputIntegrationConsultaOfertaPreAprobada/ns5:RowSet/ns5:Row
                    for $tipo in $tipos
                    return
                    <OFFER>
                        <FLAG>{ concat('ROW_', $pos) }</FLAG>
                        <INFORMATION_DATE>{ data($row/ns5:Column[upper-case(@name) = "FECHAINFORMACION"]) }</INFORMATION_DATE>
                        <TYPE>{$tipo}</TYPE>
                        <DETAILS>
                            <FOR_12_MONTHS>{ data($row/ns5:Column[upper-case(@name) = concat("OFERTA",$tipo,"12")]) }</FOR_12_MONTHS>
                            <FOR_18_MONTHS></FOR_18_MONTHS>
                            <FOR_24_MONTHS>{ data($row/ns5:Column[upper-case(@name) = concat("OFERTA",$tipo,"24")]) }</FOR_24_MONTHS>
                            <FOR_36_MONTHS>{ data($row/ns5:Column[upper-case(@name) = concat("OFERTA",$tipo,"36")]) }</FOR_36_MONTHS>
                            <FOR_48_MONTHS>{ data($row/ns5:Column[upper-case(@name) = concat("OFERTA",$tipo,"48")]) }</FOR_48_MONTHS>
                            <FOR_60_MONTHS>{ data($row/ns5:Column[upper-case(@name) = concat("OFERTA",$tipo,"60")]) }</FOR_60_MONTHS>
                        </DETAILS>
                        <INSTALLMENT>{ data($row/ns5:Column[upper-case(@name) = concat("CUOTA",$tipo)]) }</INSTALLMENT>
                        <RATE>{ data($row/ns5:Column[upper-case(@name) = concat("TASA",$tipo)]) }</RATE>
                        <TIMES_INCOME>{ data($row/ns5:Column[upper-case(@name) = concat("TIMESINCOME",$tipo)]) }</TIMES_INCOME>
                      </OFFER> 
                }
                </PRE_APPROVED_OFFERS>
                <INTERNAL_EXTRAS>
                   {for $RHJ  in $InputSjConsultaInformacionExtraFinTRX/LOAN_ORIGINATIONS/INTERNAL_EXTRAS/EXTRA
                return
                    <EXTRA>
                        <ACCOUNT_NUMBER>{data($RHJ/ACCOUNT_NUMBER)}</ACCOUNT_NUMBER>
                        <DATE>{data($RHJ/DATE)}</DATE>
                        <RATE>{data($RHJ/RATE)}</RATE>
                        <AMOUNT>{data($RHJ/AMOUNT)}</AMOUNT>
                        <INSTALLMENT>{data($RHJ/INSTALLMENT)}</INSTALLMENT>
                        <INSTALLMENT_COUNT>{data($RHJ/INSTALLMENT_COUNT)}</INSTALLMENT_COUNT>
                        <TOTAL_INSTALLMENT>{data($RHJ/TOTAL_INSTALLMENT)}</TOTAL_INSTALLMENT>
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
        
        
    </ns6:consultaConsolidadaRiesgoClienteResponse>
};

local:func($InputIntegrationConsultaPasivo, $InputIntegrationConsultaPrestamo, $InputIntegrationConsultaSolicitante, $InputIntegrationConsultaTarjeta, $InputIntegrationConsultaOfertaPreAprobada, $InputSjConsultaInformacionExtraFinTRX)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../../BusinessServices/DWConsultaConsolidada/SJS/xsd/sjConsultaConsolidadaRiesgoClienteHNTypes.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/DWConsultaConsolidada/SJS/xsd/sjConsultaConsolidadaRiesgoClienteHNTypes"/>
        </con:importSchema>
        <con:importSchema location="../../../BusinessServices/DWConsultaConsolidada/integracionConsultaOfertaPreaprobada/xsd/integracionConsultaOfertaPreaprobada_sp.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/DWConsultaConsolidada/integracionConsultaOfertaPreaprobada/xsd/integracionConsultaOfertaPreaprobada_sp"/>
        </con:importSchema>
        <con:importSchema location="../../../BusinessServices/DWConsultaConsolidada/integracionConsultaPasivo/xsd/integracionConsultaPasivo_sp.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/DWConsultaConsolidada/integracionConsultaPasivo/xsd/integracionConsultaPasivo_sp"/>
        </con:importSchema>
        <con:importSchema location="../../../BusinessServices/DWConsultaConsolidada/integracionConsultaPrestamos/xsd/integracionConsultaPrestamos_sp.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/DWConsultaConsolidada/integracionConsultaPrestamos/xsd/integracionConsultaPrestamos_sp"/>
        </con:importSchema>
        <con:importSchema location="../../../BusinessServices/DWConsultaConsolidada/integracionConsultaSolicitante/xsd/integracionConsultaSolicitante_sp.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/DWConsultaConsolidada/integracionConsultaSolicitante/xsd/integracionConsultaSolicitante_sp"/>
        </con:importSchema>
        <con:importSchema location="../../../BusinessServices/DWConsultaConsolidada/integracionConsultaTarjetas/xsd/integracionConsultaTarjetas_sp.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/DWConsultaConsolidada/integracionConsultaTarjetas/xsd/integracionConsultaTarjetas_sp"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>