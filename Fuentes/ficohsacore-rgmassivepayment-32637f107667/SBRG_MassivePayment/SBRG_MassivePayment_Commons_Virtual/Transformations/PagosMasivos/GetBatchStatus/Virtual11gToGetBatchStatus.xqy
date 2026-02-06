xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
(:: import schema at "../../../Schemas/PagosMasivos/pagosMasivosTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../../../../SBRG_MassivePayment_GetBatchStatus/Schemas/GetBatchStatusTypes.xsd" ::)

declare variable $consultaEstadoLote as element() (:: schema-element(ns1:consultaEstadoLote) ::) external;
declare variable $SourceBank as xs:string external;
declare variable $DestinationBank as xs:string external;

declare function local:func(
    $consultaEstadoLote as element() (:: schema-element(ns1:consultaEstadoLote) ::),
    $SourceBank as xs:string, 
    $DestinationBank as xs:string
    ) as element() (:: schema-element(ns2:getBatchStatus) ::) {
    <ns2:getBatchStatus>
        <GeneralInfo>
            <SourceBank>{fn:data($SourceBank)}</SourceBank>
            <DestinationBank>{fn:data($DestinationBank)}</DestinationBank>
        </GeneralInfo>
        <CustomerId>{fn:data($consultaEstadoLote/CUSTOMER_ID)}</CustomerId>
        <QueryType>BANK_BATCH_ID</QueryType>
        <QueryValue>{fn:data($consultaEstadoLote/BANK_BATCH_ID)}</QueryValue>
    </ns2:getBatchStatus>
};

local:func($consultaEstadoLote, $SourceBank, $DestinationBank)