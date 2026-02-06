xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/massivePayment/apiPagosMasivosTypes";
(:: import schema at "../../SBRG_MassivePayment_Commons/Schemas/APIPagosMasivosTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/GetBatchDetailTypes.xsd" ::)

declare variable $responseService as element() (:: schema-element(ns1:ConsultarDetalleLoteResponse) ::) external;
declare variable $globalId as xs:string external;

declare function local:func(
    $responseService as element() (:: schema-element(ns1:ConsultarDetalleLoteResponse) ::),
    $globalId as xs:string
    ) as element() (:: schema-element(ns2:getBatchDetailResponse) ::) {
    <ns2:getBatchDetailResponse>
        <StatusInfo>
            <Status>Success</Status>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
        {
            if ($responseService/consultarDetalleLoteResponseData/ticket)
            then <Ticket>{fn:data($responseService/consultarDetalleLoteResponseData/ticket)}</Ticket>
            else ()
        }
        {
            if ($responseService/consultarDetalleLoteResponseData/customerBatchId)
            then <CustomerBatchId>{fn:data($responseService/consultarDetalleLoteResponseData/customerBatchId)}</CustomerBatchId>
            else ()
        }
        {
            if ($responseService/consultarDetalleLoteResponseData/customerId)
            then <CustomerId>{fn:data($responseService/consultarDetalleLoteResponseData/customerId)}</CustomerId>
            else ()
        }
        {
            if ($responseService/consultarDetalleLoteResponseData/bankBatchId)
            then <BankBatchId>{fn:data($responseService/consultarDetalleLoteResponseData/bankBatchId)}</BankBatchId>
            else ()
        }
        {
            if ($responseService/consultarDetalleLoteResponseData/customerName)
            then <CustomerName>{fn:data($responseService/consultarDetalleLoteResponseData/customerName)}</CustomerName>
            else ()
        }
        {
            if ($responseService/consultarDetalleLoteResponseData/operationType)
            then <BatchType>{fn:data($responseService/consultarDetalleLoteResponseData/operationType)}</BatchType>
            else ()
        }
        {
            if ($responseService/consultarDetalleLoteResponseData/operationTypeDescription)
            then <BatchTypeDesc>{fn:data($responseService/consultarDetalleLoteResponseData/operationTypeDescription)}</BatchTypeDesc>
            else ()
        }
        {
            if ($responseService/consultarDetalleLoteResponseData/uploadDate)
            then <UploadDate>{fn:substring(fn:string(fn:data($responseService/consultarDetalleLoteResponseData/uploadDate)),0,11)}</UploadDate>
            else ()
        }
        {
            if ($responseService/consultarDetalleLoteResponseData/applicationDate)
            then <ApplicationDate>{fn:substring(fn:string(fn:data($responseService/consultarDetalleLoteResponseData/applicationDate)),0,20)}</ApplicationDate>
            else ()
        }
        {
            if ($responseService/consultarDetalleLoteResponseData/rowCount)
            then <NumberOfTransactions>{fn:data($responseService/consultarDetalleLoteResponseData/rowCount)}</NumberOfTransactions>
            else ()
        }
        {
            if ($responseService/consultarDetalleLoteResponseData/successRowCount)
            then <NumberOfTransactionsSuccess>{fn:data($responseService/consultarDetalleLoteResponseData/successRowCount)}</NumberOfTransactionsSuccess>
            else ()
        }
        {
            if ($responseService/consultarDetalleLoteResponseData/errorRowCount)
            then <NumberOfTransactionsError>{fn:data($responseService/consultarDetalleLoteResponseData/errorRowCount)}</NumberOfTransactionsError>
            else ()
        }
        {
            if ($responseService/consultarDetalleLoteResponseData/amount)
            then <TotalAmount>{fn:data($responseService/consultarDetalleLoteResponseData/amount)}</TotalAmount>
            else ()
        }
        {
            if ($responseService/consultarDetalleLoteResponseData/successAmount)
            then <TotalAmountSuccess>{fn:data($responseService/consultarDetalleLoteResponseData/successAmount)}</TotalAmountSuccess>
            else ()
        }
        {
            if ($responseService/consultarDetalleLoteResponseData/errorAmount)
            then <TotalAmountError>{fn:data($responseService/consultarDetalleLoteResponseData/errorAmount)}</TotalAmountError>
            else ()
        }
        {
            if ($responseService/consultarDetalleLoteResponseData/status)
            then <Status>{fn:data($responseService/consultarDetalleLoteResponseData/status)}</Status>
            else ()
        }
        {
            if ($responseService/consultarDetalleLoteResponseData/statusDescription)
            then <StatusDesc>{fn:data($responseService/consultarDetalleLoteResponseData/statusDescription)}</StatusDesc>
            else ()
        }
        <PagingInfo>
            {
                if ($responseService/paging/initialRecord)
                then <InitialRecord>{fn:data($responseService/paging/initialRecord)}</InitialRecord>
                else ()
            }
            <Page>{fn:data($responseService/paging/page)}</Page>
            <PageSize>{fn:data($responseService/paging/pageSize)}</PageSize>
            {
                if ($responseService/paging/pageCount)
                then <PageCount>{fn:data($responseService/paging/pageCount)}</PageCount>
                else ()
            }
            {
                if ($responseService/paging/recordReturned)
                then <RecordsReturned>{fn:data($responseService/paging/recordReturned)}</RecordsReturned>
                else ()
            }
            {
                if ($responseService/paging/recordTotal)
                then <RecordsTotal>{fn:data($responseService/paging/recordTotal)}</RecordsTotal>
                else ()
            }
        </PagingInfo>
        {
            for $consultarDetalleLoteResponseDetails in $responseService/consultarDetalleLoteResponseDetails
            return 
            <Transactions>
                {
                    if ($consultarDetalleLoteResponseDetails/id)
                    then <Id>{fn:data($consultarDetalleLoteResponseDetails/id)}</Id>
                    else ()
                }
                {
                    if ($consultarDetalleLoteResponseDetails/paymentType)
                    then <PaymentType>{fn:data($consultarDetalleLoteResponseDetails/paymentType)}</PaymentType>
                    else ()
                }
                {
                    if ($consultarDetalleLoteResponseDetails/paymentTypeDescription)
                    then <PaymentTypeDesc>{fn:data($consultarDetalleLoteResponseDetails/paymentTypeDescription)}</PaymentTypeDesc>
                    else ()
                }
                {
                    if ($consultarDetalleLoteResponseDetails/txnReference)
                    then <TxnReference>{fn:data($consultarDetalleLoteResponseDetails/txnReference)}</TxnReference>
                    else ()
                }
                {
                    if ($consultarDetalleLoteResponseDetails/debitAccount)
                    then <DebitAccount>{fn:data($consultarDetalleLoteResponseDetails/debitAccount)}</DebitAccount>
                    else ()
                }
                {
                    if ($consultarDetalleLoteResponseDetails/creditAccount)
                    then <CreditAccount>{fn:data($consultarDetalleLoteResponseDetails/creditAccount)}</CreditAccount>
                    else ()
                }
                {
                    if ($consultarDetalleLoteResponseDetails/destinationBank)
                    then <DestinationBank>{fn:data($consultarDetalleLoteResponseDetails/destinationBank)}</DestinationBank>
                    else ()
                }
                {
                    if ($consultarDetalleLoteResponseDetails/destinationBankName)
                    then <DestinationBankName>{fn:data($consultarDetalleLoteResponseDetails/destinationBankName)}</DestinationBankName>
                    else ()
                }
                {
                    if ($consultarDetalleLoteResponseDetails/creditCurrency)
                    then <CreditCurrency>{fn:data($consultarDetalleLoteResponseDetails/creditCurrency)}</CreditCurrency>
                    else ()
                }
                {
                    if ($consultarDetalleLoteResponseDetails/currency)
                    then <Currency>{fn:data($consultarDetalleLoteResponseDetails/currency)}</Currency>
                    else ()
                }
                {
                    if ($consultarDetalleLoteResponseDetails/amount)
                    then <Amount>{fn:data($consultarDetalleLoteResponseDetails/amount)}</Amount>
                    else ()
                }
                {
                    if ($consultarDetalleLoteResponseDetails/creditAccountType)
                    then <CreditAccountType>{fn:data($consultarDetalleLoteResponseDetails/creditAccountType)}</CreditAccountType>
                    else ()
                }
                {
                    if ($consultarDetalleLoteResponseDetails/beneficiary)
                    then <Beneficiary>{fn:data($consultarDetalleLoteResponseDetails/beneficiary)}</Beneficiary>
                    else ()
                }
                {
                    if ($consultarDetalleLoteResponseDetails/documentNumber)
                    then <DocumentNumber>{fn:data($consultarDetalleLoteResponseDetails/documentNumber)}</DocumentNumber>
                    else ()
                }
                {
                    if ($consultarDetalleLoteResponseDetails/supplierId)
                    then <SupplierId>{fn:data($consultarDetalleLoteResponseDetails/supplierId)}</SupplierId>
                    else ()
                }
                {
                    if ($consultarDetalleLoteResponseDetails/status)
                    then <Status>{fn:data($consultarDetalleLoteResponseDetails/status)}</Status>
                    else ()
                }
                {
                    if ($consultarDetalleLoteResponseDetails/statusDescription)
                    then <StatusDesc>{fn:data($consultarDetalleLoteResponseDetails/statusDescription)}</StatusDesc>
                    else ()
                }
                {
                    if ($consultarDetalleLoteResponseDetails/description)
                    then <Description>{fn:data($consultarDetalleLoteResponseDetails/description)}</Description>
                    else ()
                }
                {
                    if ($consultarDetalleLoteResponseDetails/withdrawalBranch)
                    then <WithdrawalBranch>{fn:data($consultarDetalleLoteResponseDetails/withdrawalBranch)}</WithdrawalBranch>
                    else ()
                }
                {
                    if ($consultarDetalleLoteResponseDetails/withdrawalBranchName)
                    then <WithdrawalBranchName>{fn:data($consultarDetalleLoteResponseDetails/withdrawalBranchName)}</WithdrawalBranchName>
                    else ()
                }
                {
                    if ($consultarDetalleLoteResponseDetails/externalReference)
                    then <ExternalReference>{fn:data($consultarDetalleLoteResponseDetails/externalReference)}</ExternalReference>
                    else ()
                }
                {
                    if ($consultarDetalleLoteResponseDetails/code)
                    then <ErrorCode>{fn:data($consultarDetalleLoteResponseDetails/code)}</ErrorCode>
                    else ()
                }
                {
                    if ($consultarDetalleLoteResponseDetails/message)
                    then <ErrorMessage>{fn:data($consultarDetalleLoteResponseDetails/message)}</ErrorMessage>
                    else ()
                }
                {
                    if ($consultarDetalleLoteResponseDetails/billInfo)
                    then 
                    <BillInfo>
                        {
                            if ($consultarDetalleLoteResponseDetails/billInfo/contractName)
                            then <ContractName>{fn:data($consultarDetalleLoteResponseDetails/billInfo/contractName)}</ContractName>
                            else ()
                        }
                        {
                            if ($consultarDetalleLoteResponseDetails/billInfo/debtorCode)
                            then <DebtorCode>{fn:data($consultarDetalleLoteResponseDetails/billInfo/debtorCode)}</DebtorCode>
                            else ()
                        }
                        {
                            if ($consultarDetalleLoteResponseDetails/billInfo/debtorName)
                            then <DebtorName>{fn:data($consultarDetalleLoteResponseDetails/billInfo/debtorName)}</DebtorName>
                            else ()
                        }
                        {
                            if ($consultarDetalleLoteResponseDetails/billInfo/billDetail)
                            then <BillDetail>{fn:data($consultarDetalleLoteResponseDetails/billInfo/billDetail)}</BillDetail>
                            else ()
                        }
                    </BillInfo>
                    else ()
                }
            </Transactions>
        }
    </ns2:getBatchDetailResponse>
};

local:func($responseService, $globalId)