xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
(:: import schema at "../../../Schemas/PagosMasivos/pagosMasivosTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../../../../SBRG_MassivePayment_GetBatchTransaction/Schemas/GetBatchTransactionTypes.xsd" ::)

declare variable $responseService as element() (:: schema-element(ns1:getBatchTransactionResponse) ::) external;

declare function local:func($responseService as element() (:: schema-element(ns1:getBatchTransactionResponse) ::)) as element() (:: schema-element(ns2:consultaTransaccionLoteResponse) ::) {
    <ns2:consultaTransaccionLoteResponse>
        {
            if ($responseService/CustomerId)
            then <CUSTOMER_ID>{fn:data($responseService/CustomerId)}</CUSTOMER_ID>
            else ()
        }
        {
            if ($responseService/Transaction) then 
                <TRANSACTION>
                    {
                        if ($responseService/Transaction/Id)
                        then <ID>{fn:data($responseService/Transaction/Id)}</ID>
                        else ()
                    }
                    {
                        if ($responseService/Transaction/TxnReference)
                        then <TXN_REFERENCE>{fn:data($responseService/Transaction/TxnReference)}</TXN_REFERENCE>
                        else ()
                    }
                    {
                        if ($responseService/Transaction/BankBatchId)
                        then <BANK_BATCH_ID>{fn:data($responseService/Transaction/BankBatchId)}</BANK_BATCH_ID>
                        else ()
                    }
                    {
                        if ($responseService/Transaction/DebitAccount)
                        then <DEBIT_ACCOUNT>{fn:data($responseService/Transaction/DebitAccount)}</DEBIT_ACCOUNT>
                        else ()
                    }
                    {
                        if ($responseService/Transaction/CreditAccount)
                        then <CREDIT_ACCOUNT>{fn:data($responseService/Transaction/CreditAccount)}</CREDIT_ACCOUNT>
                        else ()
                    }
                    {
                        if ($responseService/Transaction/Amount)
                        then <AMOUNT>{fn:data($responseService/Transaction/Amount)}</AMOUNT>
                        else ()
                    }
                </TRANSACTION>
            else ()
        }
    </ns2:consultaTransaccionLoteResponse>
};

local:func($responseService)