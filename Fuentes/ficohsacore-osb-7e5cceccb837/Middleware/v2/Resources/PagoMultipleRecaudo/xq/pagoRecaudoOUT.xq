(:: pragma bea:global-element-parameter parameter="$responseHeaderOUT" element="ns2:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudoResponseOUT" element="ns1:pagoRecaudoResponse" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoMultipleRecaudoRequest1" element="ns0:pagoMultipleRecaudoRequest" location="../xsd/pagoMultipleRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoMultipleRecaudoResponse" location="../xsd/pagoMultipleRecaudoTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoMultipleRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoMultipleRecaudo/xq/pagoRecaudoOUT/";

declare function xf:pagoRecaudoOUT($responseHeaderOUT as element(ns2:ResponseHeader),
    $pagoRecaudoResponseOUT as element(ns1:pagoRecaudoResponse),
    $pagoMultipleRecaudoRequest1 as element(ns0:pagoMultipleRecaudoRequest))
    as element(ns0:pagoMultipleRecaudoResponse) {
        <ns0:pagoMultipleRecaudoResponse>
            <ns0:AGREEMENTS>
                <ns0:AGREEMENT>
                    {
                        for $CONTRACT_ID in $pagoMultipleRecaudoRequest1/ns0:AGREEMENTS/ns0:AGREEMENT[1]/ns0:CONTRACT_ID
                        return
                            <ns0:CONTRACT_ID>{ data($CONTRACT_ID) }</ns0:CONTRACT_ID>
                    }
                    {
                        for $CONTRACT_NAME in $pagoRecaudoResponseOUT/CONTRACT_NAME
                        return
                            <ns0:CONTRACT_NAME>{ data($CONTRACT_NAME) }</ns0:CONTRACT_NAME>
                    }
                    {
                        for $INPUTTER in $pagoRecaudoResponseOUT/INPUTTER
                        return
                            <ns0:INPUTTER>{ data($INPUTTER) }</ns0:INPUTTER>
                    }
                    {
                        for $BRANCH_NAME in $pagoRecaudoResponseOUT/BRANCH_NAME
                        return
                            <ns0:BRANCH_NAME>{ data($BRANCH_NAME) }</ns0:BRANCH_NAME>
                    }
                    <ns0:DEBTORS>
                        <ns0:DEBTOR>
                            <ns0:DEBTOR_CODE>{ data($pagoMultipleRecaudoRequest1/ns0:AGREEMENTS/ns0:AGREEMENT[1]/ns0:DEBTORS/ns0:DEBTOR[1]/ns0:DEBTOR_CODE) }</ns0:DEBTOR_CODE>
                            {
                                for $DEBTOR_NAME in $pagoRecaudoResponseOUT/DEBTOR_NAME
                                return
                                    <ns0:DEBTOR_NAME>{ data($DEBTOR_NAME) }</ns0:DEBTOR_NAME>
                            }
                            <ns0:BILLS>
                                <ns0:BILL>
                                    {
                                        for $BILL_NUMBER in $pagoMultipleRecaudoRequest1/ns0:AGREEMENTS/ns0:AGREEMENT[1]/ns0:DEBTORS/ns0:DEBTOR[1]/ns0:BILLS/ns0:BILL[1]/ns0:BILL_NUMBER
                                        return
                                            <ns0:BILL_NUMBER>{ data($BILL_NUMBER) }</ns0:BILL_NUMBER>
                                    }
                                    <ns0:SUCCESS_INDICATOR>{ data($responseHeaderOUT/successIndicator) }</ns0:SUCCESS_INDICATOR>
                                    {
                                        let $result :=
                                            for $messages in $responseHeaderOUT/messages
                                            return
                                                <ns0:ERROR_MESSAGE>{ data($messages) }</ns0:ERROR_MESSAGE>
                                        return
                                            $result[1]
                                    }
                                    {
                                        for $transactionId in $responseHeaderOUT/transactionId
                                        return
                                            <ns0:TRANSACTION_ID>{ data($transactionId) }</ns0:TRANSACTION_ID>
                                    }
                                    {
                                        for $DATE_TIME in $pagoRecaudoResponseOUT/DATE_TIME
                                        return
                                            <ns0:DATE_TIME>{ data($DATE_TIME) }</ns0:DATE_TIME>
                                    }
                                    <ns0:PAYMENT_INFORMATION>
                                        <ns0:PAYMENT_METHOD>{ data($pagoRecaudoResponseOUT/PAYMENT_INFORMATION/PAYMENT_METHOD) }</ns0:PAYMENT_METHOD>
                                        <ns0:PAYMENT_CURRENCY>{ data($pagoRecaudoResponseOUT/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</ns0:PAYMENT_CURRENCY>
                                        {
                                            for $PAYMENT_AMOUNT in $pagoRecaudoResponseOUT/PAYMENT_INFORMATION/PAYMENT_AMOUNT
                                            return
                                                <ns0:PAYMENT_AMOUNT>{ data($PAYMENT_AMOUNT) }</ns0:PAYMENT_AMOUNT>
                                        }
                                        {
                                            for $DEBIT_ACCOUNT in $pagoRecaudoResponseOUT/PAYMENT_INFORMATION/DEBIT_ACCOUNT
                                            return
                                                <ns0:DEBIT_ACCOUNT>{ data($DEBIT_ACCOUNT) }</ns0:DEBIT_ACCOUNT>
                                        }
                                        {
                                            for $CHEQUE_NUMBER in $pagoRecaudoResponseOUT/PAYMENT_INFORMATION/CHEQUE_NUMBER
                                            return
                                                <ns0:CHEQUE_NUMBER>{ data($CHEQUE_NUMBER) }</ns0:CHEQUE_NUMBER>
                                        }
                                        {
                                            for $BANK_CODE in $pagoRecaudoResponseOUT/PAYMENT_INFORMATION/BANK_CODE
                                            return
                                                <ns0:BANK_CODE>{ data($BANK_CODE) }</ns0:BANK_CODE>
                                        }
                                        {
                                            for $CREDIT_CARD_NUMBER in $pagoRecaudoResponseOUT/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER
                                            return
                                                <ns0:CREDIT_CARD_NUMBER>{ data($CREDIT_CARD_NUMBER) }</ns0:CREDIT_CARD_NUMBER>
                                        }
                                        {
                                            for $EXPIRATION_DATE in $pagoRecaudoResponseOUT/PAYMENT_INFORMATION/EXPIRATION_DATE
                                            return
                                                <ns0:EXPIRATION_DATE>{ data($EXPIRATION_DATE) }</ns0:EXPIRATION_DATE>
                                        }
                                    </ns0:PAYMENT_INFORMATION>
                                    {
                                        for $BILL_DETAIL in $pagoRecaudoResponseOUT/BILL_DETAIL
                                        return
                                            <ns0:BILL_DETAIL>{ data($BILL_DETAIL) }</ns0:BILL_DETAIL>
                                    }
                                </ns0:BILL>
                            </ns0:BILLS>
                        </ns0:DEBTOR>
                    </ns0:DEBTORS>
                </ns0:AGREEMENT>
            </ns0:AGREEMENTS>
        </ns0:pagoMultipleRecaudoResponse>
};

declare variable $responseHeaderOUT as element(ns2:ResponseHeader) external;
declare variable $pagoRecaudoResponseOUT as element(ns1:pagoRecaudoResponse) external;
declare variable $pagoMultipleRecaudoRequest1 as element(ns0:pagoMultipleRecaudoRequest) external;

xf:pagoRecaudoOUT($responseHeaderOUT,
    $pagoRecaudoResponseOUT,
    $pagoMultipleRecaudoRequest1)