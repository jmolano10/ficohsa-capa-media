<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/consultaFondosPensionesClienteTypes";
(:: import schema at "../Schemas/ConsultaFondosPensionesClienteTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetFundPensionClientTypes.xsd" ::)

declare variable $responseRegional as element() (:: schema-element(ns1:getFundPensionClientResponse) ::) external;

declare function local:funcRegionalToVirtualBody11gHN($responseRegional as element() (:: schema-element(ns1:getFundPensionClientResponse) ::)) as element() (:: schema-element(ns2:consultaFondosPensionesClienteResponse) ::) {
    <ns2:consultaFondosPensionesClienteResponse>
        <ns2:CUSTOMER_ID_TYPE>{fn:data($responseRegional/Data/Client/IdentificationType)}</ns2:CUSTOMER_ID_TYPE>
        <ns2:CUSTOMER_ID_VALUE>{fn:data($responseRegional/Data/Client/IdentificationNumber)}</ns2:CUSTOMER_ID_VALUE>
        <ns2:CUSTOMER_CODE>{fn:data($responseRegional/Data/Client/Clientcode)}</ns2:CUSTOMER_CODE>
        <ns2:ACCOUNT_INFO>
            {
                for $Accounts in $responseRegional/Data/Client/Accounts
                return 
                <ns2:ACCOUNT_ITEM>
                  <ns2:ACCOUNT_NUMBER>{fn:data($Accounts/AccountCode)}</ns2:ACCOUNT_NUMBER>
                  <ns2:CURRENCY_CODE>{fn:data($Accounts/CurrencyCode)}</ns2:CURRENCY_CODE>
                  <ns2:CURRENCY_NAME>{fn:data($Accounts/CurrencyName)}</ns2:CURRENCY_NAME>
                  <ns2:PRODUCT_CODE>{fn:data($Accounts/CodeProductLine)}</ns2:PRODUCT_CODE>
                  <ns2:PRODUCT_NAME>{fn:data($Accounts/ProductLineName)}</ns2:PRODUCT_NAME>
                  <ns2:SUBPRODUCT_CODE>{fn:data($Accounts/ProductCode)}</ns2:SUBPRODUCT_CODE>
                  <ns2:SUBPRODUCT_NAME>{fn:data($Accounts/ProductName)}</ns2:SUBPRODUCT_NAME>
                  <ns2:ACCOUNT_CODE>{fn:data($Accounts/Alternative)}</ns2:ACCOUNT_CODE>
                </ns2:ACCOUNT_ITEM>
            }
        </ns2:ACCOUNT_INFO>

    </ns2:consultaFondosPensionesClienteResponse>
};

local:funcRegionalToVirtualBody11gHN($responseRegional)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/ConsultaFondosPensionesClienteTypes.xsd">
            <con:schema ref="SBRG_Pension_GetFundPensionClient/Schemas/ConsultaFondosPensionesClienteTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/GetFundPensionClientTypes.xsd">
            <con:schema ref="SBRG_Pension_GetFundPensionClient/Schemas/GetFundPensionClientTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>