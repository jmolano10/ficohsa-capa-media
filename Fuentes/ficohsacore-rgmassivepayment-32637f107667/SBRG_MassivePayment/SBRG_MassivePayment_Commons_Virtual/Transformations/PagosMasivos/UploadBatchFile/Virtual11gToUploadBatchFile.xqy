xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
(:: import schema at "../../../Schemas/PagosMasivos/pagosMasivosTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../../../../SBRG_MassivePayment_UploadBatchFile/Schemas/UploadBatchFileTypes.xsd" ::)

declare variable $cargarArchivoLote as element() (:: schema-element(ns1:cargarArchivoLote) ::) external;
declare variable $SourceBank as xs:string external;
declare variable $DestinationBank as xs:string external;

declare function local:func(
    $cargarArchivoLote as element() (:: schema-element(ns1:cargarArchivoLote) ::),
    $SourceBank as xs:string, 
    $DestinationBank as xs:string
    ) as element() (:: schema-element(ns2:uploadBatchFile) ::) {
    <ns2:uploadBatchFile>
        <GeneralInfo>
            <SourceBank>{fn:data($SourceBank)}</SourceBank>
            <DestinationBank>{fn:data($DestinationBank)}</DestinationBank>
        </GeneralInfo>
        <CustomerId>{fn:data($cargarArchivoLote/CUSTOMER_ID)}</CustomerId>
        <UserId>{fn:data($cargarArchivoLote/USER_ID)}</UserId>
        <Type>{fn:data($cargarArchivoLote/TYPE)}</Type>
        {
            if ($cargarArchivoLote/CONCEPT)
            then <Concept>{fn:data($cargarArchivoLote/CONCEPT)}</Concept>
            else ()
        }
        {
            if ($cargarArchivoLote/APPLICATION_DATE)
            then <ApplicationDate>{fn:data($cargarArchivoLote/APPLICATION_DATE)}</ApplicationDate>
            else ()
        }
        {
            if ($cargarArchivoLote/ENCRYPTED_FILE) then
                if (fn:data($cargarArchivoLote/ENCRYPTED_FILE)='YES') then
                    <EncryptedFile>true</EncryptedFile>
                else
                    <EncryptedFile>false</EncryptedFile>
            else ()
        }
        <FlatFile>{fn:data($cargarArchivoLote/FLAT_FILE)}</FlatFile>
        <FileName>{fn:data($cargarArchivoLote/FILE_NAME)}</FileName>
    </ns2:uploadBatchFile>
};

local:func($cargarArchivoLote, $SourceBank, $DestinationBank)