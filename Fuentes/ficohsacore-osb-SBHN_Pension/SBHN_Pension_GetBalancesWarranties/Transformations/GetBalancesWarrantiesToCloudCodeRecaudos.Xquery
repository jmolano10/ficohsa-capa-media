<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)


declare namespace ns2="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../Schemas/CloudCodeTypes.xsd" ::)

declare variable $accountCode as xs:string external;
declare variable $subAccountCode as xs:string external;

declare function local:func($accountCode as xs:string,$subAccountCode as xs:string) as element() (:: schema-element(ns2:recaudos) ::) {
    <ns2:recaudos>
        <ns2:codigoCuenta>{fn:data($accountCode)}</ns2:codigoCuenta>
        <ns2:codigoSubcuenta>{fn:data($subAccountCode)}</ns2:codigoSubcuenta>
    </ns2:recaudos>
};

local:func($accountCode,$subAccountCode)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_GetBalancesWarranties/Schemas/CloudCodeTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>