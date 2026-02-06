xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/GetBatchStatusTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/massivePayment/apiPagosMasivosTypes";
(:: import schema at "../../SBRG_MassivePayment_Commons/Schemas/APIPagosMasivosTypes.xsd" ::)

declare variable $getBatcStatus as element() (:: schema-element(ns1:getBatchStatus) ::) external;

declare function local:getBatcStatus(
    $getBatcStatus as element() (:: schema-element(ns1:getBatchStatus) ::)
    ) as element() (:: schema-element(ns2:ConsultarEstadoLote) ::) {
    <ns2:ConsultarEstadoLote>
        <requestHeader>
            <sourceBank>{fn:data($getBatcStatus/GeneralInfo/SourceBank)}</sourceBank>
            <destinationBank>{fn:data($getBatcStatus/GeneralInfo/DestinationBank)}</destinationBank>
            <customerId>{fn:data($getBatcStatus/CustomerId)}</customerId>
            <userName>{fn:data($getBatcStatus/GeneralInfo/ApplicationId)}</userName>
        </requestHeader>
        <queryType>{fn:data($getBatcStatus/QueryType)}</queryType>
        <queryValue>{fn:data($getBatcStatus/QueryValue)}</queryValue>
    </ns2:ConsultarEstadoLote>
};

local:getBatcStatus($getBatcStatus)