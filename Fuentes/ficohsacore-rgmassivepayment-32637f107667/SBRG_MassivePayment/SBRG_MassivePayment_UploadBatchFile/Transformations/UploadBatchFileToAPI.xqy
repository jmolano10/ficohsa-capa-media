xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/regional/massivePayment/apiPagosMasivosTypes";
(:: import schema at "../../SBRG_MassivePayment_Commons/Schemas/APIPagosMasivosTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/UploadBatchFileTypes.xsd" ::)

declare variable $uploadBatchFile as element() (:: schema-element(ns1:uploadBatchFile) ::) external;

declare function local:func(
    $uploadBatchFile as element() (:: schema-element(ns1:uploadBatchFile) ::)
    ) as element() (:: schema-element(ns2:CargarArchivoLote) ::) {
    <ns2:CargarArchivoLote>
        <requestHeader>
            <sourceBank>{fn:data($uploadBatchFile/GeneralInfo/SourceBank)}</sourceBank>
            <destinationBank>{fn:data($uploadBatchFile/GeneralInfo/DestinationBank)}</destinationBank>
            <customerId>{fn:data($uploadBatchFile/CustomerId)}</customerId>
            <userName>{fn:data($uploadBatchFile/GeneralInfo/ApplicationId)}</userName>
            <userId>{fn:data($uploadBatchFile/UserId)}</userId>
        </requestHeader>
        {
            if ($uploadBatchFile/Ticket)
            then <ticket>{fn:data($uploadBatchFile/Ticket)}</ticket>
            else ()
        }
        <operationType>{fn:data($uploadBatchFile/Type)}</operationType>
        {
            if ($uploadBatchFile/Concept)
            then <concept>{fn:data($uploadBatchFile/Concept)}</concept>
            else ()
        }
        {
            if ($uploadBatchFile/ApplicationDate)
            then <applicationDate>{fn:data($uploadBatchFile/ApplicationDate)}</applicationDate>
            else ()
        }
        {
            if ($uploadBatchFile/EncryptedFile)
            then <encrypted>{fn:data($uploadBatchFile/EncryptedFile)}</encrypted>
            else ()
        }
        <file>{fn:data($uploadBatchFile/FlatFile)}</file>
        <fileName>{fn:data($uploadBatchFile/FileName)}</fileName>
    </ns2:CargarArchivoLote>
};

local:func($uploadBatchFile)