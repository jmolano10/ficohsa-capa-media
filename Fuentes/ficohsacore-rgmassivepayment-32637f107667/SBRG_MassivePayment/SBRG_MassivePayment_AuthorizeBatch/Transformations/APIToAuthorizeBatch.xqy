xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/massivePayment/apiPagosMasivosTypes";
(:: import schema at "../../SBRG_MassivePayment_Commons/Schemas/APIPagosMasivosTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/AuthorizeBatchTypes.xsd" ::)

declare variable $responseService as element() (:: schema-element(ns1:AutorizarLoteResponse) ::) external;
declare variable $globalId as xs:string external;

declare function local:func(
    $responseService as element() (:: schema-element(ns1:AutorizarLoteResponse) ::),
    $globalId as xs:string
    ) as element() (:: schema-element(ns2:authorizeBatchResponse) ::) {
    <ns2:authorizeBatchResponse>
        <StatusInfo>
            <Status>Success</Status>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
        <Ticket>{fn:data($responseService/ticket)}</Ticket>
        <CustomerBatchId>{fn:data($responseService/customerBatchId)}</CustomerBatchId>
        <BankBatchId>{fn:data($responseService/bankBatchId)}</BankBatchId>
        <CustomerId>{fn:data($responseService/customerId)}</CustomerId>
        <Status>{fn:data($responseService/status)}</Status>
        <StatusDescription>{fn:data($responseService/statusDescription)}</StatusDescription>
        {
            for $errors in $responseService/errors
            return 
            <DetailErrors>
                <AccountNumber>{fn:data($errors/accountNumber)}</AccountNumber>
                <BatchAmount>{fn:data($errors/batchAmount)}</BatchAmount>
                <TaxAmount>{fn:data($errors/taxAmount)}</TaxAmount>
            </DetailErrors>
        }
    </ns2:authorizeBatchResponse>
};

local:func($responseService, $globalId)