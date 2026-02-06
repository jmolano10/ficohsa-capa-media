xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/regional/massivePayment/apiPagosMasivosTypes";
(:: import schema at "../../SBRG_MassivePayment_Commons/Schemas/APIPagosMasivosTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/AuthorizeBatchTypes.xsd" ::)

declare variable $authorizeBatch as element() (:: schema-element(ns1:authorizeBatch) ::) external;

declare function local:func(
    $authorizeBatch as element() (:: schema-element(ns1:authorizeBatch) ::)
    ) as element() (:: schema-element(ns2:AutorizarLote) ::) {
    <ns2:AutorizarLote>
        <requestHeader>
            <sourceBank>{fn:data($authorizeBatch/GeneralInfo/SourceBank)}</sourceBank>
            <destinationBank>{fn:data($authorizeBatch/GeneralInfo/DestinationBank)}</destinationBank>
            <customerId>{fn:data($authorizeBatch/CustomerId)}</customerId>
            <userName>{fn:data($authorizeBatch/GeneralInfo/ApplicationId)}</userName>
            <userId>{fn:data($authorizeBatch/UserId)}</userId>
        </requestHeader>
        <queryType>{fn:data($authorizeBatch/QueryType)}</queryType>
        <queryValue>{fn:data($authorizeBatch/QueryValue)}</queryValue>
        {
            if ($authorizeBatch/ApplicationDate)
            then <applicationDate>{fn:data($authorizeBatch/ApplicationDate)}</applicationDate>
            else ()
        }
    </ns2:AutorizarLote>
};

local:func($authorizeBatch)