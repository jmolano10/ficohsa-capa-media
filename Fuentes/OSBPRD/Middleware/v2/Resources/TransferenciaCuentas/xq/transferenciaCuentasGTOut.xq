(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../xsd/transferenciaCuentasType.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transferenciaCuentasResponse" location="../../../../Business_Resources/Transferencias/TransferenciasEntreCuentas/transferenciaCuentasType.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/TransferenciaCuentas";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/transferenciaCuentas/xq/transferenciaCuentasOut/";

declare function xf:transferenciaCuentasOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:transferenciaCuentasResponse) {
        <ns1:transferenciaCuentasResponse>
            {
                for $DEBIT_ACCOUNT in $outputParameters1/ns0:DEBIT_ACCOUNT
                return
                    <DEBIT_ACCOUNT>{ data($DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
            }
            {
                for $CREDIT_ACCOUNT in $outputParameters1/ns0:CREDIT_ACCOUNT
                return
                    <CREDIT_ACCOUNT>{ data($CREDIT_ACCOUNT) }</CREDIT_ACCOUNT>
            }
            {
                for $DEBIT_CUSTOMER in $outputParameters1/ns0:DEBIT_CUSTOMER
                return
                    <DEBIT_CUSTOMER>{ data($DEBIT_CUSTOMER) }</DEBIT_CUSTOMER>
            }
            {
                for $CREDIT_CUSTOMER in $outputParameters1/ns0:CREDIT_CUSTOMER
                return
                    <CREDIT_CUSTOMER>{ data($CREDIT_CUSTOMER) }</CREDIT_CUSTOMER>
            }
            {
                for $DEBIT_CURRENCY in $outputParameters1/ns0:DEBIT_CURRENCY
                return
                    <DEBIT_CURRENCY>{ data($DEBIT_CURRENCY) }</DEBIT_CURRENCY>
            }
            {
                for $CREDIT_CURRENCY in $outputParameters1/ns0:CREDIT_CURRENCY
                return
                    <CREDIT_CURRENCY>{ data($CREDIT_CURRENCY) }</CREDIT_CURRENCY>
            }
            {
                for $DEBIT_AMOUNT in $outputParameters1/ns0:DEBIT_AMOUNT
                return
                    <DEBIT_AMOUNT>{ data($DEBIT_AMOUNT) }</DEBIT_AMOUNT>
            }
            {
                for $CREDIT_AMOUNT in $outputParameters1/ns0:CREDIT_AMOUNT
                return
                    <CREDIT_AMOUNT>{ data($CREDIT_AMOUNT) }</CREDIT_AMOUNT>
            }
            {
                for $TRANSFER_DETAILS in $outputParameters1/ns0:TRANSFER_DETAILS
                return
                    <TRANSFER_DETAILS>{ data($TRANSFER_DETAILS) }</TRANSFER_DETAILS>
            }
            {
                for $EXCHANGE_RATE in $outputParameters1/ns0:EXCHANGE_RATE
                return
                    <EXCHANGE_RATE>{ data($EXCHANGE_RATE) }</EXCHANGE_RATE>
            }
            {
                for $VALUE_DATE in $outputParameters1/ns0:VALUE_DATE
                return
                    <DATE_TIME>{ data($VALUE_DATE) }</DATE_TIME>
            }
        </ns1:transferenciaCuentasResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:transferenciaCuentasOut($outputParameters1)