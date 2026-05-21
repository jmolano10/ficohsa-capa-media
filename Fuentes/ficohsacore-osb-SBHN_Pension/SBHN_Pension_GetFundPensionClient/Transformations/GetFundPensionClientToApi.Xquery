<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetFundPensionClientTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/pension/cloudCodeTypes";
(:: import schema at "../Schemas/CloudCodeTypes.xsd" ::)

declare variable $request as element() (:: schema-element(ns1:getFundPensionClient) ::) external;

declare function local:func($request as element() (:: schema-element(ns1:getFundPensionClient) ::)) as element() (:: schema-element(ns2:fondosPensiones) ::) {
<ns2:fondosPensiones>
    <tipoIdentificacion>{fn:data($request/IdentificationType)}</tipoIdentificacion>
    <numeroIdentificacion>{fn:data($request/IdentificationNumber)}</numeroIdentificacion>
    <codigoCliente>{fn:data($request/Clientcode)}</codigoCliente>
</ns2:fondosPensiones>
};

local:func($request)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/GetFundPensionClientTypes.xsd">
            <con:schema ref="SBHN_Pension_GetFundPensionClient/Schemas/GetFundPensionClientTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_GetFundPensionClient/Schemas/CloudCodeTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>