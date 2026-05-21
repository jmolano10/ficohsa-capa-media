<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/pension";
(:: import schema at "../Schemas/GetBalancesWarrantiesTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../Schemas/CloudCodeTypes.xsd" ::)

declare variable $request as element() (:: schema-element(ns1:getBalancesWarranties) ::) external;

declare function local:func($request as element() (:: schema-element(ns1:getBalancesWarranties) ::)) as element() (:: schema-element(ns2:restricciones) ::) {
    &lt;ns2:restricciones>
        &lt;ns2:codigoCuenta>{fn:data($request/AccountCode)}&lt;/ns2:codigoCuenta>
    &lt;/ns2:restricciones>
};

local:func($request)</con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/GetBalancesWarrantiesTypes.xsd">
            <con:schema ref="SBHN_Pension_GetBalancesWarranties/Schemas/GetBalancesWarrantiesTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_GetBalancesWarranties/Schemas/CloudCodeTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>