xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="Resources/ConsultaGeneralPrestamo/xsd/ORA_BANK_OSB_CON_GENERAL_PRESTAMO.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaGeneralPrestamoResponse" location="consultaGeneralPrestamoTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_CON_GENERAL_PRESTAMO/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaGeneralPrestamo/consultaGeneralPrestamoOut/";

declare function xf:consultaGeneralPrestamoOut($outputParameters1 as element(ns1:OutputParameters))
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
                        for $MATURITY_DATE in $outputParameters1/ns1:MATURITY_DATE
                        return
                            <MATURITY_DATE>{ data($MATURITY_DATE) }</MATURITY_DATE>
                    }
                    {
                        for $INTEREST_RATE in $outputParameters1/ns1:INTEREST_RATE
                        return
                            <INTEREST_RATE>{ data($INTEREST_RATE) }</INTEREST_RATE>
                    }
                    {
                        for $PRINCIPAL_INITIAL_AMT in $outputParameters1/ns1:PRINCIPAL_INITIAL_AMT
                        return
                            <PRINCIPAL_INITIAL_AMT>{ data($PRINCIPAL_INITIAL_AMT) }</PRINCIPAL_INITIAL_AMT>
                    }
                    {
                        for $PRINCIPAL_DUE_AMT in $outputParameters1/ns1:PRINCIPAL_DUE_AMT
                        return
                            <PRINCIPAL_DUE_AMT>{ data($PRINCIPAL_DUE_AMT) }</PRINCIPAL_DUE_AMT>
                    }
                    {
                        for $PRINCIPAL_OVERDUE_AMT in $outputParameters1/ns1:PRINCIPAL_OVERDUE_AMT
                        return
                            <PRINCIPAL_OVERDUE_AMT>{ data($PRINCIPAL_OVERDUE_AMT) }</PRINCIPAL_OVERDUE_AMT>
                    }
                    {
                        for $INTEREST_AMOUNT in $outputParameters1/ns1:INTEREST_AMOUNT
                        return
                            <INTEREST_AMOUNT>{ data($INTEREST_AMOUNT) }</INTEREST_AMOUNT>
                    }
                    {
                        for $OVERDUE_INTEREST_AMOUNT in $outputParameters1/ns1:OVERDUE_INTEREST_AMOUNT
                        return
                            <OVERDUE_INTEREST_AMOUNT>{ data($OVERDUE_INTEREST_AMOUNT) }</OVERDUE_INTEREST_AMOUNT>
                    }
                    {
                        for $COMISION_AMOUNT in $outputParameters1/ns1:COMISION_AMOUNT
                        return
                            <COMISION_AMOUNT>{ data($COMISION_AMOUNT) }</COMISION_AMOUNT>
                    }
                    {
                        for $TOTAL_DEBT in $outputParameters1/ns1:TOTAL_DEBT
                        return
                            <TOTAL_DEBT>{ data($TOTAL_DEBT) }</TOTAL_DEBT>
                    }
                    {
                        for $NEXT_PAYMNT_ID in $outputParameters1/ns1:NEXT_PAYMNT_ID
                        return
                            <NEXT_PAYMNT_ID>{ data($NEXT_PAYMNT_ID) }</NEXT_PAYMNT_ID>
                    }
                    {
                        for $NEXT_PAYMNT_MATURITY_DATE in $outputParameters1/ns1:NEXT_PAYMNT_MATURITY_DATE
                        return
                            <NEXT_PAYMNT_MATURITY_DATE>{ data($NEXT_PAYMNT_MATURITY_DATE) }</NEXT_PAYMNT_MATURITY_DATE>
                    }
                    {
                        for $OVERDUE_PAYMENTS in $outputParameters1/ns1:OVERDUE_PAYMENTS
                        return
                            <OVERDUE_PAYMENTS>{ data($OVERDUE_PAYMENTS) }</OVERDUE_PAYMENTS>
                    }
                    {
                        for $NEXT_PAYMNT_PRINCIPAL_AMT in $outputParameters1/ns1:NEXT_PAYMNT_PRINCIPAL_AMT
                        return
                            <NEXT_PAYMNT_PRINCIPAL_AMT>{ data($NEXT_PAYMNT_PRINCIPAL_AMT) }</NEXT_PAYMNT_PRINCIPAL_AMT>
                    }
                    {
                        for $NEXT_PAYMNT_INTEREST_AMT in $outputParameters1/ns1:NEXT_PAYMNT_INTEREST_AMT
                        return
                            <NEXT_PAYMNT_INTEREST_AMT>{ data($NEXT_PAYMNT_INTEREST_AMT) }</NEXT_PAYMNT_INTEREST_AMT>
                    }
                    {
                        for $NEXT_PAYMNT_INSURANCE_AMT in $outputParameters1/ns1:NEXT_PAYMNT_INSURANCE_AMT
                        return
                            <NEXT_PAYMNT_INSURANCE_AMT>{ data($NEXT_PAYMNT_INSURANCE_AMT) }</NEXT_PAYMNT_INSURANCE_AMT>
                    }
                    {
                        for $NEXT_PAYMNT_TOTAL_AMT in $outputParameters1/ns1:NEXT_PAYMNT_TOTAL_AMT
                        return
                            <NEXT_PAYMNT_TOTAL_AMT>{ data($NEXT_PAYMNT_TOTAL_AMT) }</NEXT_PAYMNT_TOTAL_AMT>
                    }
                    {
                        for $CURRENCY in $outputParameters1/ns1:CURRENCY
                        return
                            <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                    }
                </ns0:consultaGeneralPrestamoResponseRecordType>
            </ns0:consultaGeneralPrestamoResponseType>
        </ns0:consultaGeneralPrestamoResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consultaGeneralPrestamoOut($outputParameters1)