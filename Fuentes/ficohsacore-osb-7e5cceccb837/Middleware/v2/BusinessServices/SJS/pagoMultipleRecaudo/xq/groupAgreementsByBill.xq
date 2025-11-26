xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$sjPagoMultipleRecaudo" element="ns0:sjPagoMultipleRecaudo" location="../xsd/sjPagoMultipleRecaudo.xsd" ::)
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/pagoMultipleRecaudo/xq/agruparAgreementsxContract/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjPagoMultipleRecaudo";

declare function xf:agruparAgreementsxContract($sjPagoMultipleRecaudo as element(ns0:sjPagoMultipleRecaudo))
    as element(*) {
        <AGREEMENTS>
            {
                for $AGREEMENT in $sjPagoMultipleRecaudo/AGREEMENTS/AGREEMENT
                    for $DEBTOR in $AGREEMENT/DEBTORS/DEBTOR
                        for $bill in $DEBTOR/BILLS/BILL
                        return
                            <AGREEMENT>
                                {
                                    for $CONTRACT_ID in $AGREEMENT/CONTRACT_ID
                                    return
                                        <CONTRACT_ID>{ data($CONTRACT_ID) }</CONTRACT_ID>
                                }
                                {
                                    for $DEBTOR_CODE in $DEBTOR/DEBTOR_CODE
                                    return
                                        <DEBTOR_CODE>{data($DEBTOR_CODE)}</DEBTOR_CODE>
                                }
                                {
                                    for $DEBTOR_NAME in $DEBTOR/DEBTOR_NAME
                                    return
                                        <DEBTOR_NAME>{data($DEBTOR_NAME)}</DEBTOR_NAME>
                                }
                                <PAYMENT_INFORMATION>
                                    {
                                    for $PAYMENT_METHOD in $bill/PAYMENT_INFORMATION/PAYMENT_METHOD
                                        return
                                        (
                                            <PAYMENT_METHOD>{data($PAYMENT_METHOD)}</PAYMENT_METHOD>
                                        )
                                    }
                                    {
                                    for $PAYMENT_CURRENCY in $bill/PAYMENT_INFORMATION/PAYMENT_CURRENCY
                                        return
                                        (
                                            <PAYMENT_CURRENCY>{data($PAYMENT_CURRENCY)}</PAYMENT_CURRENCY>
                                        )
                                    }
                                    {
                                    for $PAYMENT_AMOUNT in $bill/PAYMENT_INFORMATION/PAYMENT_AMOUNT
                                        return
                                        (
                                            <PAYMENT_AMOUNT>{data($PAYMENT_AMOUNT)}</PAYMENT_AMOUNT>
                                        )
                                    }
                                    {
                                    for $DEBIT_ACCOUNT in $bill/PAYMENT_INFORMATION/DEBIT_ACCOUNT
                                        return
                                        (
                                            <DEBIT_ACCOUNT>{data($DEBIT_ACCOUNT)}</DEBIT_ACCOUNT>
                                        )
                                    }
                                    {
                                    for $CHEQUE_NUMBER in $bill/PAYMENT_INFORMATION/CHEQUE_NUMBER
                                        return
                                        (
                                            <CHEQUE_NUMBER>{data($CHEQUE_NUMBER)}</CHEQUE_NUMBER>
                                        )
                                    }
                                    {
                                    for $BANK_CODE in $bill/PAYMENT_INFORMATION/BANK_CODE
                                        return
                                        (
                                            <BANK_CODE>{data($BANK_CODE)}</BANK_CODE>
                                        )
                                    }
                                    {
                                    for $CREDIT_CARD_NUMBER in $bill/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER
                                        return
                                        (
                                            <CREDIT_CARD_NUMBER>{data($CREDIT_CARD_NUMBER)}</CREDIT_CARD_NUMBER>
                                        )
                                    }
                                    {
                                    for $EXPIRATION_DATE in $bill/PAYMENT_INFORMATION/EXPIRATION_DATE
                                        return
                                        (
                                            <EXPIRATION_DATE>{data($EXPIRATION_DATE)}</EXPIRATION_DATE>
                                        )
                                    }
                                </PAYMENT_INFORMATION>,
                                <BILL_INFORMATION>
                                    {
                                    for $BILL_NUMBER in $bill/BILL_NUMBER
                                        return
                                        (
                                            <BILL_NUMBER>{data($BILL_NUMBER)}</BILL_NUMBER>
                                        )
                                    }
                                    {
                                    for $DUE_DATE in $bill/DUE_DATE
                                        return
                                        (
                                            <DUE_DATE>{data($DUE_DATE)}</DUE_DATE>
                                        )
                                    }
                                </BILL_INFORMATION>,
                                    {
                                    for $EXTENDED_COLLECTION_YES_NO in $bill/EXTENDED_COLLECTION_YES_NO
                                        return
                                        (
                                            <EXTENDED_COLLECTION_YES_NO>{data($EXTENDED_COLLECTION_YES_NO)}</EXTENDED_COLLECTION_YES_NO>
                                        )
                                    }
                                    {
                                    for $DEALSLIP_PICKUP_BRANCH in $bill/DEALSLIP_PICKUP_BRANCH
                                        return
                                        (
                                            <DEALSLIP_PICKUP_BRANCH>{data($DEALSLIP_PICKUP_BRANCH)}</DEALSLIP_PICKUP_BRANCH>
                                        )
                                    }
                                <ADDITIONAL_INFO>
                                {
                                    for $DATA in $bill/ADDITIONAL_INFO/DATA
                                        return
                                        (
                                            <DATA>{data($DATA)}</DATA>
                                        )
                                    }
                                </ADDITIONAL_INFO>
                            </AGREEMENT>
            }
        </AGREEMENTS>
};

declare variable $sjPagoMultipleRecaudo as element(ns0:sjPagoMultipleRecaudo) external;

xf:agruparAgreementsxContract($sjPagoMultipleRecaudo)