xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/IntergrupalTransfers/XMLSchema_383322568.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/transferLocalAccountTypes";
(:: import schema at "../../../../../MWBanking/Transfers/RequestorServices/XSD/transferLocalAccountTypes.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $intergrupalTransfersResponse as element() (:: schema-element(ns1:TransferenciaIntergrupalInsertResponse) ::) external;
declare variable $paymentDetails as xs:string external;
declare variable $uuid as xs:string external;

declare function local:func($intergrupalTransfersResponse as element() (:: schema-element(ns1:TransferenciaIntergrupalInsertResponse) ::), 
                            $paymentDetails as xs:string, 
                            $uuid as xs:string) 
                            as element() (:: schema-element(ns2:transfersLocalAccountResponse) ::) {
    <ns2:transfersLocalAccountResponse>
    <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:TransactionId>{data($intergrupalTransfersResponse/Status/transactionId)}</com:TransactionId>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
            {
                for $DEBITACCTNO in $intergrupalTransfersResponse/FUNDSTRANSFERType/DEBITACCTNO
                return
                    <DEBIT_ACCOUNT>{ data($DEBITACCTNO) }</DEBIT_ACCOUNT>
            }
            {
                for $CREDITACCTNO in $intergrupalTransfersResponse/FUNDSTRANSFERType/CREDITACCTNO
                return
                    <CREDIT_ACCOUNT>{ data($CREDITACCTNO) }</CREDIT_ACCOUNT>
            }
            {
                for $DEBITCUSTOMER in $intergrupalTransfersResponse/FUNDSTRANSFERType/DEBITCUSTOMER
                return
                    <DEBIT_CUSTOMER>{ data($DEBITCUSTOMER) }</DEBIT_CUSTOMER>
            }
            {
                for $CREDITCUSTOMER in $intergrupalTransfersResponse/FUNDSTRANSFERType/CREDITCUSTOMER
                return
                    <CREDIT_CUSTOMER>{ data($CREDITCUSTOMER) }</CREDIT_CUSTOMER>
            }
            {
                for $DEBITCURRENCY in $intergrupalTransfersResponse/FUNDSTRANSFERType/DEBITCURRENCY
                return
                    <DEBIT_CURRENCY>{ data($DEBITCURRENCY) }</DEBIT_CURRENCY>
            }
            {
                for $CREDITCURRENCY in $intergrupalTransfersResponse/FUNDSTRANSFERType/CREDITCURRENCY
                return
                    <CREDIT_CURRENCY>{ data($CREDITCURRENCY) }</CREDIT_CURRENCY>
            }
            {
                for $AMOUNTDEBITED in $intergrupalTransfersResponse/FUNDSTRANSFERType/AMOUNTDEBITED
                return
                    <DEBIT_AMOUNT>{ substring(data($AMOUNTDEBITED), 4) }</DEBIT_AMOUNT>
            }
            {                    
                for $AMOUNTCREDITED in $intergrupalTransfersResponse/FUNDSTRANSFERType/AMOUNTCREDITED
                return
                    <CREDIT_AMOUNT>{ substring(data($AMOUNTCREDITED), 4) }</CREDIT_AMOUNT>                    
            }
            {
				if(fn:string($intergrupalTransfersResponse/Status/successIndicator/text()) = "Success") 
				then (<TRANSFER_DETAILS>{ data($paymentDetails) }</TRANSFER_DETAILS>) 
            	else ("")
            }     
            {
                let $LRCUSTRATE := fn:string($intergrupalTransfersResponse/FUNDSTRANSFERType/LRCUSTRATE/text())
                let $CREDITCURRENCY := fn:string($intergrupalTransfersResponse/FUNDSTRANSFERType/CREDITCURRENCY/text())
                let $DEBITCURRENCY := fn:string($intergrupalTransfersResponse/FUNDSTRANSFERType/DEBITCURRENCY/text())
                let $SUCCESSINDICATOR := fn:string($intergrupalTransfersResponse/Status/successIndicator/text())
                return
	                if ($CREDITCURRENCY != "" and $DEBITCURRENCY != "" and $CREDITCURRENCY = $DEBITCURRENCY) then (
	                	<EXCHANGE_RATE>1.0000</EXCHANGE_RATE>
	                ) else if($SUCCESSINDICATOR = "Success") then (
	                	<EXCHANGE_RATE>{ data($LRCUSTRATE) }</EXCHANGE_RATE>
	                ) else (
	                	""
	                )
            }
            {
                let $result :=
                    for $DATETIME in $intergrupalTransfersResponse/FUNDSTRANSFERType/gDATETIME/DATETIME
                    return
                        <DATE_TIME>{ data(fn:concat("20",$DATETIME,"00")) }</DATE_TIME>
                return
                    $result[1]
            }
        </ns2:transfersLocalAccountResponse>
};

local:func($intergrupalTransfersResponse, $paymentDetails, $uuid)
