xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/LocalTransfer/XMLSchema_1836213454.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/transferLocalAccountTypes";
(:: import schema at "../../../../../MWBanking/Transfers/RequestorServices/XSD/transferLocalAccountTypes.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $paymentDetails as xs:string external;
declare variable $LocalTransferResponse as element() (:: schema-element(ns1:TransferenciaentrecuentasResponse) ::) external;

declare function local:func($uuid as xs:string, 
                            $paymentDetails as xs:string, 
                            $LocalTransferResponse as element() (:: schema-element(ns1:TransferenciaentrecuentasResponse) ::)) 
                            as element() (:: schema-element(ns2:transfersLocalAccountResponse) ::) {
    <ns2:transfersLocalAccountResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:TransactionId>{data($LocalTransferResponse/Status/transactionId)}</com:TransactionId>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
        {
                for $DEBITACCTNO in $LocalTransferResponse/FUNDSTRANSFERType/DEBITACCTNO
                return
                    <DebitAccount>{ data($DEBITACCTNO) }</DebitAccount>
            }
            {
                for $CREDITACCTNO in $LocalTransferResponse/FUNDSTRANSFERType/CREDITACCTNO
                return
                    <CreditAccount>{ data($CREDITACCTNO) }</CreditAccount>
            }
            {
                for $DEBITCUSTOMER in $LocalTransferResponse/FUNDSTRANSFERType/DEBITCUSTOMER
                return
                    <DebitCustomer>{ data($DEBITCUSTOMER) }</DebitCustomer>
            }
            {
                for $CREDITCUSTOMER in $LocalTransferResponse/FUNDSTRANSFERType/CREDITCUSTOMER
                return
                    <CreditCustomer>{ data($CREDITCUSTOMER) }</CreditCustomer>
            }
            {
                for $DEBITCURRENCY in $LocalTransferResponse/FUNDSTRANSFERType/DEBITCURRENCY
                return
                    <DebitCurrency>{ data($DEBITCURRENCY) }</DebitCurrency>
            }
            {
                for $CREDITCURRENCY in $LocalTransferResponse/FUNDSTRANSFERType/CREDITCURRENCY
                return
                    <CreditCurrency>{ data($CREDITCURRENCY) }</CreditCurrency>
            }
            {
                for $AMOUNTDEBITED in $LocalTransferResponse/FUNDSTRANSFERType/AMOUNTDEBITED
                return
                    <DebitAmmount>{ substring(data($AMOUNTDEBITED), 4) }</DebitAmmount>
            }
            {
                for $AMOUNTCREDITED in $LocalTransferResponse/FUNDSTRANSFERType/AMOUNTCREDITED
                return
                    <CreditAmmount>{ substring(data($AMOUNTCREDITED), 4) }</CreditAmmount>
            }
            {
            	if(fn:string($LocalTransferResponse/Status/successIndicator/text()) = "Success") then (
            		<TransferDetails>{ data($paymentDetails) }</TransferDetails>
            	) else (
            		""
            	)
            }
            {
                let $LRCUSTRATE := fn:string($LocalTransferResponse/FUNDSTRANSFERType/LRCUSTRATE/text())
                let $CREDITCURRENCY := fn:string($LocalTransferResponse/FUNDSTRANSFERType/CREDITCURRENCY/text())
                let $DEBITCURRENCY := fn:string($LocalTransferResponse/FUNDSTRANSFERType/DEBITCURRENCY/text())
                let $SUCCESSINDICATOR := fn:string($LocalTransferResponse/Status/successIndicator/text())
                return
	                if ($CREDITCURRENCY != "" and $DEBITCURRENCY != "" and $CREDITCURRENCY = $DEBITCURRENCY) then (
	                	<ExchangeRate>1.0000</ExchangeRate>
	                ) else if ($SUCCESSINDICATOR = "Success") then (
	                	<ExchangeRate>{ data($LRCUSTRATE) }</ExchangeRate>
	                ) else (
	                	""
	                )
            }
            {
                let $result :=
                    for $DATETIME in $LocalTransferResponse/FUNDSTRANSFERType/gDATETIME/DATETIME
                    return
                        <DateTime>{ data(fn:concat("20",$DATETIME,"00")) }</DateTime>
                return
                    $result[1]
            }
    </ns2:transfersLocalAccountResponse>
};

local:func($uuid, $paymentDetails, $LocalTransferResponse)
