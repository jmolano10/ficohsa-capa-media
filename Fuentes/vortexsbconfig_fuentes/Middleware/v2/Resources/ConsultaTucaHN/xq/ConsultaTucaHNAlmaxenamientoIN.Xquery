<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaBuroTucaHN_Almacenamientodb";
(:: import schema at "../../../BusinessServices/BuroTucaHN/AlmacenamientoBuroTucaHN/xsd/ConsultaBuroTucaHN_Almacenamientodb_sp.xsd" ::)

declare variable $identidad  as xs:string external;
declare variable $xml        as xs:string external;

declare function local:func(
    $identidad as xs:string,
    $xml       as xs:string
) as element() (:: schema-element(ns1:InputParameters) ::) {

    <InputParameters>
        <P_IDENTIDAD>{ fn:data($identidad) }</P_IDENTIDAD>
        <P_XML_RESPONSE>{ fn:data($xml) }</P_XML_RESPONSE>
    </InputParameters>
};

local:func($identidad, $xml)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../../BusinessServices/BuroTucaHN/AlmacenamientoBuroTucaHN/xsd/ConsultaBuroTucaHN_Almacenamientodb_sp.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/BuroTucaHN/AlmacenamientoBuroTucaHN/xsd/ConsultaBuroTucaHN_Almacenamientodb_sp"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>