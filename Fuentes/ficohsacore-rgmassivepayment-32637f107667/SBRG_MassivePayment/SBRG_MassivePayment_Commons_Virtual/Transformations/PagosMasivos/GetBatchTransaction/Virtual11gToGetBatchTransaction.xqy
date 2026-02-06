xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
(:: import schema at "../../../Schemas/PagosMasivos/pagosMasivosTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../../../../SBRG_MassivePayment_GetBatchTransaction/Schemas/GetBatchTransactionTypes.xsd" ::)

declare variable $consultaTransaccionLote as element() (:: schema-element(ns1:consultaTransaccionLote) ::) external;
declare variable $SourceBank as xs:string external;
declare variable $DestinationBank as xs:string external;

declare function local:func(
    $consultaTransaccionLote as element() (:: schema-element(ns1:consultaTransaccionLote) ::),
    $SourceBank as xs:string, 
    $DestinationBank as xs:string) as element() (:: schema-element(ns2:getBatchTransaction) ::) {
    <ns2:getBatchTransaction>
        <GeneralInfo>
            <SourceBank>{fn:data($SourceBank)}</SourceBank>
            <DestinationBank>{fn:data($DestinationBank)}</DestinationBank>
        </GeneralInfo>
        <CustomerId>{fn:data($consultaTransaccionLote/CUSTOMER_ID)}</CustomerId>
        <QueryType>TXN_REFERENCE</QueryType>
        <QueryValue>{fn:data($consultaTransaccionLote/TXN_REFERENCE)}</QueryValue>
    </ns2:getBatchTransaction>
};

local:func($consultaTransaccionLote, $SourceBank, $DestinationBank)