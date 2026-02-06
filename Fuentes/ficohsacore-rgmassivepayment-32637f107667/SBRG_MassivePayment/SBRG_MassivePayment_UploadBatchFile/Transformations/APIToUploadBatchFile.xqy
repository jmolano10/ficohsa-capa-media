xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/massivePayment/apiPagosMasivosTypes";
(:: import schema at "../../SBRG_MassivePayment_Commons/Schemas/APIPagosMasivosTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/UploadBatchFileTypes.xsd" ::)

declare variable $responseService as element() (:: schema-element(ns1:CargarArchivoLoteResponse) ::) external;
declare variable $globalId as xs:string external;

declare function local:func(
    $responseService as element() (:: schema-element(ns1:CargarArchivoLoteResponse) ::),
    $globalId as xs:string
    ) as element() (:: schema-element(ns2:uploadBatchFileResponse) ::) {
    <ns2:uploadBatchFileResponse>
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
            if ($responseService/uploadDate)
            then <UploadDate>{fn:data($responseService/uploadDate)}</UploadDate>
            else ()
        }
        {
            if ($responseService/applicationDate)
            then <ApplicationDate>{fn:data($responseService/applicationDate)}</ApplicationDate>
            else ()
        }
        {
            if ($responseService/status)
            then <Status>{fn:data($responseService/status)}</Status>
            else ()
        }
        {
            if ($responseService/totalAmount)
            then <TotalAmount>{fn:data($responseService/totalAmount)}</TotalAmount>
            else ()
        }
        {
            if ($responseService/rowCount)
            then <NumberOfTransactions>{fn:data($responseService/rowCount)}</NumberOfTransactions>
            else ()
        }
        {
            for $transactionResults in $responseService/transactionResults
            return 
            <TrxStatus>
                {
                    if ($transactionResults/id)
                    then <Id>{fn:data($transactionResults/id)}</Id>
                    else ()
                }
                {
                    for $errors in $transactionResults/errors
                    return 
                    <ErrorMessages>
                        {
                            if ($errors/code)
                            then <Code>{fn:data($errors/code)}</Code>
                            else ()
                        }
                        {
                            if ($errors/message)
                            then <Message>{fn:data($errors/message)}</Message>
                            else ()
                        }
                    </ErrorMessages>
                }
            </TrxStatus>
        }
    </ns2:uploadBatchFileResponse>
};

local:func($responseService, $globalId)