xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
(:: import schema at "../../../Schemas/PagosMasivos/pagosMasivosTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../../../../SBRG_MassivePayment_CancelBatch/Schemas/CancelBatchTypes.xsd" ::)

declare variable $responseService as element() (:: schema-element(ns1:cancelBatchResponse) ::) external;

declare function local:func(
    $responseService as element() (:: schema-element(ns1:cancelBatchResponse) ::)
    ) as element() (:: schema-element(ns2:cancelarLoteResponse) ::) {
    <ns2:cancelarLoteResponse>
        <BANK_BATCH_ID>{fn:data($responseService/BankBatchId)}</BANK_BATCH_ID>
        <STATUS>{fn:data($responseService/Status)}</STATUS>
        <STATUS_DESC>{fn:data($responseService/StatusDescription)}</STATUS_DESC>
    </ns2:cancelarLoteResponse>
};

local:func($responseService)