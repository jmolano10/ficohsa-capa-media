<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/consultaMultiplesProductosTypes";
(:: import schema at "../Schemas/ConsultaMultiplesProductosTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetMultipleProductTypes.xsd" ::)

declare variable $responseRegional as element() (:: schema-element(ns1:getMultipleProductResponse) ::) external;

declare function local:funcRegionalToVirtualBody11gHN($responseRegional as element() (:: schema-element(ns1:getMultipleProductResponse) ::)) as element() (:: schema-element(ns2:consultaMultiplesProductosResponse) ::) {
    <ns2:consultaMultiplesProductosResponse>

        <ASSETS>
            <ASSET>
                <ID>{fn:data($responseRegional/AccountCode)}</ID>
                <PRODUCT_NAME>{fn:data($responseRegional/NameCustomer)}</PRODUCT_NAME>
                <STATUS></STATUS>
                <CURRENCY>{fn:data($responseRegional/CodeCurrency)}</CURRENCY>
                <RESERVE_BALANCE></RESERVE_BALANCE>
                <LOCKED_BALANCE></LOCKED_BALANCE>
                <VISA_FLOATING_BALANCE></VISA_FLOATING_BALANCE>
                <CASH_ADVANCE_LIMIT></CASH_ADVANCE_LIMIT>
                <CASH_ADVANCE_AVAILABLE></CASH_ADVANCE_AVAILABLE>
                <INTEREST_BALANCE></INTEREST_BALANCE>
                <TOTAL_BALANCE>{fn:data($responseRegional/BalanceTotalCurrent)}</TOTAL_BALANCE>
                <AVAILABLE_BALANCE>{fn:data($responseRegional/BalanceTotalCurrent)}</AVAILABLE_BALANCE>
                <OPENING_DATE>{fn:data($responseRegional/DateOpenAccount)}</OPENING_DATE>
                <TYPE>FPC</TYPE>
                <SOURCE_BANK></SOURCE_BANK>
                <SUCCESS_INDICATOR></SUCCESS_INDICATOR>
                <ERROR_MESSAGE></ERROR_MESSAGE>
                <INTERNATIONAL_ACCOUNT_NUMBER></INTERNATIONAL_ACCOUNT_NUMBER>
            </ASSET>
        </ASSETS>
    </ns2:consultaMultiplesProductosResponse>
};

local:funcRegionalToVirtualBody11gHN($responseRegional)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/ConsultaMultiplesProductosTypes.xsd">
            <con:schema ref="SBRG_Pension_GetMultipleProduct/Schemas/ConsultaMultiplesProductosTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/GetMultipleProductTypes.xsd">
            <con:schema ref="SBRG_Pension_GetMultipleProduct/Schemas/GetMultipleProductTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>