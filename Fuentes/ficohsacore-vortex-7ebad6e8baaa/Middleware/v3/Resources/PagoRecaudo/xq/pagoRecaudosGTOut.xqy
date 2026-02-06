xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ABKGT/PagoRecaudo/xsd/PagoRecaudo_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters2" element="ns0:OutputParameters" location="../../../BusinessServices/ABKGT/ConsultarRelacionOpRecaudo/xsd/consultarRelacionOperacionRecaudo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:pagoRecaudoResponse" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/PagoRecaudo";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarRelacionOperacionRecaudo";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoRecaudo/xq/pagoRecaudosGTOut/";

declare function xf:pagoRecaudosGTOut($outputParameters1 as element(ns1:OutputParameters),
    $outputParameters2 as element(ns0:OutputParameters),
    $PaymentMethod as xs:string)
    as element(ns2:pagoRecaudoResponse) {
        <ns2:pagoRecaudoResponse>
            {
                for $PV_CONTRACT_NAME in $outputParameters1/ns1:PV_CONTRACT_NAME
                return
                    <CONTRACT_NAME>{ data($PV_CONTRACT_NAME) }</CONTRACT_NAME>
            }
            {
                let $result :=
                    for $CODIGO_FACTURA_ITEM in $outputParameters2/ns0:LISTA_VALORES/ns0:CODIGO_FACTURA_ITEM
                    return
                        <DEBTOR_NAME>{ data($CODIGO_FACTURA_ITEM) }</DEBTOR_NAME>
                return
                    $result[1]
            }
            {
                for $PV_INPUTTER in $outputParameters1/ns1:PV_INPUTTER
                return
                    <INPUTTER>{ data($PV_INPUTTER) }</INPUTTER>
            }
            {
                for $PV_DATE_TIME in $outputParameters1/ns1:PV_DATE_TIME
                return
                    <DATE_TIME>{ data($PV_DATE_TIME) }</DATE_TIME>
            }
            {
                for $PV_BRANCH_NAME in $outputParameters1/ns1:PV_BRANCH_NAME
                return
                    <BRANCH_NAME>{ data($PV_BRANCH_NAME) }</BRANCH_NAME>
            }
            <PAYMENT_INFORMATION>
                <PAYMENT_METHOD>{ $PaymentMethod }</PAYMENT_METHOD>
                <PAYMENT_CURRENCY>{ data($outputParameters1/ns1:PV_PAYMENT_CURRENCY_OUT) }</PAYMENT_CURRENCY>
                {
                    for $PV_PAYMENT_AMOUNT_OUT in $outputParameters1/ns1:PV_PAYMENT_AMOUNT_OUT
                    return
                        <PAYMENT_AMOUNT>{ data($PV_PAYMENT_AMOUNT_OUT) }</PAYMENT_AMOUNT>
                }
                {
                    for $PV_DEBIT_ACCOUNT_OUT in $outputParameters1/ns1:PV_DEBIT_ACCOUNT_OUT
                    return
                        <DEBIT_ACCOUNT>{ data($PV_DEBIT_ACCOUNT_OUT) }</DEBIT_ACCOUNT>
                }
                {
                    for $PV_CHEQUE_NUMBER_OUT in $outputParameters1/ns1:PV_CHEQUE_NUMBER_OUT
                    return
                        <CHEQUE_NUMBER>{ data($PV_CHEQUE_NUMBER_OUT) }</CHEQUE_NUMBER>
                }
                {
                    for $PV_BANK_CODE_OUT in $outputParameters1/ns1:PV_BANK_CODE_OUT
                    return
                        <BANK_CODE>{ data($PV_BANK_CODE_OUT) }</BANK_CODE>
                }
                {
                    for $PV_CREDIT_CARD_NUMBER_OUT in $outputParameters1/ns1:PV_CREDIT_CARD_NUMBER_OUT
                    return
                        <CREDIT_CARD_NUMBER>{ data($PV_CREDIT_CARD_NUMBER_OUT) }</CREDIT_CARD_NUMBER>
                }
                {
                    for $PV_EXPIRATION_DATE_OUT in $outputParameters1/ns1:PV_EXPIRATION_DATE_OUT
                    return
                        <EXPIRATION_DATE>{ data($PV_EXPIRATION_DATE_OUT) }</EXPIRATION_DATE>
                }
            </PAYMENT_INFORMATION>
            {
                for $PV_BILL_DETAIL_OUT in $outputParameters1/ns1:PV_BILL_DETAIL_OUT
                return
                    <BILL_DETAIL>{ data($PV_BILL_DETAIL_OUT) }</BILL_DETAIL>
            }
        </ns2:pagoRecaudoResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;
declare variable $outputParameters2 as element(ns0:OutputParameters) external;
declare variable $PaymentMethod as xs:string external;

xf:pagoRecaudosGTOut($outputParameters1,
    $outputParameters2,
    $PaymentMethod)