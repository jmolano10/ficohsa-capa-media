<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCloudCodeSessionToken";
(:: import schema at "../Schemas/GetCloudCodeSessionToken_sp.xsd" ::)

declare variable $userName as xs:string external;

declare function local:func($userName as xs:string) as element() (:: schema-element(ns1:InputParameters) ::) {
    &lt;ns1:InputParameters>
        &lt;ns1:PV_NOMBRE_USUARIO>{fn:data($userName)}&lt;/ns1:PV_NOMBRE_USUARIO>
    &lt;/ns1:InputParameters>
};

local:func($userName)</con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/GetCloudCodeSessionToken_sp.xsd">
            <con:schema ref="SBHN_Pension_CloudCodeLogin/Schemas/GetCloudCodeSessionToken_sp"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>