xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/massivePayment/apiPagosMasivosTypes";
(:: import schema at "../../SBRG_MassivePayment_Commons/Schemas/APIPagosMasivosTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/CancelBatchTypes.xsd" ::)

declare variable $responseService as element() (:: schema-element(ns1:CancelarLoteResponse) ::) external;
declare variable $globalId as xs:string external;

declare function local:func(
    $responseService as element() (:: schema-element(ns1:CancelarLoteResponse) ::),
    $globalId as xs:string
    ) as element() (:: schema-element(ns2:cancelBatchResponse) ::) {
    <ns2:cancelBatchResponse>
        <StatusInfo>
            <Status>Success</Status>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
        <Ticket>{fn:data($responseService/ticket)}</Ticket>
        <CustomerBatchId>{fn:data($responseService/customerBatchId)}</CustomerBatchId>
        {
            if ($responseService/bankBatchId)
            then <BankBatchId>{fn:data($responseService/bankBatchId)}</BankBatchId>
            else ()
        }
        <CustomerId>{fn:data($responseService/customerId)}</CustomerId>
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
    </ns2:cancelBatchResponse>
};

local:func($responseService, $globalId)