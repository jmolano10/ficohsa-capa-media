xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
(:: import schema at "../../../Schemas/PagosMasivos/pagosMasivosTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../../../../SBRG_MassivePayment_GetCustomerBatch/Schemas/GetCustomerBatchTypes.xsd" ::)

declare variable $responseService as element() (:: schema-element(ns1:getCustomerBatchResponse) ::) external;

declare function local:func($responseService as element() (:: schema-element(ns1:getCustomerBatchResponse) ::)) as element() (:: schema-element(ns2:consultaLotesClienteResponse) ::) {
    <ns2:consultaLotesClienteResponse>
        {
            if ($responseService/CustomerId)
            then <CUSTOMER_ID>{fn:data($responseService/CustomerId)}</CUSTOMER_ID>
            else ()
        }
        {
            if ($responseService/BeginDate)
            then <BEGIN_DATE>{fn:data($responseService/BeginDate)}</BEGIN_DATE>
            else ()
        }
        {
            if ($responseService/EndDate)
            then <END_DATE>{fn:data($responseService/EndDate)}</END_DATE>
            else ()
        }
        <BATCHES>
            {
                for $Batches in $responseService/Batches
                return 
                <BATCH>
                    {
                        if ($Batches/BankBatchId)
                        then <BANK_BATCH_ID>{fn:data($Batches/BankBatchId)}</BANK_BATCH_ID>
                        else ()
                    }
                    {
                        if ($Batches/CustomerBatchId)
                        then <CUSTOMER_BATCH_ID>{fn:data($Batches/CustomerBatchId)}</CUSTOMER_BATCH_ID>
                        else ()
                    }
                    {
                        if ($Batches/Type)
                        then <TYPE>{fn:data($Batches/Type)}</TYPE>
                        else ()
                    }
                    {
                        if ($Batches/TypeDesc)
                        then <TYPE_DESC>{fn:data($Batches/TypeDesc)}</TYPE_DESC>
                        else ()
                    }
                    {
                        if ($Batches/UploadDate)
                        then <UPLOAD_DATE>{fn:data($Batches/UploadDate)}</UPLOAD_DATE>
                        else ()
                    }
                    {
                        if ($Batches/ApplicationDate)
                        then <APPLICATION_DATE>{fn:data($Batches/ApplicationDate)}</APPLICATION_DATE>
                        else ()
                    }
                    {
                        if ($Batches/NumberOfTransactions)
                        then <NUMBER_OF_TRANSACTIONS>{fn:data($Batches/NumberOfTransactions)}</NUMBER_OF_TRANSACTIONS>
                        else ()
                    }
                    {
                        if ($Batches/NumberOfTransactionsSuccess)
                        then <NUMBER_OF_TRANSACTIONS_SUCCESS>{fn:data($Batches/NumberOfTransactionsSuccess)}</NUMBER_OF_TRANSACTIONS_SUCCESS>
                        else ()
                    }
                    {
                        if ($Batches/NumberOfTransactionsError)
                        then <NUMBER_OF_TRANSACTIONS_ERROR>{fn:data($Batches/NumberOfTransactionsError)}</NUMBER_OF_TRANSACTIONS_ERROR>
                        else ()
                    }
                    {
                        if ($Batches/TotalAmount)
                        then <TOTAL_AMOUNT>{fn:data($Batches/TotalAmount)}</TOTAL_AMOUNT>
                        else ()
                    }
                    {
                        if ($Batches/TotalAmountError)
                        then <TOTAL_AMOUNT_ERROR>{fn:data($Batches/TotalAmountError)}</TOTAL_AMOUNT_ERROR>
                        else ()
                    }
                    {
                        if ($Batches/Status)
                        then <STATUS>{fn:data($Batches/Status)}</STATUS>
                        else ()
                    }
                    {
                        if ($Batches/StatusDesc)
                        then <STATUS_DESC>{fn:data($Batches/StatusDesc)}</STATUS_DESC>
                        else ()
                    }
                </BATCH>
            }
        </BATCHES>
    </ns2:consultaLotesClienteResponse>
};

local:func($responseService)