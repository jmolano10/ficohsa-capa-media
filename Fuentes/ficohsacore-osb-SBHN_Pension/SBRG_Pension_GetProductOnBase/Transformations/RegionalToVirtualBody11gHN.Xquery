<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/consultaProductoOnBaseTypes";
(:: import schema at "../Schemas/ConsultaProductoOnBaseTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetProductOnBaseTypes.xsd" ::)

declare variable $responseRegional as element() (:: schema-element(ns1:getProductOnBaseResponse) ::) external;

declare function local:funcRegionalToVirtualBody11gHN($responseRegional as element() (:: schema-element(ns1:getProductOnBaseResponse) ::)) as element() (:: schema-element(ns2:consultaProductoOnBaseResponse) ::) {
    <ns2:consultaProductoOnBaseResponse>
        <PRODUCT_NAME>{fn:data($responseRegional/NameCustomer)}</PRODUCT_NAME>
        <CURRENCY>{fn:data($responseRegional/CodeCurrency)}</CURRENCY>
        <OPENING_DATE>{fn:data($responseRegional/DateOpenAccount)}</OPENING_DATE>

    </ns2:consultaProductoOnBaseResponse>
};

local:funcRegionalToVirtualBody11gHN($responseRegional)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/ConsultaProductoOnBaseTypes.xsd">
            <con:schema ref="SBRG_Pension_GetProductOnBase/Schemas/ConsultaProductoOnBaseTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/GetProductOnBaseTypes.xsd">
            <con:schema ref="SBRG_Pension_GetProductOnBase/Schemas/GetProductOnBaseTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>