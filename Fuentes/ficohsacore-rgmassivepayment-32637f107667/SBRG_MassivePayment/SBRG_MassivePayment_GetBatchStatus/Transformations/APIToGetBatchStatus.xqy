xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/massivePayment/apiPagosMasivosTypes";
(:: import schema at "../../SBRG_MassivePayment_Commons/Schemas/APIPagosMasivosTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/GetBatchStatusTypes.xsd" ::)

declare variable $responseService as element() (:: schema-element(ns1:ConsultarEstadoLoteResponse) ::) external;
declare variable $globalId as xs:string external;

declare function local:func(
    $responseService as element() (:: schema-element(ns1:ConsultarEstadoLoteResponse) ::),
    $globalId as xs:string
    ) as element() (:: schema-element(ns2:getBatchStatusResponse) ::) {
    <ns2:getBatchStatusResponse>
        <StatusInfo>
            <Status>Success</Status>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
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
            if ($responseService/bankBatchId)
            then <BankBatchId>{fn:data($responseService/bankBatchId)}</BankBatchId>
            else ()
        }
        {
            if ($responseService/customerId)
            then <CustomerId>{fn:data($responseService/customerId)}</CustomerId>
            else ()
        }
        {
            if ($responseService/customerName)
            then <CustomerName>{fn:data($responseService/customerName)}</CustomerName>
            else ()
        }
        {
            if ($responseService/status)
            then <Status>{fn:data($responseService/status)}</Status>
            else ()
        }
        {
            if ($responseService/statusDescription)
            then <StatusDescription>{fn:data($responseService/statusDescription)}</StatusDescription>
            else ()
        }
        {
            if ($responseService/optimistic)
            then <Optimistic>{fn:data($responseService/optimistic)}</Optimistic>
            else ()
        }
        {
            for $accounts in $responseService/accounts
            return 
            <Accounts>
                {
                    if ($accounts/number)
                    then <DebitAccount>{fn:data($accounts/number)}</DebitAccount>
                    else ()
                }
                {
                    if ($accounts/amount)
                    then <Amount>{fn:data($accounts/amount)}</Amount>
                    else ()
                }
                {
                    if ($accounts/currency)
                    then <Currency>{fn:data($accounts/currency)}</Currency>
                    else ()
                }
            </Accounts>
        }
        {
            for $payments in $responseService/payments
            return 
            <Payments>
                {
                    if ($payments/currency)
                    then <Currency>{fn:data($payments/currency)}</Currency>
                    else ()
                }
                {
                    if ($payments/amount)
                    then <TotalAmount>{fn:data($payments/amount)}</TotalAmount>
                    else ()
                }
                {
                    if ($payments/exchangeRate)
                    then <ExchangeRate>{fn:data($payments/exchangeRate)}</ExchangeRate>
                    else ()
                }
            </Payments>
        }
        {
            if ($responseService/amount)
            then <TotalAmount>{fn:data($responseService/amount)}</TotalAmount>
            else ()
        }
        {
            if ($responseService/successAmount)
            then <TotalAmountSuccess>{fn:data($responseService/successAmount)}</TotalAmountSuccess>
            else ()
        }
        {
            if ($responseService/errorAmount)
            then <TotalAmountError>{fn:data($responseService/errorAmount)}</TotalAmountError>
            else ()
        }
        {
            if ($responseService/rowCount)
            then <NumberOfTransactions>{fn:data($responseService/rowCount)}</NumberOfTransactions>
            else ()
        }
        {
            if ($responseService/successRowCount)
            then <NumberOfTransactionsSuccess>{fn:data($responseService/successRowCount)}</NumberOfTransactionsSuccess>
            else ()
        }
        {
            if ($responseService/errorRowCount)
            then <NumberOfTransactionsError>{fn:data($responseService/errorRowCount)}</NumberOfTransactionsError>
            else ()
        }
        {
            if ($responseService/applicationDate)
            then <ApplicationDate>{fn:substring(fn:string(fn:data($responseService/applicationDate)),0,20)}</ApplicationDate>
            else ()
        }
        {
            if ($responseService/processInfo)
            then <ProcessInfo>{fn:data($responseService/processInfo)}</ProcessInfo>
            else ()
        }
    </ns2:getBatchStatusResponse>
};

local:func($responseService, $globalId)