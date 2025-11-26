xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/TransferLoanDisbursement/svcDesembolsoPrestamoCredCtaTypes.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/transferTypes";
(:: import schema at "../../../../../MWBanking/Transfers/RequestorServices/XSD/transferTypes.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $t24Response as element() (:: schema-element(ns1:DesembolsoporcreditoacuentaResponse) ::) external;

declare function xq:Tx_T24_To_TransfersAccountsResponse($uuid as xs:string, 
                                                        $t24Response as element() (:: schema-element(ns1:DesembolsoporcreditoacuentaResponse) ::)) 
                                                        as element() (:: schema-element(ns2:transfersAccountResponse) ::) {
    <ns2:transfersAccountResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            {
                if ($t24Response/Status/transactionId)
                then <com:TransactionId>{fn:data($t24Response/Status/transactionId)}</com:TransactionId>
                else ()
            }
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{$uuid}</com:GlobalId>
        </ns2:StatusInfo>
        {
            if ($t24Response/FUNDSTRANSFERType/DEBITACCTNO)
            then <ns2:DebitAccount>{fn:data($t24Response/FUNDSTRANSFERType/DEBITACCTNO)}</ns2:DebitAccount>
            else ()
        }
        {
            if ($t24Response/FUNDSTRANSFERType/DEBITCURRENCY)
            then <ns2:DebitCurrency>{fn:data($t24Response/FUNDSTRANSFERType/DEBITCURRENCY)}</ns2:DebitCurrency>
            else ()
        }
        {
            if ($t24Response/FUNDSTRANSFERType/DEBITAMOUNT)
            then <ns2:DebitAmount>{fn:data($t24Response/FUNDSTRANSFERType/DEBITAMOUNT)}</ns2:DebitAmount>
            else ()
        }
        {
            if ($t24Response/FUNDSTRANSFERType/CREDITACCTNO)
            then <ns2:CreditAccount>{fn:data($t24Response/FUNDSTRANSFERType/CREDITACCTNO)}</ns2:CreditAccount>
            else ()
        }
        {
            if ($t24Response/FUNDSTRANSFERType/CREDITCUSTOMER)
            then <ns2:CreditCustomer>{fn:data($t24Response/FUNDSTRANSFERType/CREDITCUSTOMER)}</ns2:CreditCustomer>
            else ()
        }
        {
            if ($t24Response/FUNDSTRANSFERType/CREDITCURRENCY)
            then <ns2:CreditCurrency>{fn:data($t24Response/FUNDSTRANSFERType/CREDITCURRENCY)}</ns2:CreditCurrency>
            else ()
        }
        {
            if ($t24Response/FUNDSTRANSFERType/CREDITAMOUNT)
            then <ns2:CreditAmount>{fn:data($t24Response/FUNDSTRANSFERType/CREDITAMOUNT)}</ns2:CreditAmount>
            else ()
        }
        {
            if ($t24Response/FUNDSTRANSFERType/TREASURYRATE)
            then <ns2:ExchangeRate>{fn:data($t24Response/FUNDSTRANSFERType/TREASURYRATE)}</ns2:ExchangeRate>
            else ()
        }
        {
            if ($t24Response/FUNDSTRANSFERType/PROCESSINGDATE)
            then <ns2:DateTime>{
            fn:concat(fn:substring(fn:data($t24Response/FUNDSTRANSFERType/PROCESSINGDATE),0,5),'-',fn:substring(fn:data($t24Response/FUNDSTRANSFERType/PROCESSINGDATE),5,2),'-',fn:substring(fn:data($t24Response/FUNDSTRANSFERType/PROCESSINGDATE),7,2))
                }
            </ns2:DateTime>
            else ()
        }
    </ns2:transfersAccountResponse>
};

xq:Tx_T24_To_TransfersAccountsResponse($uuid, $t24Response)
