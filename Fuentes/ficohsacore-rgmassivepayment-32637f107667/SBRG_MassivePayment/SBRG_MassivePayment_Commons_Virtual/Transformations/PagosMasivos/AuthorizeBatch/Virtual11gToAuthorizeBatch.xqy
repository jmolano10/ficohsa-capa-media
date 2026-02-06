xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
(:: import schema at "../../../Schemas/PagosMasivos/pagosMasivosTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../../../../SBRG_MassivePayment_AuthorizeBatch/Schemas/AuthorizeBatchTypes.xsd" ::)

declare variable $autorizarLote as element() (:: schema-element(ns1:autorizarLote) ::) external;
declare variable $SourceBank as xs:string external;
declare variable $DestinationBank as xs:string external;

declare function local:func(
    $autorizarLote as element() (:: schema-element(ns1:autorizarLote) ::),
    $SourceBank as xs:string, 
    $DestinationBank as xs:string
    ) as element() (:: schema-element(ns2:authorizeBatch) ::) {
    <ns2:authorizeBatch>
        <GeneralInfo>
            <SourceBank>{fn:data($SourceBank)}</SourceBank>
            <DestinationBank>{fn:data($DestinationBank)}</DestinationBank>
        </GeneralInfo>
        <CustomerId>{fn:data($autorizarLote/CUSTOMER_ID)}</CustomerId>
        <UserId>{fn:data($autorizarLote/USER_ID)}</UserId>
        <QueryType>BANK_BATCH_ID</QueryType>
        <QueryValue>{fn:data($autorizarLote/BATCHES/BATCH/BANK_BATCH_ID)}</QueryValue>
        {
            if ($autorizarLote/BATCHES/BATCH/APPLICATION_DATE)
            then <ApplicationDate>{fn:data($autorizarLote/BATCHES/BATCH/APPLICATION_DATE)}</ApplicationDate>
            else ()
        }
    </ns2:authorizeBatch>
};

local:func($autorizarLote, $SourceBank, $DestinationBank)