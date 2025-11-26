xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/transferLocalAccountTypes";
(:: import schema at "../../../../../MWBanking/Transfers/RequestorServices/XSD/transferLocalAccountTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/TransferenciaCuentas";
(:: import schema at "../../../../ProviderServices/XSD/TransfersLocalAccount/TransfersLocalAccount_sp.xsd" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/transfersLocalAccountGTOut";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $outputParameters as element() (:: schema-element(ns2:OutputParameters) ::) external;

declare function ns1:transfersLocalAccountGTOut($uuid as xs:string, 
                                                $outputParameters as element() (:: schema-element(ns2:OutputParameters) ::)) 
                                                as element() (:: schema-element(ns3:transfersLocalAccountResponse) ::) {
    <ns3:transfersLocalAccountResponse>
        <ns3:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns3:StatusInfo>
        {
            if ($outputParameters/ns2:DEBIT_ACCOUNT)
            then <ns3:DebitAccount>{fn:data($outputParameters/ns2:DEBIT_ACCOUNT)}</ns3:DebitAccount>
            else ()
        }
        {
            if ($outputParameters/ns2:CREDIT_ACCOUNT)
            then <ns3:CreditAccount>{fn:data($outputParameters/ns2:CREDIT_ACCOUNT)}</ns3:CreditAccount>
            else ()
        }
        {
            if ($outputParameters/ns2:DEBIT_CUSTOMER)
            then <ns3:DebitCustomer>{fn:data($outputParameters/ns2:DEBIT_CUSTOMER)}</ns3:DebitCustomer>
            else ()
        }
        {
            if ($outputParameters/ns2:CREDIT_CUSTOMER)
            then <ns3:CreditCustomer>{fn:data($outputParameters/ns2:CREDIT_CUSTOMER)}</ns3:CreditCustomer>
            else ()
        }
        {
            if ($outputParameters/ns2:DEBIT_CURRENCY)
            then <ns3:DebitCurrency>{fn:data($outputParameters/ns2:DEBIT_CURRENCY)}</ns3:DebitCurrency>
            else ()
        }
        {
            if ($outputParameters/ns2:CREDIT_CURRENCY)
            then <ns3:CreditCurrency>{fn:data($outputParameters/ns2:CREDIT_CURRENCY)}</ns3:CreditCurrency>
            else ()
        }
        {
            if ($outputParameters/ns2:DEBIT_AMOUNT)
            then <ns3:DebitAmmount>{fn:data($outputParameters/ns2:DEBIT_AMOUNT)}</ns3:DebitAmmount>
            else ()
        }
        {
            if ($outputParameters/ns2:CREDIT_AMOUNT)
            then <ns3:CreditAmmount>{fn:data($outputParameters/ns2:CREDIT_AMOUNT)}</ns3:CreditAmmount>
            else ()
        }
        <ns3:TransferDetails>{fn:data($outputParameters/ns2:TRANSFER_DETAILS)}</ns3:TransferDetails>
        {
            if ($outputParameters/ns2:EXCHANGE_RATE)
            then <ns3:ExchangeRate>{fn:data($outputParameters/ns2:EXCHANGE_RATE)}</ns3:ExchangeRate>
            else ()
        }
        {
            if ($outputParameters/ns2:VALUE_DATE)
            then <ns3:DateTime>{fn:data($outputParameters/ns2:VALUE_DATE)}</ns3:DateTime>
            else ()
        }
    </ns3:transfersLocalAccountResponse>
};

ns1:transfersLocalAccountGTOut($uuid, $outputParameters)