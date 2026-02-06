xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
(:: import schema at "../../../Schemas/PagosMasivos/pagosMasivosTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../../../../SBRG_MassivePayment_UploadBatchFile/Schemas/UploadBatchFileTypes.xsd" ::)

declare variable $responseService as element() (:: schema-element(ns1:uploadBatchFileResponse) ::) external;

declare function local:func($responseService as element() (:: schema-element(ns1:uploadBatchFileResponse) ::)) as element() (:: schema-element(ns2:cargarArchivoLoteResponse) ::) {
    <ns2:cargarArchivoLoteResponse>
        {
            if ($responseService/CustomerId)
            then <CUSTOMER_ID>{fn:data($responseService/CustomerId)}</CUSTOMER_ID>
            else ()
        }
        {
            if ($responseService/BankBatchId)
            then <BANK_BATCH_ID>{fn:data($responseService/BankBatchId)}</BANK_BATCH_ID>
            else ()
        }
        {
            if ($responseService/UploadDate)
            then <UPLOAD_DATE>{fn:substring(fn:string(fn:data($responseService/UploadDate)),0,11)}</UPLOAD_DATE>
            else ()
        }
        {
            if ($responseService/TotalAmount)
            then <TOTAL_AMOUNT>{fn:data($responseService/TotalAmount)}</TOTAL_AMOUNT>
            else ()
        }
        {
            if ($responseService/NumberOfTransactions)
            then <NUMBER_OF_TRANSACTIONS>{fn:data($responseService/NumberOfTransactions)}</NUMBER_OF_TRANSACTIONS>
            else ()
        }
        {
            if ($responseService/Status)
            then <STATUS>{fn:data($responseService/Status)}</STATUS>
            else ()
        }
        <TRX_STATUS>
            {
                for $TrxStatus in $responseService/TrxStatus
                return 
                <TRX>
                    <ID>{fn:data($TrxStatus/Id)}</ID>
                    <ERROR_MESSAGES>
                        {
                            for $ErrorMessages in $TrxStatus/ErrorMessages
                            return <MESSAGE>{fn:data($ErrorMessages/Message)}</MESSAGE>
                        }
                    </ERROR_MESSAGES>
                </TRX>
            }
        </TRX_STATUS>
    </ns2:cargarArchivoLoteResponse>
};

local:func($responseService)