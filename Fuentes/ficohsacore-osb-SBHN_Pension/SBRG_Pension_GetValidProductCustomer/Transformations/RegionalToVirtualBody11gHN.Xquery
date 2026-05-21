<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/validaProductoClienteTypes";
(:: import schema at "../Schemas/ValidaProductoClienteTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetValidProductCustomerTypes.xsd" ::)

declare variable $responseRegional as element() (:: schema-element(ns1:getValidProductCustomerResponse) ::) external;

declare function local:funcRegionalToVirtualBody11gHN($responseRegional as element() (:: schema-element(ns1:getValidProductCustomerResponse) ::)) as element() (:: schema-element(ns2:validaProductoClienteResponse) ::) {
    <ns2:validaProductoClienteResponse>
        <PRODUCT_NAME>{fn:data($responseRegional/NameCustomer)}</PRODUCT_NAME>
        <CURRENCY>{fn:data($responseRegional/CodeCurrency)}</CURRENCY>
        <OPENING_DATE>{fn:data($responseRegional/DateOpenAccount)}</OPENING_DATE>

    </ns2:validaProductoClienteResponse>
};

local:funcRegionalToVirtualBody11gHN($responseRegional)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/ValidaProductoClienteTypes.xsd">
            <con:schema ref="SBRG_Pension_GetValidProductCustomer/Schemas/ValidaProductoClienteTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/GetValidProductCustomerTypes.xsd">
            <con:schema ref="SBRG_Pension_GetValidProductCustomer/Schemas/GetValidProductCustomerTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>