<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../Schemas/CloudCodeTypes.xsd" ::)

declare variable $codigoCuenta as xs:string external;

declare function local:func($codigoCuenta as xs:string) as element() (:: schema-element(ns1:cuentasMonedas) ::) {
    &lt;ns1:cuentasMonedas>
        &lt;ns1:codigoCuenta>{fn:data($codigoCuenta)}&lt;/ns1:codigoCuenta>
    &lt;/ns1:cuentasMonedas>
};

local:func($codigoCuenta)</con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/CloudCodeTypes.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/FPC/CloudCode/Schemas/CloudCodeTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>