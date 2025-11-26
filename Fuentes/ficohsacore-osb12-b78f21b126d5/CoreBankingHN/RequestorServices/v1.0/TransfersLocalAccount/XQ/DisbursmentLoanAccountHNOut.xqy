xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/DisbursmentLoanCreditAccount/XMLSchema_-2126816862.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/transferLocalAccountTypes";
(:: import schema at "../../../../../MWBanking/Transfers/RequestorServices/XSD/transferLocalAccountTypes.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $disbursmentLoanCreditAccountResponse as element() (:: schema-element(ns1:DesembolsoporcreditoacuentaResponse) ::) external;
declare variable $uuid as xs:string external;

declare function local:func($disbursmentLoanCreditAccountResponse as element() (:: schema-element(ns1:DesembolsoporcreditoacuentaResponse) ::)) as element() (:: schema-element(ns2:transfersLocalAccountResponse) ::) {
    <ns2:transfersLocalAccountResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:TransactionId>{data($disbursmentLoanCreditAccountResponse/Status/transactionId)}</com:TransactionId>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
    {
                for $DEBITACCTNO in $disbursmentLoanCreditAccountResponse/FUNDSTRANSFERType/DEBITACCTNO
                return
                    <DEBIT_ACCOUNT>{ data($DEBITACCTNO) }</DEBIT_ACCOUNT>
            }
            {
                for $CREDITACCTNO in $disbursmentLoanCreditAccountResponse/FUNDSTRANSFERType/CREDITACCTNO
                return
                    <CREDIT_ACCOUNT>{ data($CREDITACCTNO) }</CREDIT_ACCOUNT>
            }
            {
                for $DEBITCURRENCY in $disbursmentLoanCreditAccountResponse/FUNDSTRANSFERType/DEBITCURRENCY
                return
                    <DEBIT_CURRENCY>{ data($DEBITCURRENCY) }</DEBIT_CURRENCY>
            }
            {
                for $CREDITCURRENCY in $disbursmentLoanCreditAccountResponse/FUNDSTRANSFERType/CREDITCURRENCY
                return
                    <CREDIT_CURRENCY>{ data($CREDITCURRENCY) }</CREDIT_CURRENCY>
            }
            {
                for $DEBITAMOUNT in $disbursmentLoanCreditAccountResponse/FUNDSTRANSFERType/DEBITAMOUNT
                return
                    <DEBIT_AMOUNT>{ data($DEBITAMOUNT) }</DEBIT_AMOUNT>
            }
            {
                for $CREDITAMOUNT in $disbursmentLoanCreditAccountResponse/FUNDSTRANSFERType/CREDITAMOUNT
                return
                    <CREDIT_AMOUNT>{ data($CREDITAMOUNT) }</CREDIT_AMOUNT>
            }
            {
                for $LRCOMMDETAILS in $disbursmentLoanCreditAccountResponse/FUNDSTRANSFERType/LRCOMMDETAILS
                return
                    <TRANSFER_DETAILS>{ data($LRCOMMDETAILS) }</TRANSFER_DETAILS>
            }
            {
                for $TREASURYRATE in $disbursmentLoanCreditAccountResponse/FUNDSTRANSFERType/TREASURYRATE
                return
                    <EXCHANGE_RATE>{ data($TREASURYRATE) }</EXCHANGE_RATE>
            }
            {
                for $PROCESSINGDATE in $disbursmentLoanCreditAccountResponse/FUNDSTRANSFERType/PROCESSINGDATE
                return
                    <DATE_TIME>{ data($PROCESSINGDATE) }</DATE_TIME>
            }
    </ns2:transfersLocalAccountResponse>
};

local:func($disbursmentLoanCreditAccountResponse)
