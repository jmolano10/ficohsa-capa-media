(:: pragma bea:global-element-parameter parameter="$pagoRecaudo1" element="ns0:pagoRecaudo" location="../xsd/pagoRecaudoCBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudoCB/xq/PagoRecaudoCBInn/";

declare function xf:PagoRecaudoCBInn($pagoRecaudo1 as element(ns0:pagoRecaudo))
    as element(ns0:pagoRecaudo) {
        <ns0:pagoRecaudo>
            <CONTRACT_ID>{ data($pagoRecaudo1/CONTRACT_ID) }</CONTRACT_ID>
            <DEBTOR_CODE>{ data($pagoRecaudo1/DEBTOR_CODE) }</DEBTOR_CODE>
            <DEBTOR_NAME>{ data($pagoRecaudo1/DEBTOR_NAME) }</DEBTOR_NAME>
            <PAYMENT_INFORMATION>
                <PAYMENT_METHOD>{ data($pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_METHOD) }</PAYMENT_METHOD>
                <PAYMENT_CURRENCY>{ data($pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</PAYMENT_CURRENCY>
                <PAYMENT_AMOUNT>{ data($pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_AMOUNT) }</PAYMENT_AMOUNT>
                <DEBIT_ACCOUNT>{ data($pagoRecaudo1/PAYMENT_INFORMATION/DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
                <CHEQUE_NUMBER>{ data($pagoRecaudo1/PAYMENT_INFORMATION/CHEQUE_NUMBER) }</CHEQUE_NUMBER>
                <BANK_CODE>{ data($pagoRecaudo1/PAYMENT_INFORMATION/BANK_CODE) }</BANK_CODE>
                <CREDIT_CARD_NUMBER>{ data($pagoRecaudo1/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER) }</CREDIT_CARD_NUMBER>
                <EXPIRATION_DATE>{ data($pagoRecaudo1/PAYMENT_INFORMATION/EXPIRATION_DATE) }</EXPIRATION_DATE>
            </PAYMENT_INFORMATION>
            <BILL_INFORMATION>
                <BILL_NUMBER>{ data($pagoRecaudo1/BILL_INFORMATION/BILL_NUMBER) }</BILL_NUMBER>
                <DUE_DATE>{ data($pagoRecaudo1/BILL_INFORMATION/DUE_DATE) }</DUE_DATE>
            </BILL_INFORMATION>
            <EXTENDED_COLLECTION_YES_NO>{ data($pagoRecaudo1/EXTENDED_COLLECTION_YES_NO) }</EXTENDED_COLLECTION_YES_NO>
            <DEALSLIP_PICKUP_BRANCH>{ data($pagoRecaudo1/DEALSLIP_PICKUP_BRANCH) }</DEALSLIP_PICKUP_BRANCH>
            <ADDITIONAL_INFO>
                {
                    for $info in $pagoRecaudo1/ADDITIONAL_INFO/DATA
                    return
                        <DATA>{ data($info) } </DATA>
                }
            </ADDITIONAL_INFO>
        </ns0:pagoRecaudo>
};

declare variable $pagoRecaudo1 as element(ns0:pagoRecaudo) external;

xf:PagoRecaudoCBInn($pagoRecaudo1)
