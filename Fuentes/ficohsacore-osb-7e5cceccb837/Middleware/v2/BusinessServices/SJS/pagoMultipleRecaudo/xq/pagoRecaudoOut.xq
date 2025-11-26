(:: pragma bea:global-element-parameter parameter="$responseHeader1" element="ns0:ResponseHeader" location="../../../../Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudoResponse" element="ns1:pagoRecaudoResponse" location="../../../../Resources/PagoRecaudo/xsd/pagoRecaudoTypes.xsd" ::)
(:: pragma  parameter="$agreement" type="anyType" ::)
(:: pragma bea:local-element-return type="ns2:sjPagoMultipleRecaudoResponse/AGREEMENTS/AGREEMENT" location="../xsd/sjPagoMultipleRecaudo.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/pagoMultipleRecaudo/xq/pagoRecaudoOut/";

declare function xf:pagoRecaudoOut($responseHeader1 as element(ns0:ResponseHeader),
    $pagoRecaudoResponse as element(ns1:pagoRecaudoResponse),
    $agreement as element(*))
    as element() {
        <AGREEMENT>
            {
                for $CONTRACT_ID in $agreement/CONTRACT_ID
                return
                    <CONTRACT_ID>{ data($CONTRACT_ID) }</CONTRACT_ID>
            }
            {
                for $CONTRACT_NAME in $pagoRecaudoResponse/CONTRACT_NAME
                return
                    <CONTRACT_NAME>{ data($CONTRACT_NAME) }</CONTRACT_NAME>
            }
            <DEBTOR_CODE>{ data($agreement/DEBTOR_CODE) }</DEBTOR_CODE>
            {
                for $DEBTOR_NAME in $pagoRecaudoResponse/DEBTOR_NAME
                return
                    <DEBTOR_NAME>{ data($DEBTOR_NAME) }</DEBTOR_NAME>
            }
            {
                for $INPUTTER in $pagoRecaudoResponse/INPUTTER
                return
                    <INPUTTER>{ data($INPUTTER) }</INPUTTER>
            }
            {
            	for $transactionID in $responseHeader1/transactionId
            	return
            		<TRANSACTION_ID>{ data($transactionID) }</TRANSACTION_ID>
            }
            {
                for $DATE_TIME in $pagoRecaudoResponse/DATE_TIME
                return
                    <DATE_TIME>{ data($DATE_TIME) }</DATE_TIME>
            }
            {
                for $BRANCH_NAME in $pagoRecaudoResponse/BRANCH_NAME
                return
                    <BRANCH_NAME>{ data($BRANCH_NAME) }</BRANCH_NAME>
            }
            {
                for $BILL_NUMBER in $agreement/BILL_INFORMATION/BILL_NUMBER
                return
                    <BILL_NUMBER>{ data($BILL_NUMBER) }</BILL_NUMBER>
            }
            {
                for $PAYMENT_INFORMATION in $pagoRecaudoResponse/PAYMENT_INFORMATION
                return
                    <PAYMENT_INFORMATION>
                        <PAYMENT_METHOD>{ data($PAYMENT_INFORMATION/PAYMENT_METHOD) }</PAYMENT_METHOD>
                        <PAYMENT_CURRENCY>{ data($PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</PAYMENT_CURRENCY>
                        {
                            for $PAYMENT_AMOUNT in $PAYMENT_INFORMATION/PAYMENT_AMOUNT
                            return
                                <PAYMENT_AMOUNT>{ data($PAYMENT_AMOUNT) }</PAYMENT_AMOUNT>
                        }
                        {
                            for $DEBIT_ACCOUNT in $PAYMENT_INFORMATION/DEBIT_ACCOUNT
                            return
                                <DEBIT_ACCOUNT>{ data($DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
                        }
                        {
                            for $CHEQUE_NUMBER in $PAYMENT_INFORMATION/CHEQUE_NUMBER
                            return
                                <CHEQUE_NUMBER>{ data($CHEQUE_NUMBER) }</CHEQUE_NUMBER>
                        }
                        {
                            for $BANK_CODE in $PAYMENT_INFORMATION/BANK_CODE
                            return
                                <BANK_CODE>{ data($BANK_CODE) }</BANK_CODE>
                        }
                        {
                            for $CREDIT_CARD_NUMBER in $PAYMENT_INFORMATION/CREDIT_CARD_NUMBER
                            return
                                <CREDIT_CARD_NUMBER>{ data($CREDIT_CARD_NUMBER) }</CREDIT_CARD_NUMBER>
                        }
                        {
                            for $EXPIRATION_DATE in $PAYMENT_INFORMATION/EXPIRATION_DATE
                            return
                                <EXPIRATION_DATE>{ data($EXPIRATION_DATE) }</EXPIRATION_DATE>
                        }
                        {
                            for $BILL_NUMBER in $agreement/BILL_INFORMATION/BILL_NUMBER
                            return
                                <BILL_NUMBER>{ data($BILL_NUMBER) }</BILL_NUMBER>
                        }
                    </PAYMENT_INFORMATION>
            }
            {
                for $BILL_DETAIL in $pagoRecaudoResponse/BILL_DETAIL
                return
                    <BILL_DETAIL>{ data($BILL_DETAIL) }</BILL_DETAIL>
            }
            <SUCCESS_INDICATOR>{ data($responseHeader1/successIndicator) }</SUCCESS_INDICATOR>
            {
                let $result :=
                    for $messages in $responseHeader1/messages
                    return
                        <ERROR_MESSAGE>{ data($messages) }</ERROR_MESSAGE>
                return
                    $result[1]
            }
        </AGREEMENT>
};

declare variable $responseHeader1 as element(ns0:ResponseHeader) external;
declare variable $pagoRecaudoResponse as element(ns1:pagoRecaudoResponse) external;
declare variable $agreement as element(*) external;

xf:pagoRecaudoOut($responseHeader1,
    $pagoRecaudoResponse,
    $agreement)