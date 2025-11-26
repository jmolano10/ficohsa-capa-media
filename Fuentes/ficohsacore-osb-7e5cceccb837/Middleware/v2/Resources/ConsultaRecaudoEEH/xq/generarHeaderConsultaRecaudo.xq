(:: pragma bea:global-element-return element="soapenv:Header" location="http://schemas.xmlsoap.org/soap/envelope/" ::)

declare namespace soapenv = "http://schemas.xmlsoap.org/soap/envelope/";
declare namespace con = "http://schemas.enee-pay.hn/contract";

declare function local:crearHeader($apiKey as xs:string,
    $requestId as xs:string,
    $signature as xs:string)
    as element(soapenv:Header) {
        <soapenv:Header xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:con="http://schemas.enee-pay.hn/contract">
            <con:x-api-key>{ $apiKey }</con:x-api-key>
            <con:x-request-id>{ $requestId }</con:x-request-id>
            <con:x-signature>{ $signature }</con:x-signature>
        </soapenv:Header>
};

declare variable $apiKey as xs:string external;
declare variable $requestId as xs:string external;
declare variable $signature as xs:string external;

local:crearHeader($apiKey,
    $requestId,
    $signature)