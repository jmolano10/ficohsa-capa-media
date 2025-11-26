xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/LocalTransfer/XMLSchema_1836213454.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/transferLocalAccountTypes";
(:: import schema at "../../../../../MWBanking/Transfers/RequestorServices/XSD/transferLocalAccountTypes.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $paymentDetails as xs:string external;
declare variable $LocalTransfersResponse as element() (:: schema-element(ns1:TransfmodelbankentrecuentasResponse) ::) external;

declare function local:func($uuid as xs:string, 
                            $paymentDetails as xs:string, 
                            $LocalTransfersResponse as element() (:: schema-element(ns1:TransfmodelbankentrecuentasResponse) ::)) 
                            as element() (:: schema-element(ns2:transfersLocalAccountResponse) ::) {
    <ns2:transfersLocalAccountResponse>
    <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:TransactionId>{data($LocalTransfersResponse/Status/transactionId)}</com:TransactionId>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
         {
                for $DEBITACCTNO in $LocalTransfersResponse/FUNDSTRANSFERType/DEBITACCTNO
                return
                    <DEBIT_ACCOUNT>{ data($DEBITACCTNO) }</DEBIT_ACCOUNT>
            }
            {
                for $CREDITACCTNO in $LocalTransfersResponse/FUNDSTRANSFERType/CREDITACCTNO
                return
                    <CREDIT_ACCOUNT>{ data($CREDITACCTNO) }</CREDIT_ACCOUNT>
            }
            {
                for $DEBITCUSTOMER in $LocalTransfersResponse/FUNDSTRANSFERType/DEBITCUSTOMER
                return
                    <DEBIT_CUSTOMER>{ data($DEBITCUSTOMER) }</DEBIT_CUSTOMER>
            }
            {
                for $CREDITCUSTOMER in $LocalTransfersResponse/FUNDSTRANSFERType/CREDITCUSTOMER
                return
                    <CREDIT_CUSTOMER>{ data($CREDITCUSTOMER) }</CREDIT_CUSTOMER>
            }
            {
                for $DEBITCURRENCY in $LocalTransfersResponse/FUNDSTRANSFERType/DEBITCURRENCY
                return
                    <DEBIT_CURRENCY>{ data($DEBITCURRENCY) }</DEBIT_CURRENCY>
            }
            {
                for $CREDITCURRENCY in $LocalTransfersResponse/FUNDSTRANSFERType/CREDITCURRENCY
                return
                    <CREDIT_CURRENCY>{ data($CREDITCURRENCY) }</CREDIT_CURRENCY>
            }
            {
                for $DEBITAMOUNT in $LocalTransfersResponse/FUNDSTRANSFERType/DEBITAMOUNT
                return
                    <DEBIT_AMOUNT>{ data($DEBITAMOUNT) }</DEBIT_AMOUNT>
            }
            {
                for $CREDITAMOUNT in $LocalTransfersResponse/FUNDSTRANSFERType/CREDITAMOUNT
                return
                    <CREDIT_AMOUNT>{ data($CREDITAMOUNT) }</CREDIT_AMOUNT>
            }
            {
            	if(fn:string($LocalTransfersResponse/Status/successIndicator/text()) = "Success") then (
            		<TRANSFER_DETAILS>{ $paymentDetails }</TRANSFER_DETAILS>
            	) else (
            		""
            	)
            }
            {
                for $CUSTOMERRATE in $LocalTransfersResponse/FUNDSTRANSFERType/CUSTOMERRATE
                return
                    <EXCHANGE_RATE>{ data($CUSTOMERRATE) }</EXCHANGE_RATE>
            }
            {
                let $result :=
                    for $DATETIME in $LocalTransfersResponse/FUNDSTRANSFERType/gDATETIME/DATETIME
                    return
                        <DATE_TIME>{ data(fn:concat("20",$DATETIME,"00")) }</DATE_TIME>
                return
                    $result[1]
            }
    </ns2:transfersLocalAccountResponse>
};

local:func($uuid, $paymentDetails, $LocalTransfersResponse)
