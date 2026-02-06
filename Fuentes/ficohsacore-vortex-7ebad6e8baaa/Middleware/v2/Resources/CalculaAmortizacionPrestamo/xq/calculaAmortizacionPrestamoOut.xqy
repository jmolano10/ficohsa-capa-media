xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/PWS/calculaAmortizacionPrestamo/xsd/calculaAmortizacionPrestamo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:calculaAmortizacionPrestamoResponse" location="../xsd/calculaAmortizacionPrestamoTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/calculaAmortizacionPrestamo";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/calculaAmortizacionPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CalculaAmortizacionPrestamo/xq/calculaAmortizacionPrestamoOut/";

declare function xf:calculaAmortizacionPrestamoOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:calculaAmortizacionPrestamoResponse) {
        <ns1:calculaAmortizacionPrestamoResponse>
            <GENERAL_INFO>
                {
                    for $TOTAL_CAPITAL in $outputParameters1/ns0:TOTAL_CAPITAL
                    return
                        <TOTAL_CAPITAL>{ data($TOTAL_CAPITAL) }</TOTAL_CAPITAL>
                }
                {
                    for $TOTAL_INTERESTS in $outputParameters1/ns0:TOTAL_INTERESTS
                    return
                        <TOTAL_INTERESTS>{ data($TOTAL_INTERESTS) }</TOTAL_INTERESTS>
                }
                <TOTAL_INSURANCE_INFO>
                    {
                        for $TOTAL_LIFE_DEBT in $outputParameters1/ns0:TOTAL_LIFE_DEBT
                        return
                            <LIFE_DEBT>{ data($TOTAL_LIFE_DEBT) }</LIFE_DEBT>
                    }
                    {
                        for $TOTAL_UNEMPLOYMENT in $outputParameters1/ns0:TOTAL_UNEMPLOYMENT
                        return
                            <UNEMPLOYMENT>{ data($TOTAL_UNEMPLOYMENT) }</UNEMPLOYMENT>
                    }
                </TOTAL_INSURANCE_INFO>
                {
                    for $TOTAL_PAYMENT in $outputParameters1/ns0:TOTAL_PAYMENT
                    return
                        <TOTAL_PAYMENT>{ data($TOTAL_PAYMENT) }</TOTAL_PAYMENT>
                }
                {
                    for $TOTAL_ANNUAL_COST in $outputParameters1/ns0:TOTAL_ANNUAL_COST
                    return
                        <TOTAL_ANNUAL_COST>{ data($TOTAL_ANNUAL_COST) }</TOTAL_ANNUAL_COST>
                }
                {
                    for $INTERNAL_RATE_RETURN in $outputParameters1/ns0:INTERNAL_RATE_RETURN
                    return
                        <INTERNAL_RATE_RETURN>{ data($INTERNAL_RATE_RETURN) }</INTERNAL_RATE_RETURN>
                }
                {
                    for $FORMALIZATION_EXPENSE in $outputParameters1/ns0:FORMALIZATION_EXPENSE
                    return
                        <FORMALIZATION_EXPENSE>{ data($FORMALIZATION_EXPENSE) }</FORMALIZATION_EXPENSE>
                }
            </GENERAL_INFO>
            <DISBURSEMENT_INFO>
                {
                    for $DISBURSEMENT_AMOUNT in $outputParameters1/ns0:DISBURSEMENT_AMOUNT
                    return
                        <AMOUNT>{ data($DISBURSEMENT_AMOUNT) }</AMOUNT>
                }
                {
                    for $DISBURSEMENT_FEE in $outputParameters1/ns0:DISBURSEMENT_FEE
                    return
                        <FEE>{ data($DISBURSEMENT_FEE) }</FEE>
                }
            </DISBURSEMENT_INFO>
            <PRIME_INSURANCE_INFO>
                {
                    for $PRIME_LIFE_DEBT in $outputParameters1/ns0:PRIME_LIFE_DEBT
                    return
                        <LIFE_DEBT>{ data($PRIME_LIFE_DEBT) }</LIFE_DEBT>
                }
                {
                    for $PRIME_UNEMPLOYMENT in $outputParameters1/ns0:PRIME_UNEMPLOYMENT
                    return
                        <UNEMPLOYMENT>{ data($PRIME_UNEMPLOYMENT) }</UNEMPLOYMENT>
                }
            </PRIME_INSURANCE_INFO>
            {
                for $LOAN_PAYMENTS in $outputParameters1/ns0:LOAN_PAYMENTS
                return
                    <PAYMENT_PLAN>
                        {
                            for $LOAN_PAYMENTS_ITEM in $LOAN_PAYMENTS/ns0:LOAN_PAYMENTS_ITEM
                            return
                                <PAYMENT>
                                    {
                                        for $PAYMENT_ORDER in $LOAN_PAYMENTS_ITEM/ns0:PAYMENT_ORDER
                                        return
                                            <ORDER>{ data($PAYMENT_ORDER) }</ORDER>
                                    }
                                    {
                                        for $PAYMENT_DATE in $LOAN_PAYMENTS_ITEM/ns0:PAYMENT_DATE
                                        return
                                            <DATE>{ data($PAYMENT_DATE) }</DATE>
                                    }
                                    {
                                        for $DAYS_IN_PERIOD in $LOAN_PAYMENTS_ITEM/ns0:DAYS_IN_PERIOD
                                        return
                                            <DAYS_IN_PERIOD>{ data($DAYS_IN_PERIOD) }</DAYS_IN_PERIOD>
                                    }
                                    {
                                        for $PAYMENT_CAPITAL in $LOAN_PAYMENTS_ITEM/ns0:PAYMENT_CAPITAL
                                        return
                                            <CAPITAL>{ data($PAYMENT_CAPITAL) }</CAPITAL>
                                    }
                                    {
                                        for $PAYMENT_INTERESTS in $LOAN_PAYMENTS_ITEM/ns0:PAYMENT_INTERESTS
                                        return
                                            <INTERESTS>{ data($PAYMENT_INTERESTS) }</INTERESTS>
                                    }
                                    <INSURANCE_INFO>
                                        {
                                            for $INSURANCE_LIFE_DEBT in $LOAN_PAYMENTS_ITEM/ns0:INSURANCE_LIFE_DEBT
                                            return
                                                <LIFE_DEBT>{ data($INSURANCE_LIFE_DEBT) }</LIFE_DEBT>
                                        }
                                        {
                                            for $INSURANCE_UNEMPLOYMENT in $LOAN_PAYMENTS_ITEM/ns0:INSURANCE_UNEMPLOYMENT
                                            return
                                                <UNEMPLOYMENT>{ data($INSURANCE_UNEMPLOYMENT) }</UNEMPLOYMENT>
                                        }
                                    </INSURANCE_INFO>
                                    {
                                        for $PAYMENT_TOTAL in $LOAN_PAYMENTS_ITEM/ns0:PAYMENT_TOTAL
                                        return
                                            <TOTAL>{ data($PAYMENT_TOTAL) }</TOTAL>
                                    }
                                    {
                                        for $PRINCIPAL_BALANCE in $LOAN_PAYMENTS_ITEM/ns0:PRINCIPAL_BALANCE
                                        return
                                            <PRINCIPAL_BALANCE>{ data($PRINCIPAL_BALANCE) }</PRINCIPAL_BALANCE>
                                    }
                                </PAYMENT>
                        }
                    </PAYMENT_PLAN>
            }
        </ns1:calculaAmortizacionPrestamoResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:calculaAmortizacionPrestamoOut($outputParameters1)