xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/RegisterExternalBatchTypes.xsd" ::)
declare namespace ns2="urn:tailored.icbanking.services.bulk";
(:: import schema at "../Resources/CustomBulkService.wsdl" ::)

declare variable $registerExternalBatch as element() (:: schema-element(ns1:registerExternalBatch) ::) external;

declare function local:func($registerExternalBatch as element() (:: schema-element(ns1:registerExternalBatch) ::)) as element() (:: schema-element(ns2:ProcesarLotesMessageIn) ::) {
    <ns2:ProcesarLotesMessageIn>
        <ns2:ApplicationDate>{fn:data($registerExternalBatch/ApplicationDate)}</ns2:ApplicationDate>
        <ns2:AuthorizationRequired>{fn:data($registerExternalBatch/AuthorizationRequired)}</ns2:AuthorizationRequired>
        <ns2:BatchId>{fn:data($registerExternalBatch/BankBatchId)}</ns2:BatchId>
        <ns2:ClientId>{fn:data($registerExternalBatch/CustomerId)}</ns2:ClientId>
        {
            if ($registerExternalBatch/Concept)
            then <ns2:Concept>{fn:data($registerExternalBatch/Concept)}</ns2:Concept>
            else ()
        }
        <ns2:DocumentNumber>{fn:data($registerExternalBatch/LegalId)}</ns2:DocumentNumber>
        <ns2:DocumentType>{fn:data($registerExternalBatch/DocumentType)}</ns2:DocumentType>
        {
            if ($registerExternalBatch/NotificationEmail)
            then <ns2:NotificationTo>{fn:data($registerExternalBatch/NotificationEmail)}</ns2:NotificationTo>
            else ()
        }
        <ns2:Type>{fn:data($registerExternalBatch/Type)}</ns2:Type>
        <ns2:UploadDate>{fn:data($registerExternalBatch/UploadDate)}</ns2:UploadDate>
    </ns2:ProcesarLotesMessageIn>
};

local:func($registerExternalBatch)
