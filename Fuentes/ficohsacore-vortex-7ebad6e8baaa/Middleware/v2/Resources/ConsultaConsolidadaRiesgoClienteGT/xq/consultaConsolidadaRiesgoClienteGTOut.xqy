xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaConsolidadaRiesgoCliente" element="ns2:consultaConsolidadaRiesgoCliente" location="../../ConsultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoClienteTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$ConsultaBurosResponse" element="ns1:ConsultaBurosResponse" location="../../../BusinessServices/DataWarehouse/consultaBurosPrecreditoGT/wsdl/consultaBurosPrecreditoGT.wsdl" ::)
(:: pragma bea:global-element-parameter parameter="$sjConsultaConsolidadaRiesgoClienteGTResponse" element="ns0:sjConsultaConsolidadaRiesgoClienteGTResponse" location="../../../BusinessServices/SJS/consultaConsolidadaRiesgoClienteGT/xsd/sjConsultaConsolidadaRiesgoClienteGTTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:consultaConsolidadaRiesgoClienteResponse" location="../../ConsultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoClienteTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes";
declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaConsolidadaRiesgoClienteGTTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaConsolidadaRiesgoClienteGT/xq/consultaConsolidadaRiesgoClienteGTOut/";

declare function xf:consultaConsolidadaRiesgoClienteGTOut($consultaConsolidadaRiesgoCliente as element(ns2:consultaConsolidadaRiesgoCliente),
    $ConsultaBurosResponse as element(ns1:ConsultaBurosResponse),
    $sjConsultaConsolidadaRiesgoClienteGTResponse as element(ns0:sjConsultaConsolidadaRiesgoClienteGTResponse))
    as element(ns2:consultaConsolidadaRiesgoClienteResponse) {
        <ns2:consultaConsolidadaRiesgoClienteResponse>
            <LOAN_MAINTENANCE>
                <CUSTOMER_INFO>
                    <ID>{ data($consultaConsolidadaRiesgoCliente/CUSTOMER_LEGAL_ID) }</ID>
                    <FISCAL_ID>{ data($consultaConsolidadaRiesgoCliente/FISCAL_ID) }</FISCAL_ID>
                    <FIRST_NAME>{ data($consultaConsolidadaRiesgoCliente/FIRST_NAME) }</FIRST_NAME>
                    <LAST_NAME>{ data($consultaConsolidadaRiesgoCliente/LAST_NAME) }</LAST_NAME>
                    <DATE_OF_BIRTH>
                        {
                            if ((exists($consultaConsolidadaRiesgoCliente/BIRTH_DATE) and string($consultaConsolidadaRiesgoCliente/BIRTH_DATE) != '')) then
                                (data($consultaConsolidadaRiesgoCliente/BIRTH_DATE))
                            else 
                                data($sjConsultaConsolidadaRiesgoClienteGTResponse/ns0:APPLICANT_RESPONSE/ns0:APPLICANT[1]/ns0:BIRTH_DATE)
                        }
					</DATE_OF_BIRTH>
                    <AGE>{ data($sjConsultaConsolidadaRiesgoClienteGTResponse/ns0:APPLICANT_RESPONSE/ns0:APPLICANT[1]/ns0:AGE) }</AGE>
                    {
                        for $CUSTOMER_TYPE in $sjConsultaConsolidadaRiesgoClienteGTResponse/ns0:APPLICANT_RESPONSE/ns0:APPLICANT[1]/ns0:CUSTOMER_TYPE
                        return
                            <TYPE>{ data($CUSTOMER_TYPE) }</TYPE>
                    }
                    <SALARY>{ data($sjConsultaConsolidadaRiesgoClienteGTResponse/ns0:APPLICANT_RESPONSE/ns0:APPLICANT[1]/ns0:CUSTOMER_SALARY) }</SALARY>
                    {
                        for $FLAG_BLAZE in $sjConsultaConsolidadaRiesgoClienteGTResponse/ns0:APPLICANT_RESPONSE/ns0:APPLICANT[1]/ns0:FLAG_BLAZE
                        return
                            <FLAG_BLAZE>{ data($FLAG_BLAZE) }</FLAG_BLAZE>
                    }
                    <ADDRESSES_INFO>
                        {
                            for $DIRECCION in $ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:TRANSUNION/ns1:INFORMACION_CLIENTE/ns1:DIRECCIONES/ns1:DIRECCION
                            return
                                <ADDRESS_ITEM>
                                    <ADDRESS>{ data($DIRECCION/ns1:DESC) }</ADDRESS>
                                </ADDRESS_ITEM>
                        }
                    </ADDRESSES_INFO>
                    <PHONES_INFO>
                        {
                            for $TELEFONO in $ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:TRANSUNION/ns1:INFORMACION_CLIENTE/ns1:TELEFONOS/ns1:TELEFONO
                            return
                                <PHONE_ITEM>
                                    <PHONE>{ data($TELEFONO/ns1:TELEFONO) }</PHONE>
                                </PHONE_ITEM>
                        }
                    </PHONES_INFO>
                    <EXTERNAL_SCORE>{ data($ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:TRANSUNION/ns1:MODELOS_ANALISIS/ns1:MODELO/ns1:RESULTADO) }</EXTERNAL_SCORE>
                    <LIABILITIES>
                        <CREDIT_CARDS_INFO>
                            {
                                for $CARD in $sjConsultaConsolidadaRiesgoClienteGTResponse/ns0:CARDS_RESPONSE/ns0:CARDS
                                return
                                    <CREDIT_CARD>
                                        <ACCOUNT>{ data($CARD/ns0:ACCOUNT_NUMBER) }</ACCOUNT>
                                        <BEHAVIOR_SCORE>{ data($CARD/ns0:BEHAVIOR_SCORE) }</BEHAVIOR_SCORE>
                                        <QUALIFICATION_SCORE>{ data($CARD/ns0:RATING_SCORE) }</QUALIFICATION_SCORE>
                                        <QUALIFICATION_CUSTOMER_SCORE>{ data($CARD/ns0:CUSTOMER_RATING_SCORE) }</QUALIFICATION_CUSTOMER_SCORE>
                                        <STATUS>{ data($CARD/ns0:STATUS) }</STATUS>
                                        <AFFINITY_GROUP>{ data($CARD/ns0:AFFINITY_GROUP) }</AFFINITY_GROUP>
                                        <PRODUCT>{ data($CARD/ns0:PRODUCT) }</PRODUCT>
                                        <OPENING_DATE>{ data($CARD/ns0:OPEN_DATE) }</OPENING_DATE>
                                        <CANCELATION_DATE>{ data($CARD/ns0:CANCELLATION_DATE) }</CANCELATION_DATE>
                                        <LAST_EXTRA_DATE>{ data($CARD/ns0:LAST_EXTRA_DATE) }</LAST_EXTRA_DATE>
                                        <CURRENT_DUE>{ data($CARD/ns0:CURRENT_DELINQUENCY) }</CURRENT_DUE>
                                        <CURRENT_LIMIT>{ data($CARD/ns0:CURRENT_LIMIT) }</CURRENT_LIMIT>
                                        <CURRENT_BALANCE>{ data($CARD/ns0:CURRENT_BALANCE) }</CURRENT_BALANCE>
                                        <CLOSING_BALANCE>{ data($CARD/ns0:CUT_BALANCE) }</CLOSING_BALANCE>
                                        <EXTRA_BALANCE>{ data($CARD/ns0:EXTRA_BALANCE) }</EXTRA_BALANCE>
                                        <INTRA_BALANCE>{ data($CARD/ns0:INTRA_BALANCE) }</INTRA_BALANCE>
                                        <ACTIVE_EXTRA_INSTALLMENTS>{ data($CARD/ns0:EXTRA_INSTALLMENTS_ACTIVE) }</ACTIVE_EXTRA_INSTALLMENTS>
                                        <CASH_DISCOUNT_DATE>{ data($CARD/ns0:CASH_DISCOUNT_DATE) }</CASH_DISCOUNT_DATE>
                                        <LOCKCODE1>{ data($CARD/ns0:BLOCK_CODE_1) }</LOCKCODE1>
                                        <LOCKCODE2>{ data($CARD/ns0:BLOCK_CODE_2) }</LOCKCODE2>
                                        <LOCK_DATE1>{ data($CARD/ns0:BLOCK_DATE_1) }</LOCK_DATE1>
                                        <LOCK_DATE2>{ data($CARD/ns0:BLOCK_DATE_2) }</LOCK_DATE2>
                                        <EXTRA_APPROVAL_DATE>{ data($CARD/ns0:EXTRA_APPROVAL_DATE) }</EXTRA_APPROVAL_DATE>
                                        <INTRA_APPROVAL_DATE>{ data($CARD/ns0:INTRA_APPROVAL_DATE) }</INTRA_APPROVAL_DATE>
                                        <PIL_APPROVAL_DATE>{ data($CARD/ns0:PIL_APPROVAL_DATE) }</PIL_APPROVAL_DATE>
                                        <PRIOR_LIMIT>{ data($CARD/ns0:PREVIOUS_LIMIT) }</PRIOR_LIMIT>
                                        <AUTH_BALANCE>{ data($CARD/ns0:AUTHORIZATION_BALANCE) }</AUTH_BALANCE>
                                        <HISTORICAL_ARREA_LOC>{ data($CARD/ns0:HISTORICAL_DELINQUENCY_LOC) }</HISTORICAL_ARREA_LOC>
                                        <HISTORICAL_ARREA_USD>{ data($CARD/ns0:HISTORICAL_DELINQUENCY_USD) }</HISTORICAL_ARREA_USD>
                                        <CHARGE_OFF_FLAG>{ data($CARD/ns0:WRITE_OFF_FLAG) }</CHARGE_OFF_FLAG>
                                    </CREDIT_CARD>
                            }
                        </CREDIT_CARDS_INFO>
                        <LOANS_INFO>
                            {
                                for $LOAN in $sjConsultaConsolidadaRiesgoClienteGTResponse/ns0:LOANS_RESPONSE/ns0:LOANS
                                return
                                    <LOAN>
                                        <AGENCY_CODE>{ data($LOAN/ns0:AGENCY_CODE) }</AGENCY_CODE>
                                        <SUB_APPLICATION>{ data($LOAN/ns0:SUBAPPLICATION_CODE) }</SUB_APPLICATION>
                                        <OPENING_DATE>{ data($LOAN/ns0:OPEN_DATE) }</OPENING_DATE>
                                        <CANCELATION_DATE>{ data($LOAN/ns0:CANCELLATION_DATE) }</CANCELATION_DATE>
                                        <INITIAL_AMOUNT>{ data($LOAN/ns0:INITIAL_AMOUNT) }</INITIAL_AMOUNT>
                                        <CURRENT_BALANCE>{ data($LOAN/ns0:CURRENT_BALANCE) }</CURRENT_BALANCE>
                                        <PAYMENT_AMOUNT>{ data($LOAN/ns0:INSTALLMENT_VALUE) }</PAYMENT_AMOUNT>
                                        <RATE>{ data($LOAN/ns0:RATE) }</RATE>
                                        <TERM>{ data($LOAN/ns0:TERM) }</TERM>
                                        <PAYMENT_NUMBER>{ data($LOAN/ns0:NUMBER_OF_INSTALLMENTS) }</PAYMENT_NUMBER>
                                        <FIRST_CAPITAL_PAYMENT_DATE>{ data($LOAN/ns0:FIRST_PRINCIPAL_PAYMENT_DATE) }</FIRST_CAPITAL_PAYMENT_DATE>
                                        <LAST_PAYMENT_DATE>{ data($LOAN/ns0:LAST_PAYMENT_DATE) }</LAST_PAYMENT_DATE>
                                        <PAID_PAYMENTS>{ data($LOAN/ns0:INSTALLMENTS_PAID) }</PAID_PAYMENTS>
                                        <CAPITAL_FREQUENCY>{ data($LOAN/ns0:PAYMENT_FREQUENCY) }</CAPITAL_FREQUENCY>
                                        <DESTINATION_CODE>{ data($LOAN/ns0:DESTINATION_CODE) }</DESTINATION_CODE>
                                        <MONTHLY_PRIME>{ data($LOAN/ns0:MONTHLY_PREMIUM) }</MONTHLY_PRIME>
                                        <CHARGES>{ data($LOAN/ns0:CHARGES) }</CHARGES>
                                        <INTEREST>{ data($LOAN/ns0:INTEREST) }</INTEREST>
                                        <INSURANCE>{ data($LOAN/ns0:INSURANCES) }</INSURANCE>
                                        <OTHER_CHARGES>{ data($LOAN/ns0:OTHER_CHARGES) }</OTHER_CHARGES>
                                        <CURRENT_DUE>{ data($LOAN/ns0:CURRENT_PAST_DUE) }</CURRENT_DUE>
                                        <DEBTOR_TYPE>{ data($LOAN/ns0:DEBTOR_TYPE) }</DEBTOR_TYPE>
                                        <CODE_TYPE>{ data($LOAN/ns0:LOAN_TYPE_CODE) }</CODE_TYPE>
                                        <GUARANTEE_TYPE>{ data($LOAN/ns0:GUARANTEE_TYPE_CODE) }</GUARANTEE_TYPE>
                                    </LOAN>
                            }
                        </LOANS_INFO>
                    </LIABILITIES>
                    <REFERENCIA_SIB>{ data($ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:SIRC/ns1:REFERENCIA_SIB) }</REFERENCIA_SIB>
                </CUSTOMER_INFO>
            </LOAN_MAINTENANCE>
            <LOAN_ORIGINATIONS>
                <REFERENCES_DETAILS>
                    <QUERIES>
                        {
                            for $CONSULTA in $ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:TRANSUNION/ns1:LISTA_CONSULTAS/ns1:CONSULTA
                            return
                                <QUERY_ITEM>
                                    <DATE>{ data($CONSULTA/ns1:FECHA_CONSULTA) }</DATE>
                                    <ENTITY>{ data($CONSULTA/ns1:ENTIDAD_CONSULTANTE) }</ENTITY>
                                    <TYPE>{ data($CONSULTA/ns1:TIPO_CONSULTA) }</TYPE>
                                    <MOTIVE>{ data($CONSULTA/ns1:MOTIVO) }</MOTIVE>
                                </QUERY_ITEM>
                        }
                    </QUERIES>
                    <REFERENCE_BUREAU_TUCA>
                        {
                            for $OBLIGACION in $ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:TRANSUNION/ns1:COMPORTAMIENTO_OBLIGACIONES/ns1:OBLIGACION
                            return
                                <REFERENCE>
                                    <REFERENCE_NUMBER>{ data($OBLIGACION/ns1:NUMERO) }</REFERENCE_NUMBER>
                                    <OBLIGATION_TYPE>{ data($OBLIGACION/@TIPO) }</OBLIGATION_TYPE>
                                    <OBLIGATION_SECTOR>{ data($OBLIGACION/@SECTOR) }</OBLIGATION_SECTOR>
                                    <CREDITOR>{ data($OBLIGACION/ns1:ENTIDAD_INFORMANTE) }</CREDITOR>
                                    <CREDIT_TYPE>{ data($OBLIGACION/ns1:TIPO) }</CREDIT_TYPE>
                                    <GUARANTEE_TYPE>{ data($OBLIGACION/ns1:GARANTIA) }</GUARANTEE_TYPE>
                                    <OPENING_DATE>{ data($OBLIGACION/ns1:FECHA_APERTURA) }</OPENING_DATE>
                                    <CANCELATION_DATE>{ data($OBLIGACION/ns1:FECHA_VENCIMIENTO) }</CANCELATION_DATE>
                                    <INFORMATION_DATE>{ data($OBLIGACION/ns1:FECHA_ACTUALIZACION) }</INFORMATION_DATE>
                                    <PAYMENT_METHOD>{ data($OBLIGACION/ns1:PERIODO_PAGO) }</PAYMENT_METHOD>
                                    <CATEGORY>{ data($OBLIGACION/ns1:COMPORTAMIENTO_PAGO/ns1:CALIFICACION) }</CATEGORY>
                                    <CURRENCY>{ data($OBLIGACION/ns1:COMPORTAMIENTO_PAGO/ns1:MONEDA) }</CURRENCY>
                                    <CREDIT_STATUS>{ data($OBLIGACION/ns1:COMPORTAMIENTO_PAGO/ns1:ESTADO_CREDITO) }</CREDIT_STATUS>
                                    <STATUS>{ data($OBLIGACION/ns1:COMPORTAMIENTO_PAGO/ns1:ESTADO) }</STATUS>
                                    <LIMIT>{ data($OBLIGACION/ns1:COMPORTAMIENTO_PAGO/ns1:LIMITE) }</LIMIT>
                                    <BALANCE>{ data($OBLIGACION/ns1:COMPORTAMIENTO_PAGO/ns1:SALDO_ACTUAL) }</BALANCE>
                                    <ARREAR_BALANCE>{ data($OBLIGACION/ns1:COMPORTAMIENTO_PAGO/ns1:SALDO_MORA) }</ARREAR_BALANCE>
                                    <INSTALLMENT>{ data($OBLIGACION/ns1:COMPORTAMIENTO_PAGO/ns1:CUOTA) }</INSTALLMENT>
                                    <LAST_MOVEMENT_MONTH>{ data($OBLIGACION/ns1:COMPORTAMIENTO_PAGO/ns1:VECTOR_HISTORICO/ns1:ITEM[1]/@MES) }</LAST_MOVEMENT_MONTH>
                                    <LAST_MOVEMENT_YEAR>{ data($OBLIGACION/ns1:COMPORTAMIENTO_PAGO/ns1:VECTOR_HISTORICO/ns1:ITEM[1]/@ANIO) }</LAST_MOVEMENT_YEAR>
                                    <HISTORICAL_ARREAR>{
									    string-join(
									        for $item in $OBLIGACION/ns1:COMPORTAMIENTO_PAGO/ns1:VECTOR_HISTORICO/ns1:ITEM
									        return data($item),
									        "|"
									    )
									}</HISTORICAL_ARREAR>
                                </REFERENCE>
                        }
                    </REFERENCE_BUREAU_TUCA>
                    <REFERENCE_BUREAU_SIRC>
                        {
                            for $DEUDAS_VIGENTES in $ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:SIRC/ns1:DIRECTOS/ns1:DEUDAS_VIGENTES
                            return
                                <REFERENCE>
                                    <DEBTOR_TYPE>{ data($DEUDAS_VIGENTES/ns1:NOM_VINCULO) }</DEBTOR_TYPE>
                                    <CREDITOR>{ data($DEUDAS_VIGENTES/ns1:ENTIDAD) }</CREDITOR>
                                    <ASSET_TYPE>{ data($DEUDAS_VIGENTES/ns1:DESC_TIPO_ACTIVO) }</ASSET_TYPE>
                                    <WARRANTY_TYPE>{ data($DEUDAS_VIGENTES/ns1:DESC_TIPO_GARANTIA) }</WARRANTY_TYPE>
                                    <CURRENCY>{ data($DEUDAS_VIGENTES/ns1:MONEDA) }</CURRENCY>
                                    <AMOUNT>{ data($DEUDAS_VIGENTES/ns1:CAPITAL_ORIGINAL) }</AMOUNT>
                                    <BALANCE>{ data($DEUDAS_VIGENTES/ns1:SALDO) }</BALANCE>
                                    <DUE_BALANCE>{ data($DEUDAS_VIGENTES/ns1:VENCIDO) }</DUE_BALANCE>
                                    <OPENING_DATE>{ data($DEUDAS_VIGENTES/ns1:FECHA_ACTIVO) }</OPENING_DATE>
                                    <CONSESSION_DATE>{ data($DEUDAS_VIGENTES/ns1:FECHA_CONSESION) }</CONSESSION_DATE>
                                    <EXPIRATION_DATE>{ data($DEUDAS_VIGENTES/ns1:FECHA_VENCIMIENTO) }</EXPIRATION_DATE>
                                    <CANCELATION_DATE>{ data($DEUDAS_VIGENTES/ns1:FECHA_CANCELACION) }</CANCELATION_DATE>
                                    <HISTORICAL_ARREAR>{ data($DEUDAS_VIGENTES/ns1:COMPORTAMIENTO) }</HISTORICAL_ARREAR>
                                    <CATEGORY>{ data($DEUDAS_VIGENTES/ns1:CATEGORIA) }</CATEGORY>
                                    <REFERENCE_TYPE>DirectosVigentes</REFERENCE_TYPE>
                                    <STATUS>VIGENTE</STATUS>
                                </REFERENCE>
                        }	
                        {
                        	for $DEUDAS_CANCELADAS in $ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:SIRC/ns1:DIRECTOS/ns1:DEUDAS_CANCELADAS
                            return
                                <REFERENCE>
                                    <CREDITOR>{ data($DEUDAS_CANCELADAS/ns1:ENTIDAD) }</CREDITOR>
                                    <ASSET_TYPE>{ data($DEUDAS_CANCELADAS/ns1:TIPO_ACTIVO) }</ASSET_TYPE>
                                    <WARRANTY_TYPE>{ data($DEUDAS_CANCELADAS/ns1:TIPO_GARANTIA) }</WARRANTY_TYPE>
                                    <CURRENCY>{ data($DEUDAS_CANCELADAS/ns1:MONEDA) }</CURRENCY>
                                    <AMOUNT>{ data($DEUDAS_CANCELADAS/ns1:CAPITAL_ORIGINAL) }</AMOUNT>
                                    <BALANCE>{ data($DEUDAS_CANCELADAS/ns1:SALDO) }</BALANCE>
                                    <DUE_BALANCE>{ data($DEUDAS_CANCELADAS/ns1:VENCIDO) }</DUE_BALANCE>
                                    <OPENING_DATE>{ data($DEUDAS_CANCELADAS/ns1:FECHA_ACTIVO) }</OPENING_DATE>
                                    <CONSESSION_DATE>{ data($DEUDAS_CANCELADAS/ns1:FECHA_CONSESION) }</CONSESSION_DATE>
                                    <EXPIRATION_DATE>{ data($DEUDAS_CANCELADAS/ns1:FECHA_VENCIMIENTO) }</EXPIRATION_DATE>
                                    <CANCELATION_DATE>{ data($DEUDAS_CANCELADAS/ns1:FECHA_CANCELACION) }</CANCELATION_DATE>
                                    <HISTORICAL_ARREAR>{ data($DEUDAS_CANCELADAS/ns1:COMPORTAMIENTO) }</HISTORICAL_ARREAR>
                                    <CATEGORY>{ data($DEUDAS_CANCELADAS/ns1:CATEGORIA) }</CATEGORY>
                                    <REFERENCE_TYPE>DirectosCancelados</REFERENCE_TYPE>
                                    <STATUS>CANCELADO</STATUS>
                                </REFERENCE>
                        }
                        {
                            for $DEUDAS_VIGENTES in $ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:SIRC/ns1:INDIRECTOS/ns1:DEUDAS_VIGENTES
                            return
                                <REFERENCE>
                                    <CREDITOR>{ data($DEUDAS_VIGENTES/ns1:ENTIDAD) }</CREDITOR>
                                    <ASSET_TYPE>{ data($DEUDAS_VIGENTES/ns1:DESC_TIPO_ACTIVO) }</ASSET_TYPE>
                                    <WARRANTY_TYPE>{ data($DEUDAS_VIGENTES/ns1:DESC_TIPO_GARANTIA) }</WARRANTY_TYPE>
                                    <CURRENCY>{ data($DEUDAS_VIGENTES/ns1:MONEDA) }</CURRENCY>
                                    <AMOUNT>{ data($DEUDAS_VIGENTES/ns1:CAPITAL_ORIGINAL) }</AMOUNT>
                                    <BALANCE>{ data($DEUDAS_VIGENTES/ns1:SALDO) }</BALANCE>
                                    <OPENING_DATE>{ data($DEUDAS_VIGENTES/ns1:FECHA_ACTIVO) }</OPENING_DATE>
                                    <CONSESSION_DATE>{ data($DEUDAS_VIGENTES/ns1:FECHA_CONSESION) }</CONSESSION_DATE>
                                    <EXPIRATION_DATE>{ data($DEUDAS_VIGENTES/ns1:FECHA_VENCIMIENTO) }</EXPIRATION_DATE>
                                    <CANCELATION_DATE>{ data($DEUDAS_VIGENTES/ns1:FECHA_CANCELACION) }</CANCELATION_DATE>
                                    <CATEGORY>{ data($DEUDAS_VIGENTES/ns1:CATEGORIA) }</CATEGORY>
                                    <REFERENCE_TYPE>IndirectosVigentes</REFERENCE_TYPE>
                                    <STATUS>VIGENTE</STATUS>
                                </REFERENCE>
                        }
                        {
                            for $DEUDAS_CANCELADAS in $ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:SIRC/ns1:INDIRECTOS/ns1:DEUDAS_CANCELADAS
                            return
                                <REFERENCE>
                                    <CREDITOR>{ data($DEUDAS_CANCELADAS/ns1:ENTIDAD) }</CREDITOR>
                                    <ASSET_TYPE>{ data($DEUDAS_CANCELADAS/ns1:TIPO_ACTIVO) }</ASSET_TYPE>
                                    <WARRANTY_TYPE>{ data($DEUDAS_CANCELADAS/ns1:TIPO_GARANTIA) }</WARRANTY_TYPE>
                                    <CURRENCY>{ data($DEUDAS_CANCELADAS/ns1:MONEDA) }</CURRENCY>
                                    <AMOUNT>{ data($DEUDAS_CANCELADAS/ns1:CAPITAL_ORIGINAL) }</AMOUNT>
                                    <BALANCE>{ data($DEUDAS_CANCELADAS/ns1:SALDO) }</BALANCE>
                                    <OPENING_DATE>{ data($DEUDAS_CANCELADAS/ns1:FECHA_ACTIVO) }</OPENING_DATE>
                                    <CONSESSION_DATE>{ data($DEUDAS_CANCELADAS/ns1:FECHA_CONSESION) }</CONSESSION_DATE>
                                    <EXPIRATION_DATE>{ data($DEUDAS_CANCELADAS/ns1:FECHA_VENCIMIENTO) }</EXPIRATION_DATE>
                                    <CANCELATION_DATE>{ data($DEUDAS_CANCELADAS/ns1:FECHA_CANCELACION) }</CANCELATION_DATE>
                                    <CATEGORY>{ data($DEUDAS_CANCELADAS/ns1:CATEGORIA) }</CATEGORY>
                                    <REFERENCE_TYPE>IndirectosCancelados</REFERENCE_TYPE>
                                    <STATUS>CANCELADO</STATUS>
                                </REFERENCE>
                        }
                        {
                            for $ACTIVO in $ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:SIRC/ns1:ACTIVOS_CONSTRARESERVA/ns1:ACTIVO
                            return
                                <REFERENCE>
                                    <CREDITOR>{ data($ACTIVO/ns1:ENTIDAD) }</CREDITOR>
                                    <WARRANTY_TYPE>{ data($ACTIVO/ns1:FORMA_CANCELACION) }</WARRANTY_TYPE>
                                    <AMOUNT>{ data($ACTIVO/ns1:CAPITAL_ORIGINAL) }</AMOUNT>
                                    <BALANCE>{ data($ACTIVO/ns1:MONTO_SALDO_CAPITAL) }</BALANCE>
                                    <OPENING_DATE>{ data($ACTIVO/ns1:FECHA_SALDO_CAPITAL) }</OPENING_DATE>
                                    <CANCELATION_DATE>{ data($ACTIVO/ns1:FECHA_CANCELACION) }</CANCELATION_DATE>
                                    <REFERENCE_TYPE>ContraReserva</REFERENCE_TYPE>
                                    <STATUS>CANCELADO</STATUS>
                                </REFERENCE>
                        }
                        {
                            for $DEUDAS_VIGENTES in $ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:SIRC/ns1:UNIFICADOS/ns1:DIRECTOS/ns1:DEUDAS_VIGENTES
                            return
                                <REFERENCE>
                                    <DEBTOR_TYPE>{ data($DEUDAS_VIGENTES/ns1:NOM_VINCULO) }</DEBTOR_TYPE>
                                    <CREDITOR>{ data($DEUDAS_VIGENTES/ns1:ENTIDAD) }</CREDITOR>
                                    <ASSET_TYPE>{ data($DEUDAS_VIGENTES/ns1:DESC_TIPO_ACTIVO) }</ASSET_TYPE>
                                    <WARRANTY_TYPE>{ data($DEUDAS_VIGENTES/ns1:DESC_TIPO_GARANTIA) }</WARRANTY_TYPE>
                                    <CURRENCY>{ data($DEUDAS_VIGENTES/ns1:MONEDA) }</CURRENCY>
                                    <AMOUNT>{ data($DEUDAS_VIGENTES/ns1:CAPITAL_ORIGINAL) }</AMOUNT>
                                    <BALANCE>{ data($DEUDAS_VIGENTES/ns1:SALDO) }</BALANCE>
                                    <DUE_BALANCE>{ data($DEUDAS_VIGENTES/ns1:VENCIDO) }</DUE_BALANCE>
                                    <OPENING_DATE>{ data($DEUDAS_VIGENTES/ns1:FECHA_ACTIVO) }</OPENING_DATE>
                                    <CONSESSION_DATE>{ data($DEUDAS_VIGENTES/ns1:FECHA_CONSESION) }</CONSESSION_DATE>
                                    <EXPIRATION_DATE>{ data($DEUDAS_VIGENTES/ns1:FECHA_VENCIMIENTO) }</EXPIRATION_DATE>
                                    <CANCELATION_DATE>{ data($DEUDAS_VIGENTES/ns1:FECHA_CANCELACION) }</CANCELATION_DATE>
                                    <HISTORICAL_ARREAR>{ data($DEUDAS_VIGENTES/ns1:COMPORTAMIENTO) }</HISTORICAL_ARREAR>
                                    <CATEGORY>{ data($DEUDAS_VIGENTES/ns1:CATEGORIA) }</CATEGORY>
                                    <REFERENCE_TYPE>UnificadosDirectosVigentes</REFERENCE_TYPE>
                                    <STATUS>VIGENTE</STATUS>
                                </REFERENCE>
                        }	
                        {
                            for $DEUDAS_CANCELADAS in $ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:SIRC/ns1:UNIFICADOS/ns1:DIRECTOS/ns1:DEUDAS_CANCELADAS
                            return
                                <REFERENCE>
                                    <CREDITOR>{ data($DEUDAS_CANCELADAS/ns1:ENTIDAD) }</CREDITOR>
                                    <ASSET_TYPE>{ data($DEUDAS_CANCELADAS/ns1:TIPO_ACTIVO) }</ASSET_TYPE>
                                    <WARRANTY_TYPE>{ data($DEUDAS_CANCELADAS/ns1:TIPO_GARANTIA) }</WARRANTY_TYPE>
                                    <CURRENCY>{ data($DEUDAS_CANCELADAS/ns1:MONEDA) }</CURRENCY>
                                    <AMOUNT>{ data($DEUDAS_CANCELADAS/ns1:CAPITAL_ORIGINAL) }</AMOUNT>
                                    <BALANCE>{ data($DEUDAS_CANCELADAS/ns1:SALDO) }</BALANCE>
                                    <DUE_BALANCE>{ data($DEUDAS_CANCELADAS/ns1:VENCIDO) }</DUE_BALANCE>
                                    <OPENING_DATE>{ data($DEUDAS_CANCELADAS/ns1:FECHA_ACTIVO) }</OPENING_DATE>
                                    <CONSESSION_DATE>{ data($DEUDAS_CANCELADAS/ns1:FECHA_CONSESION) }</CONSESSION_DATE>
                                    <EXPIRATION_DATE>{ data($DEUDAS_CANCELADAS/ns1:FECHA_VENCIMIENTO) }</EXPIRATION_DATE>
                                    <CANCELATION_DATE>{ data($DEUDAS_CANCELADAS/ns1:FECHA_CANCELACION) }</CANCELATION_DATE>
                                    <HISTORICAL_ARREAR>{ data($DEUDAS_CANCELADAS/ns1:COMPORTAMIENTO) }</HISTORICAL_ARREAR>
                                    <CATEGORY>{ data($DEUDAS_CANCELADAS/ns1:CATEGORIA) }</CATEGORY>
                                    <REFERENCE_TYPE>UnificadosDirectosCancelados</REFERENCE_TYPE>
                                    <STATUS>CANCELADO</STATUS>
                                </REFERENCE>
                        }
                        {
                            for $DEUDAS_VIGENTES in $ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:SIRC/ns1:UNIFICADOS/ns1:INDIRECTOS/ns1:DEUDAS_VIGENTES
                            return
                                <REFERENCE>
                                    <CREDITOR>{ data($DEUDAS_VIGENTES/ns1:ENTIDAD) }</CREDITOR>
                                    <ASSET_TYPE>{ data($DEUDAS_VIGENTES/ns1:DESC_TIPO_ACTIVO) }</ASSET_TYPE>
                                    <WARRANTY_TYPE>{ data($DEUDAS_VIGENTES/ns1:DESC_TIPO_GARANTIA) }</WARRANTY_TYPE>
                                    <CURRENCY>{ data($DEUDAS_VIGENTES/ns1:MONEDA) }</CURRENCY>
                                    <AMOUNT>{ data($DEUDAS_VIGENTES/ns1:CAPITAL_ORIGINAL) }</AMOUNT>
                                    <BALANCE>{ data($DEUDAS_VIGENTES/ns1:SALDO) }</BALANCE>
                                    <OPENING_DATE>{ data($DEUDAS_VIGENTES/ns1:FECHA_ACTIVO) }</OPENING_DATE>
                                    <CONSESSION_DATE>{ data($DEUDAS_VIGENTES/ns1:FECHA_CONSESION) }</CONSESSION_DATE>
                                    <EXPIRATION_DATE>{ data($DEUDAS_VIGENTES/ns1:FECHA_VENCIMIENTO) }</EXPIRATION_DATE>
                                    <CANCELATION_DATE>{ data($DEUDAS_VIGENTES/ns1:FECHA_CANCELACION) }</CANCELATION_DATE>
                                    <CATEGORY>{ data($DEUDAS_VIGENTES/ns1:CATEGORIA) }</CATEGORY>
                                    <REFERENCE_TYPE>UnificadosIndirectosVigentes</REFERENCE_TYPE>
                                    <STATUS>VIGENTE</STATUS>
                                </REFERENCE>
                        }	
                        {
                            for $DEUDAS_CANCELADAS in $ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:SIRC/ns1:UNIFICADOS/ns1:INDIRECTOS/ns1:DEUDAS_CANCELADAS
                            return
                                <REFERENCE>
                                    <CREDITOR>{ data($DEUDAS_CANCELADAS/ns1:ENTIDAD) }</CREDITOR>
                                    <ASSET_TYPE>{ data($DEUDAS_CANCELADAS/ns1:TIPO_ACTIVO) }</ASSET_TYPE>
                                    <WARRANTY_TYPE>{ data($DEUDAS_CANCELADAS/ns1:TIPO_GARANTIA) }</WARRANTY_TYPE>
                                    <CURRENCY>{ data($DEUDAS_CANCELADAS/ns1:MONEDA) }</CURRENCY>
                                    <AMOUNT>{ data($DEUDAS_CANCELADAS/ns1:CAPITAL_ORIGINAL) }</AMOUNT>
                                    <BALANCE>{ data($DEUDAS_CANCELADAS/ns1:SALDO) }</BALANCE>
                                    <OPENING_DATE>{ data($DEUDAS_CANCELADAS/ns1:FECHA_ACTIVO) }</OPENING_DATE>
                                    <CONSESSION_DATE>{ data($DEUDAS_CANCELADAS/ns1:FECHA_CONSESION) }</CONSESSION_DATE>
                                    <EXPIRATION_DATE>{ data($DEUDAS_CANCELADAS/ns1:FECHA_VENCIMIENTO) }</EXPIRATION_DATE>
                                    <CANCELATION_DATE>{ data($DEUDAS_CANCELADAS/ns1:FECHA_CANCELACION) }</CANCELATION_DATE>
                                    <CATEGORY>{ data($DEUDAS_CANCELADAS/ns1:CATEGORIA) }</CATEGORY>
                                    <REFERENCE_TYPE>UnificadosIndirectosCancelados</REFERENCE_TYPE>
                                    <STATUS>CANCELADO</STATUS>
                                </REFERENCE>
                        }	
                    </REFERENCE_BUREAU_SIRC>
                </REFERENCES_DETAILS>
            </LOAN_ORIGINATIONS>
        </ns2:consultaConsolidadaRiesgoClienteResponse>
};

declare variable $consultaConsolidadaRiesgoCliente as element(ns2:consultaConsolidadaRiesgoCliente) external;
declare variable $ConsultaBurosResponse as element(ns1:ConsultaBurosResponse) external;
declare variable $sjConsultaConsolidadaRiesgoClienteGTResponse as element(ns0:sjConsultaConsolidadaRiesgoClienteGTResponse) external;

xf:consultaConsolidadaRiesgoClienteGTOut($consultaConsolidadaRiesgoCliente,
    $ConsultaBurosResponse,
    $sjConsultaConsolidadaRiesgoClienteGTResponse)