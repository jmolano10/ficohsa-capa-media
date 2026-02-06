xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
(:: import schema at "../../../Schemas/PagosMasivos/pagosMasivosTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../../../../SBRG_MassivePayment_AuthorizeBatch/Schemas/AuthorizeBatchTypes.xsd" ::)

declare variable $responseService as element() (:: schema-element(ns1:authorizeBatchResponse) ::) external;

declare function local:func(
    $responseService as element() (:: schema-element(ns1:authorizeBatchResponse) ::)
    ) as element() (:: schema-element(ns2:autorizarLoteResponse) ::) {
    <ns2:autorizarLoteResponse>
        <BATCHES>
            <BATCH>
                <BANK_BATCH_ID>{fn:data($responseService/BankBatchId)}</BANK_BATCH_ID>
                <STATUS>{fn:data($responseService/Status)}</STATUS>
                <STATUS_DESC>{fn:data($responseService/StatusDescription)}</STATUS_DESC>
                <DETAIL_ERRORS>
                    {
                        for $DetailErrors in $responseService/DetailErrors
                        return 
                        <DETAIL_ERROR>
                            <ACCOUNT_NUMBER>{fn:data($DetailErrors/AccountNumber)}</ACCOUNT_NUMBER>
                            <BATCH_AMOUNT>{fn:data($DetailErrors/BatchAmount)}</BATCH_AMOUNT>
                            <TAX_AMOUNT>{fn:data($DetailErrors/TaxAmount)}</TAX_AMOUNT>
                        </DETAIL_ERROR>
                    }
                </DETAIL_ERRORS>
            </BATCH>
        </BATCHES>
    </ns2:autorizarLoteResponse>
};

local:func($responseService)