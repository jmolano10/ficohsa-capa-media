xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$creaPrestamo" element="ns0:creaPrestamo" location="../../OperacionesPrestamo/xsd/operacionesPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABK/creaPrestamo/xsd/creaPrestamo_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/creaPrestamo";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaPrestamo/xq/creaPrestamoIn/";

declare function xf:creaPrestamoIn($creaPrestamo as element(ns0:creaPrestamo))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PN_CODIGO_EMPRESA>1</ns1:PN_CODIGO_EMPRESA>
            <ns1:PN_CODIGO_AGENCIA>{ xs:decimal(data($creaPrestamo/AGENCY_CODE)) }</ns1:PN_CODIGO_AGENCIA>
            <ns1:PN_CODIGO_SUB_APLICACION>{ xs:decimal(data($creaPrestamo/PRODUCT_CODE)) }</ns1:PN_CODIGO_SUB_APLICACION>
            <ns1:PN_CODIGO_CLIENTE>{ xs:decimal(data($creaPrestamo/CUSTOMER_ID)) }</ns1:PN_CODIGO_CLIENTE>
            <ns1:PV_NOMBRE_PRESTATARIO>{ data($creaPrestamo/CUSTOMER_NAME) }</ns1:PV_NOMBRE_PRESTATARIO>
            <ns1:PV_CODIGO_TIPO_AMORTIZACION>{ data($creaPrestamo/AMORTIZATION_TYPE) }</ns1:PV_CODIGO_TIPO_AMORTIZACION>
            <ns1:PN_TASA>{ data($creaPrestamo/RATE) }</ns1:PN_TASA>
            <ns1:PN_PLAZO>{ xs:decimal(data($creaPrestamo/TERM)) }</ns1:PN_PLAZO>
            <ns1:PN_MONTO_INICIAL>{ data($creaPrestamo/AMOUNT) }</ns1:PN_MONTO_INICIAL>
            <ns1:PV_CALCULAR_MORA>{ data($creaPrestamo/CALCULATE_ARREAR) }</ns1:PV_CALCULAR_MORA>
            <ns1:PV_CODIGO_EJECUTIVO>{ data($creaPrestamo/EXECUTIVE_ID) }</ns1:PV_CODIGO_EJECUTIVO>
            <ns1:PV_CODIGO_LINEA_FINANCIERA>{ data($creaPrestamo/FINANCIAL_LINE_CODE) }</ns1:PV_CODIGO_LINEA_FINANCIERA>
            <ns1:PN_CODIGO_VALOR_TASA_CARTERA>{ data($creaPrestamo/PORTFOLIO_RATE_VALUE_CODE) }</ns1:PN_CODIGO_VALOR_TASA_CARTERA>
            <ns1:PN_CODIGO_INVERSION>{ xs:decimal(data($creaPrestamo/INVESTMENT_CODE)) }</ns1:PN_CODIGO_INVERSION>
            <ns1:PN_CODIGO_ACTIVIDAD_ECONOMICA>{ xs:decimal(data($creaPrestamo/ECONOMIC_ACTIVITY_CODE)) }</ns1:PN_CODIGO_ACTIVIDAD_ECONOMICA>
            <ns1:PV_CODIGO_APROBACION>{ data($creaPrestamo/APPROVAL_CODE) }</ns1:PV_CODIGO_APROBACION>
            <ns1:PN_CODIGO_DESTINO>{ xs:decimal(data($creaPrestamo/LOAN_DESTINATION_CODE)) }</ns1:PN_CODIGO_DESTINO>
            <ns1:PN_CODIGO_DESTINO_DETALLE>{ xs:decimal(data($creaPrestamo/LOAN_DESTINATION_DETAIL_CODE)) }</ns1:PN_CODIGO_DESTINO_DETALLE>
            <ns1:PN_CODIGO_TIPO_PRESTAMO>{ xs:decimal(data($creaPrestamo/LOAN_TYPE_CODE)) }</ns1:PN_CODIGO_TIPO_PRESTAMO>
            <ns1:PN_CODIGO_SUB_INVERSION>{ xs:decimal(data($creaPrestamo/SUBINVESTMENT_CODE)) }</ns1:PN_CODIGO_SUB_INVERSION>
            <ns1:PV_CODIGO_PROMOTOR>{ data($creaPrestamo/PROMOTER_CODE) }</ns1:PV_CODIGO_PROMOTOR>
            <ns1:PV_MANEJO_GARANTIAS>{ data($creaPrestamo/GUARANTEE_HANDLING) }</ns1:PV_MANEJO_GARANTIAS>
            <ns1:PD_FECHA_PRIMER_PAGO_INTERES>{ data($creaPrestamo/FIRST_PAYMENT_INTEREST_DATE) }</ns1:PD_FECHA_PRIMER_PAGO_INTERES>
            <ns1:PD_FECHA_PRIMER_PAGO_CAPITAL>{ data($creaPrestamo/FIRST_PAYMENT_CAPITAL_DATE) }</ns1:PD_FECHA_PRIMER_PAGO_CAPITAL>
            <ns1:PN_FRECUENCIA_INTERES>{ xs:decimal(data($creaPrestamo/INTEREST_FREQUENCY)) }</ns1:PN_FRECUENCIA_INTERES>
            <ns1:PN_FRECUENCIA_CAPITAL>{ xs:decimal(data($creaPrestamo/CAPITAL_FREQUENCY)) }</ns1:PN_FRECUENCIA_CAPITAL>
            <ns1:PN_TIPO_FRECUENCIA_INTERES>{ data($creaPrestamo/INTEREST_FREQUENCY_TYPE) }</ns1:PN_TIPO_FRECUENCIA_INTERES>
            <ns1:PN_TIPO_FRECUENCIA_CAPITAL>{ data($creaPrestamo/CAPITAL_FREQUENCY_TYPE) }</ns1:PN_TIPO_FRECUENCIA_CAPITAL>
            <ns1:PV_TIPO_TASA>{ data($creaPrestamo/RATE_TYPE) }</ns1:PV_TIPO_TASA>
            <ns1:PN_TASA_TOTAL>{ data($creaPrestamo/TOTAL_RATE) }</ns1:PN_TASA_TOTAL>
            <ns1:PV_CLASE_TASA>{ data($creaPrestamo/RATE_CLASS) }</ns1:PV_CLASE_TASA>
            <ns1:PN_DIAS_GRACIA_MORA>{ data($creaPrestamo/ARREAR_GRACE_DAYS) }</ns1:PN_DIAS_GRACIA_MORA>
            <ns1:PV_TIPO_LIQUIDACION_MES>{ data($creaPrestamo/MONTHLY_CLEARING_TYPE) }</ns1:PV_TIPO_LIQUIDACION_MES>
            <ns1:PV_TIPO_LIQUIDACION_ANIO>{ data($creaPrestamo/YEARLY_CLEARING_TYPE) }</ns1:PV_TIPO_LIQUIDACION_ANIO>
            <ns1:PN_CODIGO_VALOR_TASA_MORA>{ data($creaPrestamo/ARREAR_RATE_VALUE_CODE) }</ns1:PN_CODIGO_VALOR_TASA_MORA>
            <ns1:PN_CODIGO_ORIGEN_FONDO>{ xs:decimal(data($creaPrestamo/FUNDS_ORIGIN)) }</ns1:PN_CODIGO_ORIGEN_FONDO>
            <ns1:PN_CODIGO_SUB_ORIGEN_FONDO>{ xs:decimal(data($creaPrestamo/FUNDS_SUBORIGIN)) }</ns1:PN_CODIGO_SUB_ORIGEN_FONDO>
            <ns1:PV_CODIGO_TIPO_OBLIGACION>{ data($creaPrestamo/OBLIGATION_TYPE_CODE) }</ns1:PV_CODIGO_TIPO_OBLIGACION>
            <ns1:PV_CODIGO_TIPO_CREDITO>{ data($creaPrestamo/CREDIT_TYPE_CODE) }</ns1:PV_CODIGO_TIPO_CREDITO>
            <ns1:PN_AGENCIA_ORIGEN_PRESTAMO>{ xs:decimal(data($creaPrestamo/AGENCY_ORIGIN_CODE)) }</ns1:PN_AGENCIA_ORIGEN_PRESTAMO>
            <ns1:PV_CODIGO_TIPO_GARANTIA>{ data($creaPrestamo/GUARANTEE_TYPE_CODE) }</ns1:PV_CODIGO_TIPO_GARANTIA>
            <ns1:PV_ADICIONADO_POR>{ data($creaPrestamo/INPUTTER) }</ns1:PV_ADICIONADO_POR>
            <ns1:PN_CODIGO_DE_PLANILLA>{ xs:decimal(data($creaPrestamo/PAYROLL_CODE)) }</ns1:PN_CODIGO_DE_PLANILLA>
            <ns1:PV_CUENTA_DEBITA>{ data($creaPrestamo/DEBIT_ACCOUNT) }</ns1:PV_CUENTA_DEBITA>
            <ns1:PV_TIPO_FRECUENCIA_PAGO>{ data($creaPrestamo/PAYMENT_FREQUENCY_TYPE) }</ns1:PV_TIPO_FRECUENCIA_PAGO>
            <ns1:PT_NUMERO_POLIZA>
                {
                    for $INSURANCE_ITEM in $creaPrestamo/INSURANCE_INFO/INSURANCE_ITEM,
                        $INSURANCE_POLICY_NUMBER in $INSURANCE_ITEM/INSURANCE_POLICY_NUMBER
                    return
                        <ns1:PT_NUMERO_POLIZA_ITEM>{ data($INSURANCE_POLICY_NUMBER) }</ns1:PT_NUMERO_POLIZA_ITEM>
                }
            </ns1:PT_NUMERO_POLIZA>
            <ns1:PT_CODIGO_TIPO_POLIZA>
                {
                    for $INSURANCE_ITEM in $creaPrestamo/INSURANCE_INFO/INSURANCE_ITEM,
                        $INSURANCE_POLICY_TYPE in $INSURANCE_ITEM/INSURANCE_POLICY_TYPE
                    return
                        <ns1:PT_CODIGO_TIPO_POLIZA_ITEM>{ data($INSURANCE_POLICY_TYPE) }</ns1:PT_CODIGO_TIPO_POLIZA_ITEM>
                }
            </ns1:PT_CODIGO_TIPO_POLIZA>
            <ns1:PT_CODIGO_ASEGURADORA>
                {
                    for $INSURANCE_ITEM in $creaPrestamo/INSURANCE_INFO/INSURANCE_ITEM,
                        $INSURANCE_COMPANY_CODE in $INSURANCE_ITEM/INSURANCE_COMPANY_CODE
                    return
                        <ns1:PT_CODIGO_ASEGURADORA_ITEM>{ data($INSURANCE_COMPANY_CODE) }</ns1:PT_CODIGO_ASEGURADORA_ITEM>
                }
            </ns1:PT_CODIGO_ASEGURADORA>
            <ns1:PT_PRIMA_MENSUAL>
                {
                    for $INSURANCE_ITEM in $creaPrestamo/INSURANCE_INFO/INSURANCE_ITEM,
                        $MONTHLY_PRIME in $INSURANCE_ITEM/MONTHLY_PRIME
                    return
                        <ns1:PT_PRIMA_MENSUAL_ITEM>{ data($MONTHLY_PRIME) }</ns1:PT_PRIMA_MENSUAL_ITEM>
                }
            </ns1:PT_PRIMA_MENSUAL>
            <ns1:PT_PRIMA_ANUAL>
                {
                    for $INSURANCE_ITEM in $creaPrestamo/INSURANCE_INFO/INSURANCE_ITEM,
                        $YEARLY_PRIME in $INSURANCE_ITEM/YEARLY_PRIME
                    return
                        <ns1:PT_PRIMA_MENSUAL_ITEM>{ data($YEARLY_PRIME) }</ns1:PT_PRIMA_MENSUAL_ITEM>
                }
            </ns1:PT_PRIMA_ANUAL>
            <ns1:PT_FECHA_FINAL_SEG>
                {
                    for $INSURANCE_ITEM in $creaPrestamo/INSURANCE_INFO/INSURANCE_ITEM
                    return
                        <ns1:PT_FECHA_FINAL_SEG_ITEM>{ data($INSURANCE_ITEM/INSURANCE_END_DATE) }</ns1:PT_FECHA_FINAL_SEG_ITEM>
                }
            </ns1:PT_FECHA_FINAL_SEG>
            <ns1:PT_COBERTURA_POLIZA>
                {
                    for $INSURANCE_ITEM in $creaPrestamo/INSURANCE_INFO/INSURANCE_ITEM,
                        $INSURANCE_COVERAGE_AMOUNT in $INSURANCE_ITEM/INSURANCE_COVERAGE_AMOUNT
                    return
                        <ns1:PT_PRIMA_MENSUAL_ITEM>{ data($INSURANCE_COVERAGE_AMOUNT) }</ns1:PT_PRIMA_MENSUAL_ITEM>
                }
            </ns1:PT_COBERTURA_POLIZA>
            <ns1:PN_AGENCIA_GARANTIA>{ data($creaPrestamo/AGENCY_CODE) }</ns1:PN_AGENCIA_GARANTIA>
            <ns1:PN_COD_SUBAPL_GARANTIA>{ xs:decimal(data($creaPrestamo/GUARANTEE_INFO/GUARANTEE_ITEM[1]/PRODUCT_CODE)) }</ns1:PN_COD_SUBAPL_GARANTIA>
            {
                for $APPRAISAL_VALUE in $creaPrestamo/GUARANTEE_INFO/GUARANTEE_ITEM[1]/APPRAISAL_VALUE
                return
                    <ns1:PN_VALOR_AVALUO>{ data($APPRAISAL_VALUE) }</ns1:PN_VALOR_AVALUO>
            }
            {
                for $CREDIT_VALUE in $creaPrestamo/GUARANTEE_INFO/GUARANTEE_ITEM[1]/CREDIT_VALUE
                return
                    <ns1:PN_VALOR_CREDITICIO>{ data($CREDIT_VALUE) }</ns1:PN_VALOR_CREDITICIO>
            }
            {
                for $AMOUNT in $creaPrestamo/GUARANTEE_INFO/GUARANTEE_ITEM[1]/AMOUNT
                return
                    <ns1:PN_MONTO_MONEDA_LOCAL>{ data($AMOUNT) }</ns1:PN_MONTO_MONEDA_LOCAL>
            }
            {
                for $COVERAGE_PERCENTAGE in $creaPrestamo/GUARANTEE_INFO/GUARANTEE_ITEM[1]/COVERAGE_PERCENTAGE
                return
                    <ns1:PN_PORCENTAJE_COBERTURA>{ data($COVERAGE_PERCENTAGE) }</ns1:PN_PORCENTAJE_COBERTURA>
            }
            <ns1:PN_TIPO_GARANTIA>{ data($creaPrestamo/GUARANTEE_INFO/GUARANTEE_ITEM[1]/TYPE_CODE) }</ns1:PN_TIPO_GARANTIA>
            {
                for $DESCRIPTION in $creaPrestamo/GUARANTEE_INFO/GUARANTEE_ITEM[1]/DESCRIPTION
                return
                    <ns1:PV_DESCRIPCION_GARANTIA>{ data($DESCRIPTION) }</ns1:PV_DESCRIPCION_GARANTIA>
            }
            {
                for $PRIME_AMOUNT in $creaPrestamo/GUARANTEE_INFO/GUARANTEE_ITEM[1]/PRIME_AMOUNT
                return
                    <ns1:PN_PRIMA>{ data($PRIME_AMOUNT) }</ns1:PN_PRIMA>
            }
            <ns1:PV_TIPO_CREDITO>{ data($creaPrestamo/CREDIT_TYPE_CODE) }</ns1:PV_TIPO_CREDITO>
            <ns1:PT_ID_CODEUDOR>
                {
                    for $ID in $creaPrestamo/GUARANTEE_INFO/GUARANTEE_ITEM[1]/CODEBTORS/CODEBTOR
                    return
                        <ns1:PT_ID_CODEUDOR_ITEM>{ data($ID/CUSTOMER_ID) }</ns1:PT_ID_CODEUDOR_ITEM>
                }
            </ns1:PT_ID_CODEUDOR>
            <ns1:PT_NAME_CODEUDOR>
                {
                    for $CODEBTOR in $creaPrestamo/GUARANTEE_INFO/GUARANTEE_ITEM[1]/CODEBTORS/CODEBTOR,
                        $NAME in $CODEBTOR/NAME
                    return
                        <ns1:PT_NAME_CODEUDOR_ITEM>{ data($NAME) }</ns1:PT_NAME_CODEUDOR_ITEM>
                }
            </ns1:PT_NAME_CODEUDOR>
            <ns1:PT_ID_FIADOR>
                {
                    for $GUARANTOR in $creaPrestamo/GUARANTEE_INFO/GUARANTEE_ITEM[1]/GUARANTORS/GUARANTOR
                    return
                        <ns1:PT_ID_CODEUDOR_ITEM>{ data($GUARANTOR/CUSTOMER_ID) }</ns1:PT_ID_CODEUDOR_ITEM>
                }
            </ns1:PT_ID_FIADOR>
            <ns1:PT_NAME_FIADOR>
                {
                    for $GUARANTOR in $creaPrestamo/GUARANTEE_INFO/GUARANTEE_ITEM[1]/GUARANTORS/GUARANTOR,
                        $NAME in $GUARANTOR/NAME
                    return
                        <ns1:PT_NAME_CODEUDOR_ITEM>{ data($NAME) }</ns1:PT_NAME_CODEUDOR_ITEM>
                }
            </ns1:PT_NAME_FIADOR>
            <ns1:PT_NOMBRE_ITEM_FAUTO>
                {
                    for $ITEM in $creaPrestamo/GUARANTEE_INFO/GUARANTEE_ITEM[1]/ADDITIONAL_INFO/ITEM,
                        $ID in $ITEM/ID
                    return
                        <ns1:PT_NOMBRE_ITEM_FAUTO_ITEM>{ data($ID) }</ns1:PT_NOMBRE_ITEM_FAUTO_ITEM>
                }
            </ns1:PT_NOMBRE_ITEM_FAUTO>
            <ns1:PT_VALOR_ITEM_FAUTO>
                {
                    for $ITEM in $creaPrestamo/GUARANTEE_INFO/GUARANTEE_ITEM[1]/ADDITIONAL_INFO/ITEM,
                        $NAME in $ITEM/NAME
                    return
                        <ns1:PT_VALOR_ITEM_FAUTO_ITEM>{ data($NAME) }</ns1:PT_VALOR_ITEM_FAUTO_ITEM>
                }
            </ns1:PT_VALOR_ITEM_FAUTO>
            <ns1:PV_CODIGO_DEPTO>{ data($creaPrestamo/DEPT_CODE) }</ns1:PV_CODIGO_DEPTO>
            <ns1:PV_CODIGO_MUNICIPIO>{ data($creaPrestamo/MUNICIPALITY_CODE) }</ns1:PV_CODIGO_MUNICIPIO>
            <ns1:PV_CODIGO_ALDEA>{ data($creaPrestamo/VILLAGE_CODE) }</ns1:PV_CODIGO_ALDEA>
            <ns1:PV_CATEGORIA_RAS>{ data($creaPrestamo/CATEGORY_RAS) }</ns1:PV_CATEGORIA_RAS>
            <ns1:PD_FECHA_DESEMBOLSO>{ data($creaPrestamo/DISBURSEMENT_DATE) }</ns1:PD_FECHA_DESEMBOLSO>
        </ns1:InputParameters>
};

declare variable $creaPrestamo as element(ns0:creaPrestamo) external;

xf:creaPrestamoIn($creaPrestamo)