xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/massivePayment/apiPagosMasivosTypes";
(:: import schema at "../../SBRG_MassivePayment_Commons/Schemas/APIPagosMasivosTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/GetBatchTransactionTypes.xsd" ::)

declare variable $responseService as element() (:: schema-element(ns1:ConsultarTransaccionLoteResponse) ::) external;
declare variable $globalId as xs:string external;

declare function local:func(
    $responseService as element() (:: schema-element(ns1:ConsultarTransaccionLoteResponse) ::),
    $globalId as xs:string
    ) as element() (:: schema-element(ns2:getBatchTransactionResponse) ::) {
    <ns2:getBatchTransactionResponse>
        <StatusInfo>
            <Status>Success</Status>
            <TransactionId></TransactionId>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
        {
            if ($responseService/customerId)
            then <CustomerId>{fn:data($responseService/customerId)}</CustomerId>
            else ()
        }
        <Transaction>
            {
                if ($responseService/ticket)
                then <Ticket>{fn:data($responseService/ticket)}</Ticket>
                else ()
            }
            {
                if ($responseService/customerBatchId)
                then <CustomerBatchId>{fn:data($responseService/customerBatchId)}</CustomerBatchId>
                else ()
            }
            {
                if ($responseService/id)
                then <Id>{fn:data($responseService/id)}</Id>
                else ()
            }
            {
                if ($responseService/transactionReference)
                then <TxnReference>{fn:data($responseService/transactionReference)}</TxnReference>
                else ()
            }
            {
                if ($responseService/bankBatchId)
                then <BankBatchId>{fn:data($responseService/bankBatchId)}</BankBatchId>
                else ()
            }
            {
                if ($responseService/debitAccount)
                then <DebitAccount>{fn:data($responseService/debitAccount)}</DebitAccount>
                else ()
            }
            {
                if ($responseService/creditAccount)
                then <CreditAccount>{fn:data($responseService/creditAccount)}</CreditAccount>
                else ()
            }
            {
                if ($responseService/amount)
                then <Amount>{fn:data($responseService/amount)}</Amount>
                else ()
            }
        </Transaction>
    </ns2:getBatchTransactionResponse>
};

local:func($responseService, $globalId)