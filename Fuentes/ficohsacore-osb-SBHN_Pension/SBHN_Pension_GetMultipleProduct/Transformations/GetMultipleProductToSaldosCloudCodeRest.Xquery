<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/pension";
(:: import schema at "../Schemas/GetMultipleProductTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../Schemas/CloudCodeTypes.xsd" ::)

declare variable $request as element() (:: schema-element(ns1:getMultipleProduct) ::) external;

declare function local:funcGetMultipleProductToSaldosCloudCodeRest($request as element() (:: schema-element(ns1:getMultipleProduct) ::)) as element() (:: schema-element(ns2:getSaldos) ::) {
    <ns2:getSaldos>
        <codigoTipoIdentificacion>{fn:data($request/CodeTypeIdentificationAffiliate)}</codigoTipoIdentificacion>
        <numeroIdentificacion>{fn:data($request/NumberIdentificationAffiliate)}</numeroIdentificacion>
    </ns2:getSaldos>
};

local:funcGetMultipleProductToSaldosCloudCodeRest($request)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/GetMultipleProductTypes.xsd">
            <con:schema ref="SBHN_Pension_GetMultipleProduct/Schemas/GetMultipleProductTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_GetMultipleProduct/Schemas/CloudCodeTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>