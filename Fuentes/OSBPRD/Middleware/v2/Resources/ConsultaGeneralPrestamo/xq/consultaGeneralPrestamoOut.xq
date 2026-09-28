(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../../Business_Resources/consultaGeneralPrestamo/Resources/ConsultaGeneralPrestamo/xsd/ORA_BANK_OSB_CON_GENERAL_PRESTAMO.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaGeneralPrestamoResponse" location="../xsd/consultaGeneralPrestamoTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_CON_GENERAL_PRESTAMO/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaGeneralPrestamo/xq/consultaGeneralPrestamoOut2/";

declare function xf:consultaGeneralPrestamoOut2($outputParameters1 as element(ns1:OutputParameters),
    $functionalityDisplayIndicator as xs:string)
    as element(ns0:consultaGeneralPrestamoResponse) {
        <ns0:consultaGeneralPrestamoResponse>
            <ns0:consultaGeneralPrestamoResponseType>
                <ns0:consultaGeneralPrestamoResponseRecordType>
                    {
                        for $LOAN_CUSTOMER_NAME in $outputParameters1/ns1:LOAN_CUSTOMER_NAME
                        return
                            <LOAN_CUSTOMER_NAME>{ data($LOAN_CUSTOMER_NAME) }</LOAN_CUSTOMER_NAME>
                    }
                    {
                        for $EFFECTIVE_DATE in $outputParameters1/ns1:EFFECTIVE_DATE
                        return
                            <EFFECTIVE_DATE>{ data($EFFECTIVE_DATE) }</EFFECTIVE_DATE>
                    }
                    {
                    if ($functionalityDisplayIndicator = ('ALL')) then (
                        for $MATURITY_DATE in $outputParameters1/ns1:MATURITY_DATE
                        return
                            <MATURITY_DATE>{ data($MATURITY_DATE) }</MATURITY_DATE>,
                        for $INTEREST_RATE in $outputParameters1/ns1:INTEREST_RATE
                        return
                            <INTEREST_RATE>{ data($INTEREST_RATE) }</INTEREST_RATE>,
                        for $PRINCIPAL_INITIAL_AMT in $outputParameters1/ns1:PRINCIPAL_INITIAL_AMT
                        return
                            <PRINCIPAL_INITIAL_AMT>{ data($PRINCIPAL_INITIAL_AMT) }</PRINCIPAL_INITIAL_AMT>,
                        for $PRINCIPAL_DUE_AMT in $outputParameters1/ns1:PRINCIPAL_DUE_AMT
                        return
                            <PRINCIPAL_DUE_AMT>{ data($PRINCIPAL_DUE_AMT) }</PRINCIPAL_DUE_AMT>,
                        for $PRINCIPAL_OVERDUE_AMT in $outputParameters1/ns1:PRINCIPAL_OVERDUE_AMT
                        return
                            <PRINCIPAL_OVERDUE_AMT>{ data($PRINCIPAL_OVERDUE_AMT) }</PRINCIPAL_OVERDUE_AMT>,
                        for $INTEREST_AMOUNT in $outputParameters1/ns1:INTEREST_AMOUNT
                        return
                            <INTEREST_AMOUNT>{ data($INTEREST_AMOUNT) }</INTEREST_AMOUNT>,
                        for $OVERDUE_INTEREST_AMOUNT in $outputParameters1/ns1:OVERDUE_INTEREST_AMOUNT
                        return
                            <OVERDUE_INTEREST_AMOUNT>{ data($OVERDUE_INTEREST_AMOUNT) }</OVERDUE_INTEREST_AMOUNT>,
                        for $COMISION_AMOUNT in $outputParameters1/ns1:COMISION_AMOUNT
                        return
                            <COMISION_AMOUNT>{ data($COMISION_AMOUNT) }</COMISION_AMOUNT>,
                        for $TOTAL_DEBT in $outputParameters1/ns1:TOTAL_DEBT
                        return
                            <TOTAL_DEBT>{ data($TOTAL_DEBT) }</TOTAL_DEBT>,
                        for $NEXT_PAYMNT_ID in $outputParameters1/ns1:NEXT_PAYMNT_ID
                        return
                            <NEXT_PAYMNT_ID>{ data($NEXT_PAYMNT_ID) }</NEXT_PAYMNT_ID>,
                        for $NEXT_PAYMNT_MATURITY_DATE in $outputParameters1/ns1:NEXT_PAYMNT_MATURITY_DATE
                        return
                            <NEXT_PAYMNT_MATURITY_DATE>{ data($NEXT_PAYMNT_MATURITY_DATE) }</NEXT_PAYMNT_MATURITY_DATE>,
                        for $OVERDUE_PAYMENTS in $outputParameters1/ns1:OVERDUE_PAYMENTS
                        return
                            <OVERDUE_PAYMENTS>{ data($OVERDUE_PAYMENTS) }</OVERDUE_PAYMENTS>,
                        for $NEXT_PAYMNT_PRINCIPAL_AMT in $outputParameters1/ns1:NEXT_PAYMNT_PRINCIPAL_AMT
                        return
                            <NEXT_PAYMNT_PRINCIPAL_AMT>{ data($NEXT_PAYMNT_PRINCIPAL_AMT) }</NEXT_PAYMNT_PRINCIPAL_AMT>,
                        for $NEXT_PAYMNT_INTEREST_AMT in $outputParameters1/ns1:NEXT_PAYMNT_INTEREST_AMT
                        return
                            <NEXT_PAYMNT_INTEREST_AMT>{ data($NEXT_PAYMNT_INTEREST_AMT) }</NEXT_PAYMNT_INTEREST_AMT>
                        )else
                        (
                        )
                    
                    }
                    {
                        for $NEXT_PAYMNT_INSURANCE_AMT in $outputParameters1/ns1:NEXT_PAYMNT_INSURANCE_AMT
                        return
                            <NEXT_PAYMNT_INSURANCE_AMT>{ data($NEXT_PAYMNT_INSURANCE_AMT) }</NEXT_PAYMNT_INSURANCE_AMT>
                    }
                    {
                        if($functionalityDisplayIndicator = ('ALL')) then (
                            for $NEXT_PAYMNT_TOTAL_AMT in $outputParameters1/ns1:NEXT_PAYMNT_TOTAL_AMT
                            return
                                <NEXT_PAYMNT_TOTAL_AMT>{ data($NEXT_PAYMNT_TOTAL_AMT) }</NEXT_PAYMNT_TOTAL_AMT>
                        )else
                        (
                        )
                    }
                    {
                        for $CURRENCY in $outputParameters1/ns1:CURRENCY
                        return
                            <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                    }
                    {
                        for $LASTDISBURSEMENTDATE in $outputParameters1/ns1:LASTDISBURSEMENTDATE
                        return
                            <LAST_DISBURSEMENT_DATE>{ data($LASTDISBURSEMENTDATE) }</LAST_DISBURSEMENT_DATE>
                    }
                    <EXPIRED_INTEREST_AMOUNT>0</EXPIRED_INTEREST_AMOUNT>
                    {
                        for $CODIGO_CLIENTE in $outputParameters1/ns1:CODIGO_CLIENTE
                        return
                            <CUSTOMER_ID>{ data($CODIGO_CLIENTE) }</CUSTOMER_ID>
                    }
                    {
                        for $TYPE_GUARANTEE in $outputParameters1/ns1:TYPE_GUARANTEE
                        return
                            <TYPE_GUARANTEE>{ data($TYPE_GUARANTEE) }</TYPE_GUARANTEE>
                    }
                    {
                        for $GUARANTEE_DESC in $outputParameters1/ns1:GUARANTEE_DESC
                        return
                            <GUARANTEE_DESC>{ data($GUARANTEE_DESC) }</GUARANTEE_DESC>
                    }
                    {
                        for $LOAN_STATUS in $outputParameters1/ns1:LOAN_STATUS
                        return
                            <LOAN_STATUS>{ data($LOAN_STATUS) }</LOAN_STATUS>
                    }
                    {
                        for $CREDIT_TYPE_CODE in $outputParameters1/ns1:CREDIT_TYPE_CODE
                        return
                            <CREDIT_TYPE_CODE>{ data($CREDIT_TYPE_CODE) }</CREDIT_TYPE_CODE>
                    }
                    {
                        for $CREDIT_TYPE_DESC in $outputParameters1/ns1:CREDIT_TYPE_DESC
                        return
                            <CREDIT_TYPE_DESC>{ data($CREDIT_TYPE_DESC) }</CREDIT_TYPE_DESC>
                    }
                    {
                        for $PRODUCT_CODE in $outputParameters1/ns1:PRODUCT_CODE
                        return
                            <PRODUCT_CODE>{ data($PRODUCT_CODE) }</PRODUCT_CODE>
                    }
                    {
                        for $PRODUCT_DESC in $outputParameters1/ns1:PRODUCT_DESC
                        return
                            <PRODUCT_DESC>{ data($PRODUCT_DESC) }</PRODUCT_DESC>
                    }
                    {
                        for $NUMBER_OF_PAYMENTS in $outputParameters1/ns1:NUMBER_OF_PAYMENTS
                        return
                            <NUMBER_OF_PAYMENTS>{ data($NUMBER_OF_PAYMENTS) }</NUMBER_OF_PAYMENTS>
                    }
                    {
                        for $PAID_PAYMENTS in $outputParameters1/ns1:PAID_PAYMENTS
                        return
                            <PAID_PAYMENTS>{ data($PAID_PAYMENTS) }</PAID_PAYMENTS>
                    }
                </ns0:consultaGeneralPrestamoResponseRecordType>
            </ns0:consultaGeneralPrestamoResponseType>
        </ns0:consultaGeneralPrestamoResponse>
};
declare variable $outputParameters1 as element(ns1:OutputParameters) external;
declare variable $functionalityDisplayIndicator as xs:string external;
xf:consultaGeneralPrestamoOut2($outputParameters1,
    $functionalityDisplayIndicator)