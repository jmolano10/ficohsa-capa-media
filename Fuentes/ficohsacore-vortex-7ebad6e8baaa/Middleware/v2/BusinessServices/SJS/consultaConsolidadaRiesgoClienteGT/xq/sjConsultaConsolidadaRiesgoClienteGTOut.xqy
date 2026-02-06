xquery version "2004-draft" encoding "Cp1252";
(:: pragma  parameter="$resultGroup" type="xs:anyType" ::)
(:: pragma bea:global-element-return element="ns2:sjConsultaConsolidadaRiesgoClienteGTResponse" location="../xsd/sjConsultaConsolidadaRiesgoClienteGTTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaConsolidadaRiesgoClienteGT/xq/sjConsultaConsolidadaRiesgoClienteGTOut/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaConsolidadaRiesgoClienteGTTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/integracionConsultaPasivos";
declare namespace ns4 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/integracionConsultaPrestamos";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/integracionConsultaTRXPasivos";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/integracionConsultaTarjetas";
declare namespace ns5 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/integracionConsultaSolicitante";

declare function xf:sjConsultaConsolidadaRiesgoClienteGTOut($resultGroup as element(*))
    as element(ns2:sjConsultaConsolidadaRiesgoClienteGTResponse) {
        <ns2:sjConsultaConsolidadaRiesgoClienteGTResponse>
            <ns2:APPLICANT_RESPONSE>
            	<ns2:RESPONSE_CODE>{data($resultGroup/APPLICANT_RESPONSE//ns5:CODIGO_RESPUESTA) }</ns2:RESPONSE_CODE>
            	<ns2:RESPONSE_MESSAGE>{ data($resultGroup/APPLICANT_RESPONSE//ns5:MENSAJE_RESPUESTA)}</ns2:RESPONSE_MESSAGE>
            {for $row in $resultGroup/APPLICANT_RESPONSE//ns5:Row 
            	return
                <ns2:APPLICANT>
                    <ns2:IDENTIFICATION>{data($row/ns5:Column[upper-case(@name)="IDENTIDAD"])}</ns2:IDENTIFICATION>
                    <ns2:CUSTOMER_SEGMENT>{data($row/ns5:Column[upper-case(@name)="SEGMENTOCLIENTE"])}</ns2:CUSTOMER_SEGMENT>
                    <ns2:BIRTH_DATE>{data($row/ns5:Column[upper-case(@name)="FECHA_NACIMIENTO"])}</ns2:BIRTH_DATE>
                    <ns2:AGE>{data($row/ns5:Column[upper-case(@name)="EDAD"])}</ns2:AGE>
                    <ns2:CUSTOMER_TYPE>{data($row/ns5:Column[upper-case(@name)="TIPOCLIENTE"])}</ns2:CUSTOMER_TYPE>
                    <ns2:CUSTOMER_SALARY>{data($row/ns5:Column[upper-case(@name)="SALARIOCLIENTE"])}</ns2:CUSTOMER_SALARY>
                    <ns2:FLAG_BLAZE>{data($row/ns5:Column[upper-case(@name)="FLAGBLAZE"])}</ns2:FLAG_BLAZE>
                    <ns2:PAYROLL_MONTH>{data($row/ns5:Column[upper-case(@name)="MESPLANILLA"])}</ns2:PAYROLL_MONTH>
                    <ns2:PAYROLL_AMOUNT_LPS>{data($row/ns5:Column[upper-case(@name)="MONTOLPSPLANILLA"])}</ns2:PAYROLL_AMOUNT_LPS>
                    <ns2:LOAD_DATE>{data($row/ns5:Column[upper-case(@name)="FECHACARGA"])}</ns2:LOAD_DATE>
                </ns2:APPLICANT>               
                }
            </ns2:APPLICANT_RESPONSE>
            
            <ns2:LIABILITIES_RESPONSE>
            <ns2:RESPONSE_CODE>{data($resultGroup/LIABILITIES_RESPONSE//ns1:CODIGO_RESPUESTA)}</ns2:RESPONSE_CODE>
            <ns2:RESPONSE_MESSAGE>{data($resultGroup/LIABILITIES_RESPONSE//ns1:MENSAJE_RESPUESTA)}</ns2:RESPONSE_MESSAGE>
            {for $row in $resultGroup/LIABILITIES_RESPONSE//ns1:Row
            return
                <ns2:LIABILITIES>
                    <ns2:ACCOUNT_NUMBER>{data($row/ns1:Column[upper-case(@name)="NUMEROCUENTA"])}</ns2:ACCOUNT_NUMBER>
                    <ns2:CATEGORY>{data($row/ns1:Column[upper-case(@name)="CATEGORIA"])}</ns2:CATEGORY>
                    <ns2:CURRENCY>{data($row/ns1:Column[upper-case(@name)="MONEDA"])}</ns2:CURRENCY>
                    <ns2:OPEN_DATE>{data($row/ns1:Column[upper-case(@name)="FECHAAPERTURA"])}</ns2:OPEN_DATE>
                    <ns2:CANCELLATION_DATE>{data($row/ns1:Column[upper-case(@name)="FECHACANCELACION"])}</ns2:CANCELLATION_DATE>
                    <ns2:CURRENT_BALANCE>{data($row/ns1:Column[upper-case(@name)="SALDOACTUAL"])}</ns2:CURRENT_BALANCE>
                    <ns2:END_OF_MONTH_BALANCE>{data($row/ns1:Column[upper-case(@name)="SALDOFINMES"])}</ns2:END_OF_MONTH_BALANCE>
                    <ns2:AVERAGE_BALANCE>{data($row/ns1:Column[upper-case(@name)="SALDOPROMEDIO"])}</ns2:AVERAGE_BALANCE>
                    <ns2:OPERATION_TYPE>{data($row/ns1:Column[upper-case(@name)="TIPOOPERACION"])}</ns2:OPERATION_TYPE>
                    <ns2:LOAD_DATE>{data($row/ns1:Column[upper-case(@name)="FECHACARGA"])}</ns2:LOAD_DATE>
                </ns2:LIABILITIES>
            }
            </ns2:LIABILITIES_RESPONSE>
                     
            <ns2:CARDS_RESPONSE>
            <ns2:RESPONSE_CODE>{data($resultGroup/CARDS_RESPONSE//ns0:CODIGO_RESPUESTA)}</ns2:RESPONSE_CODE>
            <ns2:RESPONSE_MESSAGE>{data($resultGroup/CARDS_RESPONSE//ns0:MENSAJE_RESPUESTA)}</ns2:RESPONSE_MESSAGE>
            {for $row in $resultGroup/CARDS_RESPONSE//ns0:Row
            return
                <ns2:CARDS>
                    <ns2:ACCOUNT_NUMBER>{data($row/ns0:Column[upper-case(@name)="NUMEROCUENTA"])}</ns2:ACCOUNT_NUMBER>
                    <ns2:BEHAVIOR_SCORE>{data($row/ns0:Column[upper-case(@name)="BEHAVIORSCORE"])}</ns2:BEHAVIOR_SCORE>
                    <ns2:RATING_SCORE>{data($row/ns0:Column[upper-case(@name)="CALIFICACIONSCORE"])}</ns2:RATING_SCORE>
                    <ns2:CUSTOMER_RATING_SCORE>{data($row/ns0:Column[upper-case(@name)="CALIFICACIONSCORECLIENTE"])}</ns2:CUSTOMER_RATING_SCORE>
                    <ns2:STATUS>{data($row/ns0:Column[upper-case(@name)="ESTADO"])}</ns2:STATUS>
                    <ns2:AFFINITY_GROUP>{data($row/ns0:Column[upper-case(@name)="GRUPOAFINIDAD"])}</ns2:AFFINITY_GROUP>
                    <ns2:PRODUCT>{data($row/ns0:Column[upper-case(@name)="PRODUCTO"])}</ns2:PRODUCT>
                    <ns2:OPEN_DATE>{data($row/ns0:Column[upper-case(@name)="FECHAAPERTURA"])}</ns2:OPEN_DATE>
                    <ns2:CANCELLATION_DATE>{data($row/ns0:Column[upper-case(@name)="FECHACANCELACION"])}</ns2:CANCELLATION_DATE>
                    <ns2:LAST_EXTRA_DATE>{data($row/ns0:Column[upper-case(@name)="FECHAULTIMOEXTRA"])}</ns2:LAST_EXTRA_DATE>
                    <ns2:CURRENT_DELINQUENCY>{data($row/ns0:Column[upper-case(@name)="MORAACTUAL"])}</ns2:CURRENT_DELINQUENCY>
                    <ns2:CURRENT_LIMIT>{data($row/ns0:Column[upper-case(@name)="LIMITEACTUAL"])}</ns2:CURRENT_LIMIT>
                    <ns2:CURRENT_BALANCE>{data($row/ns0:Column[upper-case(@name)="SALDOACTUAL"])}</ns2:CURRENT_BALANCE>
                    <ns2:CUT_BALANCE>{data($row/ns0:Column[upper-case(@name)="SALDOCORTE"])}</ns2:CUT_BALANCE>
                    <ns2:EXTRA_BALANCE>{data($row/ns0:Column[upper-case(@name)="SALDOEXTRA"])}</ns2:EXTRA_BALANCE>
                    <ns2:INTRA_BALANCE>{data($row/ns0:Column[upper-case(@name)="SALDOINTRA"])}</ns2:INTRA_BALANCE>
                    <ns2:EXTRA_INSTALLMENTS_ACTIVE>{data($row/ns0:Column[upper-case(@name)="CUOTASEXTRAVIGENTES"])}</ns2:EXTRA_INSTALLMENTS_ACTIVE>
                    <ns2:CASH_DISCOUNT_DATE>{data($row/ns0:Column[upper-case(@name)="FECHADESCUENTOCONTADO"])}</ns2:CASH_DISCOUNT_DATE>
                    <ns2:HISTORICAL_DELINQUENCY_LOC>{data($row/ns0:Column[upper-case(@name)="MOROSIDADHISTORICALOC"])}</ns2:HISTORICAL_DELINQUENCY_LOC>
                    <ns2:HISTORICAL_DELINQUENCY_USD>{data($row/ns0:Column[upper-case(@name)="MOROSIDADHISTORICAUSD"])}</ns2:HISTORICAL_DELINQUENCY_USD>
                    <ns2:WRITE_OFF_FLAG>{data($row/ns0:Column[upper-case(@name)="FLAGCASTIGO"])}</ns2:WRITE_OFF_FLAG>
                    <ns2:BLOCK_DATE_1>{data($row/ns0:Column[upper-case(@name)="FECBLOQUE1"])}</ns2:BLOCK_DATE_1>
                    <ns2:BLOCK_DATE_2>{data($row/ns0:Column[upper-case(@name)="FECBLOQUE2"])}</ns2:BLOCK_DATE_2>
                    <ns2:BLOCK_CODE_1>{data($row/ns0:Column[upper-case(@name)="CODBLOQUE1"])}</ns2:BLOCK_CODE_1>
                    <ns2:BLOCK_CODE_2>{data($row/ns0:Column[upper-case(@name)="CODBLOQUE2"])}</ns2:BLOCK_CODE_2>
                    <ns2:EXTRA_APPROVAL_DATE>{data($row/ns0:Column[upper-case(@name)="FECHAAPROBACIONEXTRA"])}</ns2:EXTRA_APPROVAL_DATE>
                    <ns2:INTRA_APPROVAL_DATE>{data($row/ns0:Column[upper-case(@name)="FECHAAPROBACIONINTRA"])}</ns2:INTRA_APPROVAL_DATE>
                    <ns2:PIL_APPROVAL_DATE>{data($row/ns0:Column[upper-case(@name)="FECHAAPROBACIONPIL"])}</ns2:PIL_APPROVAL_DATE>
                    <ns2:PREVIOUS_LIMIT>{data($row/ns0:Column[upper-case(@name)="LIMITEPREVIO"])}</ns2:PREVIOUS_LIMIT>
                    <ns2:AUTHORIZATION_BALANCE>{data($row/ns0:Column[upper-case(@name)="SALDOAUTORIZACION"])}</ns2:AUTHORIZATION_BALANCE>
                </ns2:CARDS>
            }
            </ns2:CARDS_RESPONSE>
            
            <ns2:LOANS_RESPONSE>
            <ns2:RESPONSE_CODE>{data($resultGroup/LOANS_RESPONSE//ns4:CODIGO_RESPUESTA)}</ns2:RESPONSE_CODE>
            <ns2:RESPONSE_MESSAGE>{data($resultGroup/LOANS_RESPONSE//ns4:MENSAJE_RESPUESTA)}</ns2:RESPONSE_MESSAGE>
            {for $row in $resultGroup/LOANS_RESPONSE//ns4:Row
            return
                <ns2:LOANS>
                    <ns2:CONTRACT_NUMBER>{data($row/ns4:Column[upper-case(@name)="NUMEROCONTRATO"])}</ns2:CONTRACT_NUMBER>
                    <ns2:LOAN_NUMBER>{data($row/ns4:Column[upper-case(@name)="NUMEROPRESTAMO"])}</ns2:LOAN_NUMBER>
                    <ns2:AGENCY_CODE>{data($row/ns4:Column[upper-case(@name)="CODIGOAGENCIA"])}</ns2:AGENCY_CODE>
                    <ns2:SUBAPPLICATION_CODE>{data($row/ns4:Column[upper-case(@name)="CODIGOSUBAPLICACION"])}</ns2:SUBAPPLICATION_CODE>
                    <ns2:OPEN_DATE>{data($row/ns4:Column[upper-case(@name)="FECHAAPERTURA"])}</ns2:OPEN_DATE>
                    <ns2:CANCELLATION_DATE>{data($row/ns4:Column[upper-case(@name)="FECHACANCELACION"])}</ns2:CANCELLATION_DATE>
                    <ns2:INITIAL_AMOUNT>{data($row/ns4:Column[upper-case(@name)="MONTOINICIAL"])}</ns2:INITIAL_AMOUNT>
                    <ns2:CURRENT_BALANCE>{data($row/ns4:Column[upper-case(@name)="SALDOACTUAL"])}</ns2:CURRENT_BALANCE>
                    <ns2:INSTALLMENT_VALUE>{data($row/ns4:Column[upper-case(@name)="VALORCUOTA"])}</ns2:INSTALLMENT_VALUE>
                    <ns2:RATE>{data($row/ns4:Column[upper-case(@name)="TASA"])}</ns2:RATE>
                    <ns2:TERM>{data($row/ns4:Column[upper-case(@name)="PLAZO"])}</ns2:TERM>
                    <ns2:NUMBER_OF_INSTALLMENTS>{data($row/ns4:Column[upper-case(@name)="NUMEROCUOTAS"])}</ns2:NUMBER_OF_INSTALLMENTS>
                    <ns2:FIRST_PRINCIPAL_PAYMENT_DATE>{data($row/ns4:Column[upper-case(@name)="FECHAPRIMERPAGOCAPITAL"])}</ns2:FIRST_PRINCIPAL_PAYMENT_DATE>
                    <ns2:LAST_PAYMENT_DATE>{data($row/ns4:Column[upper-case(@name)="FECHAULTIMOPAGO"])}</ns2:LAST_PAYMENT_DATE>
                    <ns2:INSTALLMENTS_PAID>{data($row/ns4:Column[upper-case(@name)="CANTIDADCUOTASPAGADAS"])}</ns2:INSTALLMENTS_PAID>
                    <ns2:PAYMENT_FREQUENCY>{data($row/ns4:Column[upper-case(@name)="FRECUENCIACAPITAL"])}</ns2:PAYMENT_FREQUENCY>
                    <ns2:DESTINATION_CODE>{data($row/ns4:Column[upper-case(@name)="CODIGODESTINO"])}</ns2:DESTINATION_CODE>
                    <ns2:MONTHLY_PREMIUM>{data($row/ns4:Column[upper-case(@name)="PRIMAMENSUAL"])}</ns2:MONTHLY_PREMIUM>
                    <ns2:CHARGES>{data($row/ns4:Column[upper-case(@name)="CARGOS"])}</ns2:CHARGES>
                    <ns2:GUARANTEE_TYPE_CODE>{data($row/ns4:Column[upper-case(@name)="CODIGOTIPOGARANTIA"])}</ns2:GUARANTEE_TYPE_CODE>
                    <ns2:LOAN_TYPE_CODE>{data($row/ns4:Column[upper-case(@name)="CODIGOTIPOPRESTAMO"])}</ns2:LOAN_TYPE_CODE>
                    <ns2:INTEREST>{data($row/ns4:Column[upper-case(@name)="INTERES"])}</ns2:INTEREST>
                    <ns2:CURRENT_PAST_DUE>{data($row/ns4:Column[upper-case(@name)="MORAACTUAL"])}</ns2:CURRENT_PAST_DUE>
                    <ns2:OTHER_CHARGES>{data($row/ns4:Column[upper-case(@name)="OTROSCARGOS"])}</ns2:OTHER_CHARGES>
                    <ns2:INSURANCES>{data($row/ns4:Column[upper-case(@name)="SEGUROS"])}</ns2:INSURANCES>
                    <ns2:DEBTOR_TYPE>{data($row/ns4:Column[upper-case(@name)="TIPODEUDOR"])}</ns2:DEBTOR_TYPE>
                </ns2:LOANS>
            }
            </ns2:LOANS_RESPONSE>
            
            <ns2:TRX_LIABILITIES_RESPONSE>
            <ns2:RESPONSE_CODE>{data($resultGroup/LIABILITIES_TRX_RESPONSE//ns3:CODIGO_RESPUESTA)}</ns2:RESPONSE_CODE>
            <ns2:RESPONSE_MESSAGE>{data($resultGroup/LIABILITIES_TRX_RESPONSE//ns3:MENSAJE_RESPUESTA)}</ns2:RESPONSE_MESSAGE>
            {for $row in $resultGroup/LIABILITIES_TRX_RESPONSE//ns3:Row
            return
                <ns2:TRX_LIABILITIES>
                    <ns2:ACCOUNT>{data($row/ns3:Column[upper-case(@name)="CUENTA"])}</ns2:ACCOUNT>
                    <ns2:END_BALANCE>{data($row/ns3:Column[upper-case(@name)="SALDOFIN"])}</ns2:END_BALANCE>
                    <ns2:MAX_BALANCE>{data($row/ns3:Column[upper-case(@name)="SALDOMAX"])}</ns2:MAX_BALANCE>
                    <ns2:MIN_BALANCE>{data($row/ns3:Column[upper-case(@name)="SALDOMIN"])}</ns2:MIN_BALANCE>
                    <ns2:AVERAGE_BALANCE>{data($row/ns3:Column[upper-case(@name)="SALDOPROMEDIO"])}</ns2:AVERAGE_BALANCE>
                    <ns2:LAST_CREDIT_DATE>{data($row/ns3:Column[upper-case(@name)="FECHAULTIMOCREDITO"])}</ns2:LAST_CREDIT_DATE>
                    <ns2:NUMBER_OF_CREDITS>{data($row/ns3:Column[upper-case(@name)="NUMEROCREDITOS"])}</ns2:NUMBER_OF_CREDITS>
                    <ns2:CREDITS_AMOUNT>{data($row/ns3:Column[upper-case(@name)="MONTOCREDITOS"])}</ns2:CREDITS_AMOUNT>
                    <ns2:LAST_DEBIT_DATE>{data($row/ns3:Column[upper-case(@name)="FECHAULTIMODEBIT"])}</ns2:LAST_DEBIT_DATE>
                    <ns2:NUMBER_OF_DEBITS>{data($row/ns3:Column[upper-case(@name)="NUMERODEBITOS"])}</ns2:NUMBER_OF_DEBITS>
                    <ns2:DEBITS_AMOUNT>{data($row/ns3:Column[upper-case(@name)="MONTODEBITOS"])}</ns2:DEBITS_AMOUNT>
                    <ns2:NUMBER_INTERESTS_DEBITS>{data($row/ns3:Column[upper-case(@name)="NUMEROINTERESESDEBITOS"])}</ns2:NUMBER_INTERESTS_DEBITS>
                    <ns2:AMOUNT_INTERESTS_DEBITS>{data($row/ns3:Column[upper-case(@name)="MONTOINTERESESDEBITOS"])}</ns2:AMOUNT_INTERESTS_DEBITS>
                    <ns2:NUMBER_INTERESTS_CREDITS>{data($row/ns3:Column[upper-case(@name)="NUMEROINTERESESCREDITOS"])}</ns2:NUMBER_INTERESTS_CREDITS>
                    <ns2:AMOUNT_INTERESTS_CREDITS>{data($row/ns3:Column[upper-case(@name)="MONTOINTERESESCREDITOS"])}</ns2:AMOUNT_INTERESTS_CREDITS>
                    <ns2:FLAG_ACCOUNT_FACILITIES>{data($row/ns3:Column[upper-case(@name)="FLAGFACILIDADESCUENTA"])}</ns2:FLAG_ACCOUNT_FACILITIES>
                    <ns2:FLAG_LEGAL_REPRESENTATIVE>{data($row/ns3:Column[upper-case(@name)="FLAGREPRESENTANTELEGAL"])}</ns2:FLAG_LEGAL_REPRESENTATIVE>
                    <ns2:FLAG_PAYROLL_ACCOUNT>{data($row/ns3:Column[upper-case(@name)="FLAGCUENTAPLANILLA"])}</ns2:FLAG_PAYROLL_ACCOUNT>
                    <ns2:PAYROLL_CREDITED_AMOUNT>{data($row/ns3:Column[upper-case(@name)="MONTOACREDITADOPLANILLA"])}</ns2:PAYROLL_CREDITED_AMOUNT>
                    <ns2:FLAG_JOINT_ACCOUNT>{data($row/ns3:Column[upper-case(@name)="FLAGCUENTAMANCOMUNADA"])}</ns2:FLAG_JOINT_ACCOUNT>
                    <ns2:FLAG_ACCOUNT_BLOCK>{data($row/ns3:Column[upper-case(@name)="FLAGBLOQUEOCUENTA"])}</ns2:FLAG_ACCOUNT_BLOCK>
                    <ns2:END_OF_PERIOD_DATE>{data($row/ns3:Column[upper-case(@name)="FECHAFINDEPERIODO"])}</ns2:END_OF_PERIOD_DATE>
                    <ns2:LOAD_DATE>{data($row/ns3:Column[upper-case(@name)="FECHACARGA"])}</ns2:LOAD_DATE>
                    <ns2:USER>{data($row/ns3:Column[upper-case(@name)="USUARIO"])}</ns2:USER>
                </ns2:TRX_LIABILITIES>
            }
            </ns2:TRX_LIABILITIES_RESPONSE>
        </ns2:sjConsultaConsolidadaRiesgoClienteGTResponse>
};

declare variable $resultGroup as element(*) external;
xf:sjConsultaConsolidadaRiesgoClienteGTOut($resultGroup)