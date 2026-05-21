<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd" ::)

declare variable $accountNumber as xs:integer external;

declare function local:func($accountNumber as xs:integer) as element() (:: schema-element(ns1:demograficos) ::) {
    &lt;ns1:demograficos>
        &lt;ns1:codigoCuenta>{fn:data($accountNumber)}&lt;/ns1:codigoCuenta>
    &lt;/ns1:demograficos>
};

local:func($accountNumber)</con:xquery>
    <con:dependencies>
        <con:importSchema location="../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_Commons/Schemas/CloudCodeTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>