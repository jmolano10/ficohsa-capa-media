xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
(:: import schema at "../../../Schemas/PagosMasivos/pagosMasivosTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../../../../SBRG_MassivePayment_UploadBatch/Schemas/UploadBatchTypes.xsd" ::)

declare variable $responseService as element() (:: schema-element(ns1:uploadBatchResponse) ::) external;

declare function local:func($responseService as element() (:: schema-element(ns1:uploadBatchResponse) ::)) as element() (:: schema-element(ns2:pagosMasivosResponse) ::) {
    <ns2:pagosMasivosResponse>
        {
            if ($responseService/GlobalId)
            then <GLOBAL_ID>{fn:data($responseService/GlobalId)}</GLOBAL_ID>
            else ()
        }
        {
            if ($responseService/CustomerId)
            then <CUSTOMER_ID>{fn:data($responseService/CustomerId)}</CUSTOMER_ID>
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
                        if ($Batches/Status)
                        then <STATUS>{fn:data($Batches/Status)}</STATUS>
                        else ()
                    }
                    {
                        let $code := fn:data($Batches/TrxStatus[1]/ErrorMessages[1]/Code/text())
                        return
                        if ($code != '')
                        then <ERROR_CODE>{$code}</ERROR_CODE>
                        else ()
                    }
                    {
                        let $id := fn:data($Batches/TrxStatus[1]/Id/text())
                        let $code := fn:data($Batches/TrxStatus[1]/ErrorMessages[1]/Code/text())
                        let $message := fn:data($Batches/TrxStatus[1]/ErrorMessages[1]/Message/text())
                        return
                        if ($id != '') then
                            if($id = $code) then
                                <ERROR_MESSAGE>{$message}</ERROR_MESSAGE>
                            else
                                <ERROR_MESSAGE>{fn:concat("Transacción:",$id," ",$message)}</ERROR_MESSAGE>
                        else ()
                    }
                </BATCH>
            }
        </BATCHES>
    </ns2:pagosMasivosResponse>
};

local:func($responseService)