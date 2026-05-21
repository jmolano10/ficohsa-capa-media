<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/utility/constants";
(:: import schema at "../Resources/SBRG_Constants_Commons/Schemas/CustomParameter.xsd" ::)

declare variable $parameterName as xs:string external;

declare function local:func($parameterName as xs:string) as element() (:: schema-element(ns1:GetParameters) ::) {
    &lt;ns1:GetParameters>
        &lt;ns1:parameterName>{fn:data($parameterName)}&lt;/ns1:parameterName>
    &lt;/ns1:GetParameters>
};

local:func($parameterName)</con:xquery>
    <con:dependencies>
        <con:importSchema location="../Resources/SBRG_Constants_Commons/Schemas/CustomParameter.xsd">
            <con:schema ref="SBHN_Pension_Commons/Resources/SBRG_Constants_Commons/Schemas/CustomParameter"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>