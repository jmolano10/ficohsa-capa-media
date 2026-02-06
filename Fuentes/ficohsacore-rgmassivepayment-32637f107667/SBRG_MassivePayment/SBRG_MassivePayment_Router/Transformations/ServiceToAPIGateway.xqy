xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/massivePayment/apiPagosMasivosGatewayTypes";
(:: import schema at "../Schemas/ApiPagosMasivosGatewayTypes.xsd" ::)

declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;
declare variable $method as xs:string external;
declare variable $customerId as xs:string external;
declare variable $queryType as xs:string external;
declare variable $queryValue as xs:string external;

declare function local:func(
    $sourceBank as xs:string,
    $destinationBank as xs:string,
    $method as xs:string,
    $customerId as xs:string,
    $queryType as xs:string,
    $queryValue as xs:string
    ) as element() (:: schema-element(ns1:System) ::) {
    <ns1:System>
        <sourceBank>{fn:data($sourceBank)}</sourceBank>
        <destinationBank>{fn:data($destinationBank)}</destinationBank>
        <method>{fn:data($method)}</method>
        <customerId>{fn:data($customerId)}</customerId>
        {
            if (fn:data($queryType)) then
                <queryType>{fn:data($queryType)}</queryType>
            else ()
        }
        {
            if (fn:data($queryValue)) then
                <queryValue>{fn:data($queryValue)}</queryValue>
            else ()
        }
    </ns1:System>
};

local:func($sourceBank, $destinationBank, $method, $customerId, $queryType, $queryValue)