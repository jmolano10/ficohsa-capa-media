(:: pragma bea:global-element-parameter parameter="$pagoMultipleRecaudoRequest" element="ns1:pagoMultipleRecaudoRequest" location="../xsd/pagoMultipleRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns2:sjPagoMultipleRecaudo" location="../../../BusinessServices/SJS/pagoMultipleRecaudo/xsd/sjPagoMultipleRecaudo.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/sjPagoMultipleRecaudo";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoMultipleRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoMultipleRecaudo/xq/pagoMultipleRecaudoIn/";

declare function xf:pagoMultipleRecaudoIn($pagoMultipleRecaudoRequest as element(ns1:pagoMultipleRecaudoRequest),
    $requestHeader as element(ns0:RequestHeader))
    as element(ns2:sjPagoMultipleRecaudo) {
        <ns2:sjPagoMultipleRecaudo>
            <USERNAME>{ data($requestHeader/Authentication/UserName) }</USERNAME>
            <PASSWORD>{ data($requestHeader/Authentication/Password) }</PASSWORD>
            <SOURCE_BANK>{ data($requestHeader/Region/SourceBank) }</SOURCE_BANK>
            <DESTINATION_BANK>{ data($requestHeader/Region/DestinationBank) }</DESTINATION_BANK>
            {
                let $AGREEMENTS := $pagoMultipleRecaudoRequest/ns1:AGREEMENTS
                return
                    <AGREEMENTS>
                        {
                            for $AGREEMENT in $AGREEMENTS/ns1:AGREEMENT
                            return
                                <AGREEMENT>
                                    {
                                        for $CONTRACT_ID in $AGREEMENT/ns1:CONTRACT_ID
                                        return
                                            <CONTRACT_ID>{ data($CONTRACT_ID) }</CONTRACT_ID>
                                    }
                                    {
                                        let $DEBTORS := $AGREEMENT/ns1:DEBTORS
                                        return
                                            <DEBTORS>
                                                {
                                                    for $DEBTOR in $DEBTORS/ns1:DEBTOR
                                                    return
                                                        <DEBTOR>
                                                            <DEBTOR_CODE>{ data($DEBTOR/ns1:DEBTOR_CODE) }</DEBTOR_CODE>
                                                            {
                                                                for $DEBTOR_NAME in $DEBTOR/ns1:DEBTOR_NAME
                                                                return
                                                                    <DEBTOR_NAME>{ data($DEBTOR_NAME) }</DEBTOR_NAME>
                                                            }
                                                            {
                                                                let $BILLS := $DEBTOR/ns1:BILLS
                                                                return
                                                                    <BILLS>
                                                                        {
                                                                            for $BILL in $BILLS/ns1:BILL
                                                                            return
                                                                                <BILL>
                                                                                    {
                                                                                        for $BILL_NUMBER in $BILL/ns1:BILL_NUMBER
                                                                                        return
                                                                                            <BILL_NUMBER>{ data($BILL_NUMBER) }</BILL_NUMBER>
                                                                                    }
                                                                                    {
                                                                                        for $DUE_DATE in $BILL/ns1:DUE_DATE
                                                                                        return
                                                                                            <DUE_DATE>{ data($DUE_DATE) }</DUE_DATE>
                                                                                    }
                                                                                    {
                                                                                        let $PAYMENT_INFORMATION := $BILL/ns1:PAYMENT_INFORMATION
                                                                                        return
                                                                                            <PAYMENT_INFORMATION>
                                                                                                <PAYMENT_METHOD>{ data($PAYMENT_INFORMATION/ns1:PAYMENT_METHOD) }</PAYMENT_METHOD>
                                                                                                <PAYMENT_CURRENCY>{ data($PAYMENT_INFORMATION/ns1:PAYMENT_CURRENCY) }</PAYMENT_CURRENCY>
                                                                                                {
                                                                                                    for $PAYMENT_AMOUNT in $PAYMENT_INFORMATION/ns1:PAYMENT_AMOUNT
                                                                                                    return
                                                                                                        <PAYMENT_AMOUNT>{ data($PAYMENT_AMOUNT) }</PAYMENT_AMOUNT>
                                                                                                }
                                                                                                {
                                                                                                    for $DEBIT_ACCOUNT in $PAYMENT_INFORMATION/ns1:DEBIT_ACCOUNT
                                                                                                    return
                                                                                                        <DEBIT_ACCOUNT>{ data($DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
                                                                                                }
                                                                                                {
                                                                                                    for $CHEQUE_NUMBER in $PAYMENT_INFORMATION/ns1:CHEQUE_NUMBER
                                                                                                    return
                                                                                                        <CHEQUE_NUMBER>{ data($CHEQUE_NUMBER) }</CHEQUE_NUMBER>
                                                                                                }
                                                                                                {
                                                                                                    for $BANK_CODE in $PAYMENT_INFORMATION/ns1:BANK_CODE
                                                                                                    return
                                                                                                        <BANK_CODE>{ data($BANK_CODE) }</BANK_CODE>
                                                                                                }
                                                                                                {
                                                                                                    for $CREDIT_CARD_NUMBER in $PAYMENT_INFORMATION/ns1:CREDIT_CARD_NUMBER
                                                                                                    return
                                                                                                        <CREDIT_CARD_NUMBER>{ data($CREDIT_CARD_NUMBER) }</CREDIT_CARD_NUMBER>
                                                                                                }
                                                                                                {
                                                                                                    for $EXPIRATION_DATE in $PAYMENT_INFORMATION/ns1:EXPIRATION_DATE
                                                                                                    return
                                                                                                        <EXPIRATION_DATE>{ data($EXPIRATION_DATE) }</EXPIRATION_DATE>
                                                                                                }
                                                                                            </PAYMENT_INFORMATION>
                                                                                    }
                                                                                    {
                                                                                        for $EXTENDED_COLLECTION_YES_NO in $BILL/ns1:EXTENDED_COLLECTION_YES_NO
                                                                                        return
                                                                                            <EXTENDED_COLLECTION_YES_NO>{ data($EXTENDED_COLLECTION_YES_NO) }</EXTENDED_COLLECTION_YES_NO>
                                                                                    }
                                                                                    {
                                                                                        for $DEALSLIP_PICKUP_BRANCH in $BILL/ns1:DEALSLIP_PICKUP_BRANCH
                                                                                        return
                                                                                            <DEALSLIP_PICKUP_BRANCH>{ data($DEALSLIP_PICKUP_BRANCH) }</DEALSLIP_PICKUP_BRANCH>
                                                                                    }
                                                                                    {
                                                                                        for $ADDITIONAL_INFO in $BILL/ns1:ADDITIONAL_INFO
                                                                                        return
                                                                                            <ADDITIONAL_INFO>
                                                                                                {
                                                                                                    for $DATA in $ADDITIONAL_INFO/ns1:DATA
                                                                                                    return
                                                                                                        <DATA>{ data($DATA) }</DATA>
                                                                                                }
                                                                                            </ADDITIONAL_INFO>
                                                                                    }
                                                                                </BILL>
                                                                        }
                                                                    </BILLS>
                                                            }
                                                        </DEBTOR>
                                                }
                                            </DEBTORS>
                                    }
                                </AGREEMENT>
                        }
                    </AGREEMENTS>
            }
        </ns2:sjPagoMultipleRecaudo>
};

declare variable $pagoMultipleRecaudoRequest as element(ns1:pagoMultipleRecaudoRequest) external;
declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:pagoMultipleRecaudoIn($pagoMultipleRecaudoRequest,
    $requestHeader)