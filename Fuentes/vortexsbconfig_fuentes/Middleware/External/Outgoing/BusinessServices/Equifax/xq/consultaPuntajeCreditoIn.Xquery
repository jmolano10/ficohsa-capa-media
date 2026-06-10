<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:ScoreRequest" location="../wsdl/consultaPuntajeCredito.wsdl" ::)

declare namespace ns0 = "http://wsscore.equifax.com.hn";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/Equifax/xq/consultaPuntajeCreditoIn/";

declare function xf:consultaPuntajeCreditoIn($username as xs:string,
    $password as xs:string,
    $documentType as xs:string,
    $documentId as xs:string)
    as element(ns0:ScoreRequest) {
        <ns0:ScoreRequest>
            <ns0:request>
                <ns0:usuario>{ $username }</ns0:usuario>
                <ns0:clave>{ $password }</ns0:clave>
                <ns0:tipoDocumento>{ $documentType }</ns0:tipoDocumento>
                <ns0:documento>{ $documentId }</ns0:documento>
            </ns0:request>
        </ns0:ScoreRequest>
};

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $documentType as xs:string external;
declare variable $documentId as xs:string external;

xf:consultaPuntajeCreditoIn($username,
    $password,
    $documentType,
    $documentId)]]></con:xquery>
    <con:dependency location="../wsdl/consultaPuntajeCredito.wsdl">
        <con:wsdl ref="Middleware/External/Outgoing/BusinessServices/Equifax/wsdl/consultaPuntajeCredito"/>
    </con:dependency>
</con:xqueryEntry>