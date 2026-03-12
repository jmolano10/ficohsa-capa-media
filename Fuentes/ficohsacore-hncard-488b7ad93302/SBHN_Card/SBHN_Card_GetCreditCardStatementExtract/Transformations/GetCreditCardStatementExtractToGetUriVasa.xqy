xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConnectionAdquirVasa";
(:: import schema at "../Schemas/ConnectionAdquirVasa_sp.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/card";
(:: import schema at "../Schemas/GetCreditCardStatementExtractTypes.xsd" ::)

declare variable $getCreditCardStatementExtract as element() (:: schema-element(ns1:getCreditCardStatementExtract) ::) external;
declare variable $ProductTypeValue as xs:string external;

declare function local:funcGetCreditCardStatementExtractToGetUriVasa($getCreditCardStatementExtract as element() (:: schema-element(ns1:getCreditCardStatementExtract) ::), 
                                                                     $ProductTypeValue as xs:string) 
                                                                     as element() (:: schema-element(ns2:InputParameters) ::) {
     <ns2:InputParameters>
        <P_PRODUCT_TYPE>{fn:data($ProductTypeValue)}</P_PRODUCT_TYPE>
        <P_PRODUCT_VALUE>{fn:data($getCreditCardStatementExtract/ProductValue)}</P_PRODUCT_VALUE>
        <PERIODO>{fn:concat(fn:data($getCreditCardStatementExtract/Year),fn:data($getCreditCardStatementExtract/Month))}</PERIODO>
        <P_NUMERO_TARJETA>{fn:data($getCreditCardStatementExtract/ProductValue)}</P_NUMERO_TARJETA>
        <P_MES>{fn:data($getCreditCardStatementExtract/Month)}</P_MES>
        <P_ANIO>{fn:data($getCreditCardStatementExtract/Year)}</P_ANIO>
    </ns2:InputParameters>
};

local:funcGetCreditCardStatementExtractToGetUriVasa($getCreditCardStatementExtract, $ProductTypeValue)