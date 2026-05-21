<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../Schemas/CloudCodeTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetFICOPENTypes.xsd" ::)

declare variable $requestService as element() (:: schema-element(ns1:getFICOPEN) ::) external;

declare function local:funcGetFICOPENToMonedasCloudCode($requestService as element() (:: schema-element(ns1:getFICOPEN) ::)) as element() (:: schema-element(ns2:monedas) ::) {
    &lt;ns2:monedas>
        &lt;codigoCuenta>{fn:data($requestService/CodeNumber)}&lt;/codigoCuenta>
    &lt;/ns2:monedas>
};

local:funcGetFICOPENToMonedasCloudCode($requestService)</con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_GetFICOPEN/Schemas/CloudCodeTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/GetFICOPENTypes.xsd">
            <con:schema ref="SBHN_Pension_GetFICOPEN/Schemas/GetFICOPENTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>