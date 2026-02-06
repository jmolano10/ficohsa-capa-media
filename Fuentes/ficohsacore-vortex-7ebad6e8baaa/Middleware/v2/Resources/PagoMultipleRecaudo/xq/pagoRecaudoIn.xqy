xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoMultipleRecaudoRequestIN" element="ns0:pagoMultipleRecaudoRequest" location="../xsd/pagoMultipleRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoMultipleRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoMultipleRecaudo/xq/pagoRecaudoIn/";

declare function xf:pagoRecaudoIn($pagoMultipleRecaudoRequestIN as element(ns0:pagoMultipleRecaudoRequest))
    as element(ns1:pagoRecaudo) {
        <ns1:pagoRecaudo>
            <CONTRACT_ID>{ data($pagoMultipleRecaudoRequestIN/ns0:AGREEMENTS/ns0:AGREEMENT[1]/ns0:CONTRACT_ID) }</CONTRACT_ID>
            <DEBTOR_CODE>{ data($pagoMultipleRecaudoRequestIN/ns0:AGREEMENTS/ns0:AGREEMENT[1]/ns0:DEBTORS/ns0:DEBTOR[1]/ns0:DEBTOR_CODE) }</DEBTOR_CODE>
            {
                for $DEBTOR_NAME in $pagoMultipleRecaudoRequestIN/ns0:AGREEMENTS/ns0:AGREEMENT[1]/ns0:DEBTORS/ns0:DEBTOR[1]/ns0:DEBTOR_NAME
                return
                    <DEBTOR_NAME>{ data($DEBTOR_NAME) }</DEBTOR_NAME>
            }
            <PAYMENT_INFORMATION>
                <PAYMENT_METHOD>{ data($pagoMultipleRecaudoRequestIN/ns0:AGREEMENTS/ns0:AGREEMENT[1]/ns0:DEBTORS/ns0:DEBTOR[1]/ns0:BILLS/ns0:BILL[1]/ns0:PAYMENT_INFORMATION/ns0:PAYMENT_METHOD) }</PAYMENT_METHOD>
                <PAYMENT_CURRENCY>{ data($pagoMultipleRecaudoRequestIN/ns0:AGREEMENTS/ns0:AGREEMENT[1]/ns0:DEBTORS/ns0:DEBTOR[1]/ns0:BILLS/ns0:BILL[1]/ns0:PAYMENT_INFORMATION/ns0:PAYMENT_CURRENCY) }</PAYMENT_CURRENCY>
                {
                    for $PAYMENT_AMOUNT in $pagoMultipleRecaudoRequestIN/ns0:AGREEMENTS/ns0:AGREEMENT[1]/ns0:DEBTORS/ns0:DEBTOR[1]/ns0:BILLS/ns0:BILL[1]/ns0:PAYMENT_INFORMATION/ns0:PAYMENT_AMOUNT
                    return
                        <PAYMENT_AMOUNT>{ data($PAYMENT_AMOUNT) }</PAYMENT_AMOUNT>
                }
                {
                    for $DEBIT_ACCOUNT in $pagoMultipleRecaudoRequestIN/ns0:AGREEMENTS/ns0:AGREEMENT[1]/ns0:DEBTORS/ns0:DEBTOR[1]/ns0:BILLS/ns0:BILL[1]/ns0:PAYMENT_INFORMATION/ns0:DEBIT_ACCOUNT
                    return
                        <DEBIT_ACCOUNT>{ data($DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
                }
                {
                    for $CHEQUE_NUMBER in $pagoMultipleRecaudoRequestIN/ns0:AGREEMENTS/ns0:AGREEMENT[1]/ns0:DEBTORS/ns0:DEBTOR[1]/ns0:BILLS/ns0:BILL[1]/ns0:PAYMENT_INFORMATION/ns0:CHEQUE_NUMBER
                    return
                        <CHEQUE_NUMBER>{ data($CHEQUE_NUMBER) }</CHEQUE_NUMBER>
                }
                {
                    for $BANK_CODE in $pagoMultipleRecaudoRequestIN/ns0:AGREEMENTS/ns0:AGREEMENT[1]/ns0:DEBTORS/ns0:DEBTOR[1]/ns0:BILLS/ns0:BILL[1]/ns0:PAYMENT_INFORMATION/ns0:BANK_CODE
                    return
                        <BANK_CODE>{ data($BANK_CODE) }</BANK_CODE>
                }
                {
                    for $CREDIT_CARD_NUMBER in $pagoMultipleRecaudoRequestIN/ns0:AGREEMENTS/ns0:AGREEMENT[1]/ns0:DEBTORS/ns0:DEBTOR[1]/ns0:BILLS/ns0:BILL[1]/ns0:PAYMENT_INFORMATION/ns0:CREDIT_CARD_NUMBER
                    return
                        <CREDIT_CARD_NUMBER>{ data($CREDIT_CARD_NUMBER) }</CREDIT_CARD_NUMBER>
                }
                {
                    for $EXPIRATION_DATE in $pagoMultipleRecaudoRequestIN/ns0:AGREEMENTS/ns0:AGREEMENT[1]/ns0:DEBTORS/ns0:DEBTOR[1]/ns0:BILLS/ns0:BILL[1]/ns0:PAYMENT_INFORMATION/ns0:EXPIRATION_DATE
                    return
                        <EXPIRATION_DATE>{ data($EXPIRATION_DATE) }</EXPIRATION_DATE>
                }
            </PAYMENT_INFORMATION>
            <BILL_INFORMATION>
                {
                    for $BILL_NUMBER in $pagoMultipleRecaudoRequestIN/ns0:AGREEMENTS/ns0:AGREEMENT[1]/ns0:DEBTORS/ns0:DEBTOR[1]/ns0:BILLS/ns0:BILL[1]/ns0:BILL_NUMBER
                    return
                        <BILL_NUMBER>{ data($BILL_NUMBER) }</BILL_NUMBER>
                }
                {
                    for $DUE_DATE in $pagoMultipleRecaudoRequestIN/ns0:AGREEMENTS/ns0:AGREEMENT[1]/ns0:DEBTORS/ns0:DEBTOR[1]/ns0:BILLS/ns0:BILL[1]/ns0:DUE_DATE
                    return
                        <DUE_DATE>{ data($DUE_DATE) }</DUE_DATE>
                }
            </BILL_INFORMATION>
            {
                for $EXTENDED_COLLECTION_YES_NO in $pagoMultipleRecaudoRequestIN/ns0:AGREEMENTS/ns0:AGREEMENT[1]/ns0:DEBTORS/ns0:DEBTOR[1]/ns0:BILLS/ns0:BILL[1]/ns0:EXTENDED_COLLECTION_YES_NO
                return
                    <EXTENDED_COLLECTION_YES_NO>{ data($EXTENDED_COLLECTION_YES_NO) }</EXTENDED_COLLECTION_YES_NO>
            }
            {
                for $DEALSLIP_PICKUP_BRANCH in $pagoMultipleRecaudoRequestIN/ns0:AGREEMENTS/ns0:AGREEMENT[1]/ns0:DEBTORS/ns0:DEBTOR[1]/ns0:BILLS/ns0:BILL[1]/ns0:DEALSLIP_PICKUP_BRANCH
                return
                    <DEALSLIP_PICKUP_BRANCH>{ data($DEALSLIP_PICKUP_BRANCH) }</DEALSLIP_PICKUP_BRANCH>
            }
            <ADDITIONAL_INFO>
                {
                    for $DATA in $pagoMultipleRecaudoRequestIN/ns0:AGREEMENTS/ns0:AGREEMENT[1]/ns0:DEBTORS/ns0:DEBTOR[1]/ns0:BILLS/ns0:BILL[1]/ns0:ADDITIONAL_INFO/ns0:DATA
                    return
                        <DATA>{ data($DATA) }</DATA>
                }
            </ADDITIONAL_INFO>
        </ns1:pagoRecaudo>
};


declare variable $pagoMultipleRecaudoRequestIN as element(ns0:pagoMultipleRecaudoRequest) external;

xf:pagoRecaudoIn($pagoMultipleRecaudoRequestIN)