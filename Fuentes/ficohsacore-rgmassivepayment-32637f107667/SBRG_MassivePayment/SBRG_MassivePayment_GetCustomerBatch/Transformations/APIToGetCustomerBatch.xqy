xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/massivePayment/apiPagosMasivosTypes";
(:: import schema at "../../SBRG_MassivePayment_Commons/Schemas/APIPagosMasivosTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/GetCustomerBatchTypes.xsd" ::)

declare variable $responseService as element() (:: schema-element(ns1:ConsultarLotesClienteResponse) ::) external;
declare variable $globalId as xs:string external;

declare function local:func(
    $responseService as element() (:: schema-element(ns1:ConsultarLotesClienteResponse) ::),
    $globalId as xs:string
    ) as element() (:: schema-element(ns2:getCustomerBatchResponse) ::) {
    <ns2:getCustomerBatchResponse>
        <StatusInfo>
            <Status>Success</Status>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
        {
            if ($responseService/customerId)
            then <CustomerId>{fn:data($responseService/customerId)}</CustomerId>
            else ()
        }
        {
            if ($responseService/beginDate)
            then <BeginDate>{fn:substring(fn:string(fn:data($responseService/beginDate)),0,11)}</BeginDate>
            else ()
        }
        {
            if ($responseService/endDate)
            then <EndDate>{fn:substring(fn:string(fn:data($responseService/endDate)),0,11)}</EndDate>
            else ()
        }
        {
            for $consultarLotesClienteResponseDetails in $responseService/consultarLotesClienteResponseDetails
            return 
            <Batches>
                {
                    if ($consultarLotesClienteResponseDetails/ticket)
                    then <Ticket>{fn:data($consultarLotesClienteResponseDetails/ticket)}</Ticket>
                    else ()
                }
                {
                    if ($consultarLotesClienteResponseDetails/customerBatchId)
                    then <CustomerBatchId>{fn:data($consultarLotesClienteResponseDetails/customerBatchId)}</CustomerBatchId>
                    else ()
                }
                {
                    if ($consultarLotesClienteResponseDetails/bankBatchId)
                    then <BankBatchId>{fn:data($consultarLotesClienteResponseDetails/bankBatchId)}</BankBatchId>
                    else ()
                }
                {
                    if ($consultarLotesClienteResponseDetails/operationType)
                    then <Type>{fn:data($consultarLotesClienteResponseDetails/operationType)}</Type>
                    else ()
                }
                {
                    if ($consultarLotesClienteResponseDetails/operationTypeDescription)
                    then <TypeDesc>{fn:data($consultarLotesClienteResponseDetails/operationTypeDescription)}</TypeDesc>
                    else ()
                }
                {
                    if ($consultarLotesClienteResponseDetails/uploadDate)
                    then <UploadDate>{fn:substring(fn:string(fn:data($consultarLotesClienteResponseDetails/uploadDate)),0,11)}</UploadDate>
                    else ()
                }
                {
                    if ($consultarLotesClienteResponseDetails/applicationDate)
                    then <ApplicationDate>{fn:substring(fn:string(fn:data($consultarLotesClienteResponseDetails/applicationDate)),0,20)}</ApplicationDate>
                    else ()
                }
                {
                    if ($consultarLotesClienteResponseDetails/rowCount)
                    then <NumberOfTransactions>{fn:data($consultarLotesClienteResponseDetails/rowCount)}</NumberOfTransactions>
                    else ()
                }
                {
                    if ($consultarLotesClienteResponseDetails/successRowCount)
                    then <NumberOfTransactionsSuccess>{fn:data($consultarLotesClienteResponseDetails/successRowCount)}</NumberOfTransactionsSuccess>
                    else ()
                }
                {
                    if ($consultarLotesClienteResponseDetails/errorRowCount)
                    then <NumberOfTransactionsError>{fn:data($consultarLotesClienteResponseDetails/errorRowCount)}</NumberOfTransactionsError>
                    else ()
                }
                {
                    if ($consultarLotesClienteResponseDetails/amount)
                    then <TotalAmount>{fn:data($consultarLotesClienteResponseDetails/amount)}</TotalAmount>
                    else ()
                }
                {
                    if ($consultarLotesClienteResponseDetails/successAmount)
                    then <TotalAmountSuccess>{fn:data($consultarLotesClienteResponseDetails/successAmount)}</TotalAmountSuccess>
                    else ()
                }
                {
                    if ($consultarLotesClienteResponseDetails/errorAmount)
                    then <TotalAmountError>{fn:data($consultarLotesClienteResponseDetails/errorAmount)}</TotalAmountError>
                    else ()
                }
                {
                    if ($consultarLotesClienteResponseDetails/status)
                    then <Status>{fn:data($consultarLotesClienteResponseDetails/status)}</Status>
                    else ()
                }
                {
                    if ($consultarLotesClienteResponseDetails/statusDescription)
                    then <StatusDesc>{fn:data($consultarLotesClienteResponseDetails/statusDescription)}</StatusDesc>
                    else ()
                }
            </Batches>
        }
    </ns2:getCustomerBatchResponse>
};

local:func($responseService, $globalId)