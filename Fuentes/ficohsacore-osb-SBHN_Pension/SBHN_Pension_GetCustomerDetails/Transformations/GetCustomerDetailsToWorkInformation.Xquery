<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/pension";
(:: import schema at "../Schemas/CustomerWorkTypes.xsd", 
                     "../Schemas/GetCustomerDetailsTypes.xsd" ::)

declare variable $legalIdType as xs:string external;
declare variable $legalId as xs:string external;

declare function local:func(
  $legalIdType as xs:string,
  $legalId as xs:string
) as element() (:: schema-element(ns1:customerWorkRequest) ::) {
    <ns1:customerWorkRequest>
        <tipoIdentificacion>{ $legalIdType }</tipoIdentificacion>
        <numeroIdentificacion>{ $legalId }</numeroIdentificacion>
    </ns1:customerWorkRequest>
};

local:func($legalIdType, $legalId)]]></con:xquery>
</con:xqueryEntry>