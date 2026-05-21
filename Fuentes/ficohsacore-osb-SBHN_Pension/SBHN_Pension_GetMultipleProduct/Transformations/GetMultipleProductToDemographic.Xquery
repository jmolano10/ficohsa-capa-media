<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/pension";
(:: import schema at "../Schemas/GetMultipleProductTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd" ::)

declare variable $getMultipleProductRequest as element() (:: schema-element(ns1:getMultipleProduct) ::) external;

declare function local:func($getMultipleProductRequest as element() (:: schema-element(ns1:getMultipleProduct) ::)) as element() (:: schema-element(ns2:demograficos) ::) {
    &lt;ns2:demograficos>
        &lt;ns2:codigoCuenta>{fn:data($getMultipleProductRequest/NumberIdentificationAffiliate)}&lt;/ns2:codigoCuenta>
    &lt;/ns2:demograficos>
};

local:func($getMultipleProductRequest)</con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/GetMultipleProductTypes.xsd">
            <con:schema ref="SBHN_Pension_GetMultipleProduct/Schemas/GetMultipleProductTypes"/>
        </con:importSchema>
        <con:importSchema location="../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_Commons/Schemas/CloudCodeTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>