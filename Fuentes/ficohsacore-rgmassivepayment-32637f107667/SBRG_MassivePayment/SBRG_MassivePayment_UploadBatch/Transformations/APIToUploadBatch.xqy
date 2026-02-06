xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/massivePayment/apiPagosMasivosTypes";
(:: import schema at "../../SBRG_MassivePayment_Commons/Schemas/APIPagosMasivosTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/UploadBatchTypes.xsd" ::)

declare variable $responseService as element() (:: schema-element(ns1:PagosMasivosResponse) ::) external;
declare variable $globalId as xs:string external;

declare function local:func(
    $responseService as element() (:: schema-element(ns1:PagosMasivosResponse) ::),
    $globalId as xs:string
    ) as element() (:: schema-element(ns2:uploadBatchResponse) ::) {
    <ns2:uploadBatchResponse>
        <StatusInfo>
            <Status>Success</Status>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
        {
            if ($responseService/globalId)
            then <GlobalId>{fn:data($responseService/globalId)}</GlobalId>
            else ()
        }
        {
            if ($responseService/customerId)
            then <CustomerId>{fn:data($responseService/customerId)}</CustomerId>
            else ()
        }
        {
            for $batches in $responseService/batches
            return 
            <Batches>
                {
                    if ($batches/ticket)
                    then <Ticket>{fn:data($batches/ticket)}</Ticket>
                    else ()
                }
                {
                    if ($batches/customerBatchId)
                    then <CustomerBatchId>{fn:data($batches/customerBatchId)}</CustomerBatchId>
                    else ()
                }
                {
                    if ($batches/bankBatchId)
                    then <BankBatchId>{fn:data($batches/bankBatchId)}</BankBatchId>
                    else ()
                }
                {
                    if ($batches/customerId)
                    then <CustomerId>{fn:data($batches/customerId)}</CustomerId>
                    else ()
                }
                {
                    if ($batches/uploadDate)
                    then <UploadDate>{fn:data($batches/uploadDate)}</UploadDate>
                    else ()
                }
                {
                    if ($batches/applicationDate)
                    then <ApplicationDate>{fn:data($batches/applicationDate)}</ApplicationDate>
                    else ()
                }
                {
                    if ($batches/status)
                    then <Status>{fn:data($batches/status)}</Status>
                    else ()
                }
                {
                    if ($batches/totalAmount)
                    then <TotalAmount>{fn:data($batches/totalAmount)}</TotalAmount>
                    else ()
                }
                {
                    if ($batches/rowCount)
                    then <NumberOfTransactions>{fn:data($batches/rowCount)}</NumberOfTransactions>
                    else ()
                }
                {
                    for $transactionResults in $batches/transactionResults
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
            </Batches>
        }
    </ns2:uploadBatchResponse>
};

local:func($responseService, $globalId)