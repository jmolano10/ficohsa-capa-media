<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/validaProductoClienteTypes";
(:: import schema at "../Schemas/ValidaProductoClienteTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetValidProductCustomerTypes.xsd" ::)

declare variable $request11g as element() (:: schema-element(ns2:validaProductoCliente) ::) external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;
declare variable $userName as xs:string external;
declare variable $legalIdType as xs:string external;
declare variable $legalId as xs:string external;

declare function local:funcVirtual11gToRegional($request11g as element() (:: schema-element(ns2:validaProductoCliente) ::),
                                                $sourceBank as xs:string, 
                                                $destinationBank as xs:string, 
                                                $userName as xs:string) as element() (:: schema-element(ns1:getValidProductCustomer) ::) {
    <ns1:getValidProductCustomer>
       <GeneralInfo>
            <SourceBank>{fn:data($sourceBank)}</SourceBank>
            <DestinationBank>{fn:data($destinationBank)}</DestinationBank>
            <ApplicationId>{fn:data($userName)}</ApplicationId>
            <ApplicationUser>{fn:data($userName)}</ApplicationUser>
        </GeneralInfo>
        <AccountCode>{fn:data($request11g/PRODUCT_NUMBER)}</AccountCode>
        <IdentificationTypeCode></IdentificationTypeCode>
        <IdentificationNumber></IdentificationNumber>
    </ns1:getValidProductCustomer>
};

local:funcVirtual11gToRegional($request11g, $sourceBank, $destinationBank, $userName)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/ValidaProductoClienteTypes.xsd">
            <con:schema ref="SBRG_Pension_GetValidProductCustomer/Schemas/ValidaProductoClienteTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/GetValidProductCustomerTypes.xsd">
            <con:schema ref="SBRG_Pension_GetValidProductCustomer/Schemas/GetValidProductCustomerTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>