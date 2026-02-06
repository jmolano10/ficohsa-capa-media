xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/regional/massivePayment/apiPagosMasivosTypes";
(:: import schema at "../../SBRG_MassivePayment_Commons/Schemas/APIPagosMasivosTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/GetBatchTransactionTypes.xsd" ::)

declare variable $getBatchTransaction as element() (:: schema-element(ns1:getBatchTransaction) ::) external;

declare function local:func(
    $getBatchTransaction as element() (:: schema-element(ns1:getBatchTransaction) ::)
    ) as element() (:: schema-element(ns2:ConsultarTransaccionLote) ::) {
    <ns2:ConsultarTransaccionLote>
        <requestHeader>
            <sourceBank>{fn:data($getBatchTransaction/GeneralInfo/SourceBank)}</sourceBank>
            <destinationBank>{fn:data($getBatchTransaction/GeneralInfo/DestinationBank)}</destinationBank>
            <customerId>{fn:data($getBatchTransaction/CustomerId)}</customerId>
            <userName>{fn:data($getBatchTransaction/GeneralInfo/ApplicationId)}</userName>
        </requestHeader>
        <queryType>{fn:data($getBatchTransaction/QueryType)}</queryType>
        <queryValue>{fn:data($getBatchTransaction/QueryValue)}</queryValue>
    </ns2:ConsultarTransaccionLote>
};

local:func($getBatchTransaction)