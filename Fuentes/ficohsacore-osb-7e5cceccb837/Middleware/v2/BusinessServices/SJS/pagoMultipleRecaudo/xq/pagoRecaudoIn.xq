(:: pragma  parameter="$agreement" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:pagoRecaudo" location="../../../../Resources/PagoRecaudo/xsd/pagoRecaudoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/pagoMultipleRecaudo/xq/pagoRecaudoIn/";

declare function xf:pagoRecaudoIn($agreement as element(*))
    as element(ns0:pagoRecaudo) {
        <ns0:pagoRecaudo>
            <CONTRACT_ID>{ data($agreement/CONTRACT_ID) }</CONTRACT_ID>
            <DEBTOR_CODE>{ data($agreement/DEBTOR_CODE) }</DEBTOR_CODE>
            <DEBTOR_NAME>{ data($agreement/DEBTOR_NAME) }</DEBTOR_NAME>
            <PAYMENT_INFORMATION>
                <PAYMENT_METHOD>{ data($agreement/PAYMENT_INFORMATION/PAYMENT_METHOD) }</PAYMENT_METHOD>
                <PAYMENT_CURRENCY>{ data($agreement/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</PAYMENT_CURRENCY>
                <PAYMENT_AMOUNT>{ data($agreement/PAYMENT_INFORMATION/PAYMENT_AMOUNT) }</PAYMENT_AMOUNT>
                <DEBIT_ACCOUNT>{ data($agreement/PAYMENT_INFORMATION/DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
                <CHEQUE_NUMBER>{ data($agreement/PAYMENT_INFORMATION/CHEQUE_NUMBER) }</CHEQUE_NUMBER>
                <BANK_CODE>{ data($agreement/PAYMENT_INFORMATION/BANK_CODE) }</BANK_CODE>
                <CREDIT_CARD_NUMBER>{ data($agreement/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER) }</CREDIT_CARD_NUMBER>
                <EXPIRATION_DATE>{ data($agreement/PAYMENT_INFORMATION/EXPIRATION_DATE) }</EXPIRATION_DATE>
            </PAYMENT_INFORMATION>
            <BILL_INFORMATION>
                <BILL_NUMBER>{ data($agreement/BILL_INFORMATION/BILL_NUMBER) }</BILL_NUMBER>
                <DUE_DATE>{ data($agreement/BILL_INFORMATION/DUE_DATE) }</DUE_DATE>
            </BILL_INFORMATION>
            <EXTENDED_COLLECTION_YES_NO>{ data($agreement/EXTENDED_COLLECTION_YES_NO) }</EXTENDED_COLLECTION_YES_NO>
            <DEALSLIP_PICKUP_BRANCH>{ data($agreement/DEALSLIP_PICKUP_BRANCH) }</DEALSLIP_PICKUP_BRANCH>
            <ADDITIONAL_INFO>
            	{
            	for $DATA in $agreement/ADDITIONAL_INFO/DATA
            	return 
                <DATA>{ data($DATA) }</DATA>
                }
            </ADDITIONAL_INFO>
        </ns0:pagoRecaudo>
};

declare variable $agreement as element(*) external;

xf:pagoRecaudoIn($agreement)