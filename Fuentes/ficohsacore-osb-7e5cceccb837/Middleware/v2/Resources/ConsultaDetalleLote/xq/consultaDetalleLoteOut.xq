(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/PMSV/consultaDetalleLote/xsd/consultaDetalleLote_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalleLoteResponse" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetalleLote";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleLote/xq/consultaDetalleLoteOut/";

declare function xf:consultaDetalleLoteOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaDetalleLoteResponse) {
        <ns1:consultaDetalleLoteResponse>
            <CUSTOMER_ID>{ data($outputParameters/ns0:CUSTOMER_ID) }</CUSTOMER_ID>
            <BANK_BATCH_ID>{ data($outputParameters/ns0:BANK_BATCH_ID) }</BANK_BATCH_ID>
            <CUSTOMER_NAME>{ data($outputParameters/ns0:CUSTOMER_NAME) }</CUSTOMER_NAME>
            <BATCH_TYPE>{ data($outputParameters/ns0:BATCH_TYPE) }</BATCH_TYPE>
            <BATCH_TYPE_DESC>{ data($outputParameters/ns0:BATCH_TYPE_DESC) }</BATCH_TYPE_DESC>
            <UPLOAD_DATE>{ fn:adjust-date-to-timezone(fn-bea:date-from-dateTime(data($outputParameters/ns0:UPLOAD_DATE)),()) }</UPLOAD_DATE>
            <APPLICATION_DATE>{ fn:adjust-dateTime-to-timezone(data($outputParameters/ns0:APPLICATION_DATE),()) }</APPLICATION_DATE>
            <NUMBER_OF_TRANSACTIONS>{ data($outputParameters/ns0:NUMBER_OF_TRANSACTIONS) }</NUMBER_OF_TRANSACTIONS>
            <NUMBER_OF_TRANSACTIONS_SUCCESS>{ data($outputParameters/ns0:NUMBER_OF_TRANSACTIONS_SUCCESS) }</NUMBER_OF_TRANSACTIONS_SUCCESS>
            <NUMBER_OF_TRANSACTIONS_ERROR>{ data($outputParameters/ns0:NUMBER_OF_TRANSACTIONS_ERROR) }</NUMBER_OF_TRANSACTIONS_ERROR>
            <TOTAL_AMOUNT>{ data($outputParameters/ns0:TOTAL_AMOUNT) }</TOTAL_AMOUNT>
            <TOTAL_AMOUNT_ERROR>{ data($outputParameters/ns0:TOTAL_AMOUNT_ERROR) }</TOTAL_AMOUNT_ERROR>
            <STATUS>{ data($outputParameters/ns0:STATUS) }</STATUS>
            <STATUS_DESC>{ data($outputParameters/ns0:STATUS_DESC) }</STATUS_DESC>
            <RECORDS_INFO>
                <INITIAL_RECORD>{ data($outputParameters/ns0:INITIAL_RECORD) }</INITIAL_RECORD>
                <RECORDS_RETURNED>{ data($outputParameters/ns0:RECORDS_RETURNED) }</RECORDS_RETURNED>
                <RECORD_TOTAL>{ data($outputParameters/ns0:RECORDS_TOTAL) }</RECORD_TOTAL>
            </RECORDS_INFO>
            <TRANSACTIONS>
                {
                let $IDS := $outputParameters/ns0:IDS/ns0:ITEM
                let $PAYMENT_TYPE := $outputParameters/ns0:PAYMENT_TYPE/ns0:ITEM
                let $PAYMENT_TYPE_DESC := $outputParameters/ns0:PAYMENT_TYPE_DESC/ns0:ITEM
                let $TXN_REFERENCES := $outputParameters/ns0:TXN_REFERENCES/ns0:ITEM
                let $DEBIT_ACCOUNTS := $outputParameters/ns0:DEBIT_ACCOUNTS/ns0:ITEM
                let $CREDIT_ACCOUNTS := $outputParameters/ns0:CREDIT_ACCOUNTS/ns0:ITEM
                let $DESTINATIONS_BANKS := $outputParameters/ns0:DESTINATIONS_BANKS/ns0:ITEM
                let $DESTINATIONS_BANKS_NAME := $outputParameters/ns0:DESTINATIONS_BANKS_DESC/ns0:ITEM
                let $AMOUNTS := $outputParameters/ns0:AMOUNTS/ns0:ITEM
                let $CREDIT_ACCOUNTS_TYPES := $outputParameters/ns0:CREDIT_ACCOUNTS_TYPES/ns0:ITEM
                let $BENEFICIARIES := $outputParameters/ns0:BENEFICIARIES/ns0:ITEM
                let $DOCUMENT_NUMBERS := $outputParameters/ns0:DOCUMENT_NUMBERS/ns0:ITEM
                let $SUPLIERS := $outputParameters/ns0:SUPLIER_ID/ns0:ITEM
                let $STATUSES := $outputParameters/ns0:STATUSES/ns0:ITEM
                let $STATUSES_DESC := $outputParameters/ns0:STATUSES_DESC/ns0:ITEM
                let $DESCRIPTIONS := $outputParameters/ns0:DESCRIPTIONS/ns0:ITEM
                let $WITHDRAWAL_BRANCH := $outputParameters/ns0:WITHDRAWAL_BRANCH/ns0:ITEM
                let $WITHDRAWAL_BRANCH_NAME := $outputParameters/ns0:WITHDRAWAL_BRANCH_NAME/ns0:ITEM
                let $EXTERNAL_REFERENCE := $outputParameters/ns0:EXTERNAL_REFERENCE/ns0:ITEM
                let $ERROR_CODES := $outputParameters/ns0:ERROR_CODES/ns0:ITEM
                let $ERROR_MESSAGES := $outputParameters/ns0:ERROR_MESSAGES/ns0:ITEM
                let $CREDIT_CURRENCY := $outputParameters/ns0:CREDIT_CURRENCY/ns0:ITEM
                let $CURRENCY := $outputParameters/ns0:CURRENCY/ns0:ITEM
                let $CONTRACT_NAME := $outputParameters/ns0:CONTRACT_NAME/ns0:ITEM
                let $DEBTOR_CODE := $outputParameters/ns0:DEBTOR_CODE/ns0:ITEM
                let $DEBTOR_NAME := $outputParameters/ns0:DEBTOR_NAME/ns0:ITEM
                let $BILL_DETAIL := $outputParameters/ns0:BILL_DETAIL/ns0:ITEM
                for $i in (1 to $outputParameters/ns0:RECORDS_RETURNED)
                return
                    <TRANSACTION>
                        <ID>{data($IDS[$i])}</ID>
                        <PAYMENT_TYPE>{data($PAYMENT_TYPE[$i])}</PAYMENT_TYPE>
                        <PAYMENT_TYPE_DESC>{data($PAYMENT_TYPE_DESC[$i])}</PAYMENT_TYPE_DESC>
                        <TXN_REFERENCE>{data($TXN_REFERENCES[$i])}</TXN_REFERENCE>
                        <DEBIT_ACCOUNT>{data($DEBIT_ACCOUNTS[$i])}</DEBIT_ACCOUNT>
                        <CREDIT_ACCOUNT>{data($CREDIT_ACCOUNTS[$i])}</CREDIT_ACCOUNT>
                        <DESTINATION_BANK>{data($DESTINATIONS_BANKS[$i])}</DESTINATION_BANK>
                        <DESTINATION_BANK_NAME>{ data($DESTINATIONS_BANKS_NAME[$i]) }</DESTINATION_BANK_NAME>
                        <CREDIT_CURRENCY>{ data($CREDIT_CURRENCY[$i]) }</CREDIT_CURRENCY>
                        <CURRENCY>{ data($CURRENCY[$i]) }</CURRENCY>
                        <AMOUNT>{data($AMOUNTS[$i])}</AMOUNT>
                        <CREDIT_ACCOUNT_TYPE>{data($CREDIT_ACCOUNTS_TYPES[$i])}</CREDIT_ACCOUNT_TYPE>
                        <BENEFICIARY>{data($BENEFICIARIES[$i])}</BENEFICIARY>
                        <DOCUMENT_NUMBER>{data($DOCUMENT_NUMBERS[$i])}</DOCUMENT_NUMBER>
                        <SUPPLIER_ID>{data($SUPLIERS[$i])}</SUPPLIER_ID>
                        <STATUS>{data($STATUSES[$i])}</STATUS>
                        <STATUS_DESC>{data($STATUSES_DESC[$i])}</STATUS_DESC>
                        <DESCRIPTION>{data($DESCRIPTIONS[$i])}</DESCRIPTION>
                        <WITHDRAWAL_BRANCH>{data($WITHDRAWAL_BRANCH[$i])}</WITHDRAWAL_BRANCH>
                        <WITHDRAWAL_BRANCH_NAME>{data($WITHDRAWAL_BRANCH_NAME[$i])}</WITHDRAWAL_BRANCH_NAME>
                        <EXTERNAL_REFERENCE>{data($EXTERNAL_REFERENCE[$i])}</EXTERNAL_REFERENCE>
                        <ERROR_CODE>{data($ERROR_CODES[$i])}</ERROR_CODE>
                        <ERROR_MESSAGE>{data($ERROR_MESSAGES[$i])}</ERROR_MESSAGE>
                        {
                            if($CONTRACT_NAME[$i] != '') then (
                                <BILL_INFO>
                                    <CONTRACT_NAME>{data($CONTRACT_NAME[$i])}</CONTRACT_NAME>              
                                    <DEBTOR_CODE>{data($DEBTOR_CODE[$i])}</DEBTOR_CODE>             
                                    <DEBTOR_NAME>{data($DEBTOR_NAME[$i])}</DEBTOR_NAME>
                                    <BILL_DETAIL>{data($BILL_DETAIL[$i])}</BILL_DETAIL> 
                                </BILL_INFO>
                            )
                            else()
                        }
                    </TRANSACTION>
                }
            </TRANSACTIONS>

        </ns1:consultaDetalleLoteResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaDetalleLoteOut($outputParameters)