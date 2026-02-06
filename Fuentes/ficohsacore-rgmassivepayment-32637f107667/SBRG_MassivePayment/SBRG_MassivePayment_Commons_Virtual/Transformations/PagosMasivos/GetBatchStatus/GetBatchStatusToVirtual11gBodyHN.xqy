xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
(:: import schema at "../../../Schemas/PagosMasivos/pagosMasivosTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../../../../SBRG_MassivePayment_GetBatchStatus/Schemas/GetBatchStatusTypes.xsd" ::)

declare variable $responseService as element() (:: schema-element(ns1:getBatchStatusResponse) ::) external;

declare function local:func(
    $responseService as element() (:: schema-element(ns1:getBatchStatusResponse) ::)
    ) as element() (:: schema-element(ns2:consultaEstadoLoteResponse) ::) {
    <ns2:consultaEstadoLoteResponse>
        {
            if ($responseService/BankBatchId)
            then <BANK_BATCH_ID>{fn:data($responseService/BankBatchId)}</BANK_BATCH_ID>
            else ()
        }
        {
            if ($responseService/CustomerId)
            then <CUSTOMER_ID>{fn:data($responseService/CustomerId)}</CUSTOMER_ID>
            else ()
        }
        {
            if ($responseService/CustomerName)
            then <CUSTOMER_NAME>{fn:data($responseService/CustomerName)}</CUSTOMER_NAME>
            else ()
        }
        {
            if ($responseService/Status)
            then <STATUS>{fn:data($responseService/Status)}</STATUS>
            else ()
        }
        {
            if ($responseService/StatusDescription)
            then <STATUS_DESC>{fn:data($responseService/StatusDescription)}</STATUS_DESC>
            else ()
        }
        {
            if ($responseService/Optimistic) then
                if (fn:string(fn:data($responseService/Optimistic)) = 'true') then
                    <OPTIMISTIC>YES</OPTIMISTIC>
                else if (fn:string(fn:data($responseService/Optimistic)) = 'false') then
                    <OPTIMISTIC>NO</OPTIMISTIC>
                else ()
            else ()
        }
        <ACCOUNTS>
            {
                for $Accounts in $responseService/Accounts
                return 
                <ACCOUNT>
                    {
                        if ($Accounts/DebitAccount)
                        then <DEBIT_ACCOUNT>{fn:data($Accounts/DebitAccount)}</DEBIT_ACCOUNT>
                        else ()
                    }
                    {
                        if ($Accounts/Amount)
                        then <AMOUNT>{fn:data($Accounts/Amount)}</AMOUNT>
                        else ()
                    }
                    {
                        if ($Accounts/Currency)
                        then <CURRENCY>{fn:data($Accounts/Currency)}</CURRENCY>
                        else ()
                    }</ACCOUNT>
            }</ACCOUNTS>
        <PAYMENTS>
            {
                for $Payments in $responseService/Payments
                return 
                <PAYMENT>
                    {
                        if ($Payments/Currency)
                        then <CURRENCY>{fn:data($Payments/Currency)}</CURRENCY>
                        else ()
                    }
                    {
                        if ($Payments/TotalAmount)
                        then <TOTAL_AMOUNT>{fn:data($Payments/TotalAmount)}</TOTAL_AMOUNT>
                        else ()
                    }
                    {
                        if ($Payments/ExchangeRate)
                        then <EXCHANGE_RATE>{fn:data($Payments/ExchangeRate)}</EXCHANGE_RATE>
                        else ()
                    }</PAYMENT>
            }</PAYMENTS>
        {
            if ($responseService/TotalAmount)
            then <TOTAL_AMOUNT>{fn:data($responseService/TotalAmount)}</TOTAL_AMOUNT>
            else ()
        }
        {
            if ($responseService/TotalAmountError)
            then <TOTAL_AMOUNT_ERROR>{fn:data($responseService/TotalAmountError)}</TOTAL_AMOUNT_ERROR>
            else ()
        }
        {
            if ($responseService/NumberOfTransactions)
            then <NUMBER_OF_TRANSACTIONS>{fn:data($responseService/NumberOfTransactions)}</NUMBER_OF_TRANSACTIONS>
            else ()
        }
        {
            if ($responseService/NumberOfTransactionsSuccess)
            then <NUMBER_OF_TRANSACTIONS_SUCCESS>{fn:data($responseService/NumberOfTransactionsSuccess)}</NUMBER_OF_TRANSACTIONS_SUCCESS>
            else ()
        }
        {
            if ($responseService/NumberOfTransactionsError)
            then <NUMBER_OF_TRANSACTIONS_ERROR>{fn:data($responseService/NumberOfTransactionsError)}</NUMBER_OF_TRANSACTIONS_ERROR>
            else ()
        }
        {
            if ($responseService/ApplicationDate)
            then <APPLICATION_DATE>{fn:data($responseService/ApplicationDate)}</APPLICATION_DATE>
            else ()
        }
        {
            if ($responseService/ProcessInfo)
            then <PROCESS_INFO>{fn:data($responseService/ProcessInfo)}</PROCESS_INFO>
            else ()
        }
    </ns2:consultaEstadoLoteResponse>
};

local:func($responseService)