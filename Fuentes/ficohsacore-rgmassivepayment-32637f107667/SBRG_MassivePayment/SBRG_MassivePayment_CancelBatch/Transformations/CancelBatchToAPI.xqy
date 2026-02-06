xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/regional/massivePayment/apiPagosMasivosTypes";
(:: import schema at "../../SBRG_MassivePayment_Commons/Schemas/APIPagosMasivosTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/CancelBatchTypes.xsd" ::)

declare variable $cancelBatch as element() (:: schema-element(ns1:cancelBatch) ::) external;

declare function local:func(
    $cancelBatch as element() (:: schema-element(ns1:cancelBatch) ::)
    ) as element() (:: schema-element(ns2:CancelarLote) ::) {
    <ns2:CancelarLote>
        <requestHeader>
            <sourceBank>{fn:data($cancelBatch/GeneralInfo/SourceBank)}</sourceBank>
            <destinationBank>{fn:data($cancelBatch/GeneralInfo/DestinationBank)}</destinationBank>
            <customerId>{fn:data($cancelBatch/CustomerId)}</customerId>
            <userName>{fn:data($cancelBatch/GeneralInfo/ApplicationId)}</userName>
            <userId>{fn:data($cancelBatch/UserId)}</userId>
        </requestHeader>
        <queryType>{fn:data($cancelBatch/QueryType)}</queryType>
        <queryValue>{fn:data($cancelBatch/QueryValue)}</queryValue>
    </ns2:CancelarLote>
};

local:func($cancelBatch)