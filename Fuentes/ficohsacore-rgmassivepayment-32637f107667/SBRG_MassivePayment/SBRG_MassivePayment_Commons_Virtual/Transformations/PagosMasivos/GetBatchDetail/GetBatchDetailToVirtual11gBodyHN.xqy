xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
(:: import schema at "../../../Schemas/PagosMasivos/pagosMasivosTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../../../../SBRG_MassivePayment_GetBatchDetail/Schemas/GetBatchDetailTypes.xsd" ::)

declare variable $responseService as element() (:: schema-element(ns1:getBatchDetailResponse) ::) external;

declare function local:func($responseService as element() (:: schema-element(ns1:getBatchDetailResponse) ::)) as element() (:: schema-element(ns2:consultaDetalleLoteResponse) ::) {
    <ns2:consultaDetalleLoteResponse>
        <CUSTOMER_ID>{fn:data($responseService/CustomerId)}</CUSTOMER_ID>
        <BANK_BATCH_ID>{fn:data($responseService/BankBatchId)}</BANK_BATCH_ID>
        <CUSTOMER_NAME>{fn:data($responseService/CustomerName)}</CUSTOMER_NAME>
        <BATCH_TYPE>{fn:data($responseService/BatchType)}</BATCH_TYPE>
        <BATCH_TYPE_DESC>{fn:data($responseService/BatchTypeDesc)}</BATCH_TYPE_DESC>
        <UPLOAD_DATE>{fn:data($responseService/UploadDate)}</UPLOAD_DATE>
        <APPLICATION_DATE>{fn:data($responseService/ApplicationDate)}</APPLICATION_DATE>
        <NUMBER_OF_TRANSACTIONS>{fn:data($responseService/NumberOfTransactions)}</NUMBER_OF_TRANSACTIONS>
        <NUMBER_OF_TRANSACTIONS_SUCCESS>{fn:data($responseService/NumberOfTransactionsSuccess)}</NUMBER_OF_TRANSACTIONS_SUCCESS>
        <NUMBER_OF_TRANSACTIONS_ERROR>{fn:data($responseService/NumberOfTransactionsError)}</NUMBER_OF_TRANSACTIONS_ERROR>
        <TOTAL_AMOUNT>{fn:data($responseService/TotalAmount)}</TOTAL_AMOUNT>
        <TOTAL_AMOUNT_ERROR>{fn:data($responseService/TotalAmountError)}</TOTAL_AMOUNT_ERROR>
        <STATUS>{fn:data($responseService/Status)}</STATUS>
        <STATUS_DESC>{fn:data($responseService/StatusDesc)}</STATUS_DESC>
        <RECORDS_INFO>
            <INITIAL_RECORD>{fn:data($responseService/PagingInfo/InitialRecord)}</INITIAL_RECORD>
            <RECORDS_RETURNED>{fn:data($responseService/PagingInfo/RecordsReturned)}</RECORDS_RETURNED>
            <RECORD_TOTAL>{fn:data($responseService/PagingInfo/RecordsTotal)}</RECORD_TOTAL></RECORDS_INFO>
        <TRANSACTIONS>
            {
                for $Transactions in $responseService/Transactions
                return 
                <TRANSACTION>
                    <ID>{fn:data($Transactions/Id)}</ID>
                    <PAYMENT_TYPE>{fn:data($Transactions/PaymentType)}</PAYMENT_TYPE>
                    <PAYMENT_TYPE_DESC>{fn:data($Transactions/PaymentTypeDesc)}</PAYMENT_TYPE_DESC>
                    <TXN_REFERENCE>{fn:data($Transactions/TxnReference)}</TXN_REFERENCE>
                    <DEBIT_ACCOUNT>{fn:data($Transactions/DebitAccount)}</DEBIT_ACCOUNT>
                    <CREDIT_ACCOUNT>{fn:data($Transactions/CreditAccount)}</CREDIT_ACCOUNT>
                    <DESTINATION_BANK>{fn:data($Transactions/DestinationBank)}</DESTINATION_BANK>
                    <DESTINATION_BANK_NAME>{fn:data($Transactions/DestinationBankName)}</DESTINATION_BANK_NAME>
                    <CREDIT_CURRENCY>{fn:data($Transactions/CreditCurrency)}</CREDIT_CURRENCY>
                    <CURRENCY>{fn:data($Transactions/Currency)}</CURRENCY>
                    <AMOUNT>{fn:data($Transactions/Amount)}</AMOUNT>
                    <CREDIT_ACCOUNT_TYPE>{fn:data($Transactions/CreditAccountType)}</CREDIT_ACCOUNT_TYPE>
                    <BENEFICIARY>{fn:data($Transactions/Beneficiary)}</BENEFICIARY>
                    <DOCUMENT_NUMBER>{fn:data($Transactions/DocumentNumber)}</DOCUMENT_NUMBER>
                    <SUPPLIER_ID>{fn:data($Transactions/SupplierId)}</SUPPLIER_ID>
                    <STATUS>{fn:data($Transactions/Status)}</STATUS>
                    <STATUS_DESC>{fn:data($Transactions/StatusDesc)}</STATUS_DESC>
                    <DESCRIPTION>{fn:data($Transactions/Description)}</DESCRIPTION>
                    <WITHDRAWAL_BRANCH>{fn:data($Transactions/WithdrawalBranch)}</WITHDRAWAL_BRANCH>
                    <WITHDRAWAL_BRANCH_NAME>{fn:data($Transactions/WithdrawalBranchName)}</WITHDRAWAL_BRANCH_NAME>
                    <EXTERNAL_REFERENCE>{fn:data($Transactions/ExternalReference)}</EXTERNAL_REFERENCE>
                    <ERROR_CODE>{fn:data($Transactions/ErrorCode)}</ERROR_CODE>
                    <ERROR_MESSAGE>{fn:data($Transactions/ErrorMessage)}</ERROR_MESSAGE>
                    {
                        if(fn:data($Transactions/BillInfo/ContractName) != '') then (
                            <BILL_INFO>
                                <CONTRACT_NAME>{fn:data($Transactions/BillInfo/ContractName)}</CONTRACT_NAME>
                                <DEBTOR_CODE>{fn:data($Transactions/BillInfo/DebtorCode)}</DEBTOR_CODE>
                                <DEBTOR_NAME>{fn:data($Transactions/BillInfo/DebtorName)}</DEBTOR_NAME>
                                <BILL_DETAIL>{fn:data($Transactions/BillInfo/BillDetail)}</BILL_DETAIL>
                            </BILL_INFO>
                        )
                        else()
                    }
                </TRANSACTION>
            }
        </TRANSACTIONS>
    </ns2:consultaDetalleLoteResponse>
};

local:func($responseService)