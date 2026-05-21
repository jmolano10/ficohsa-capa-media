<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetFinancialSituationTypes.xsd" ::)

declare variable $request as element() (:: schema-element(ns1:InputParameters) ::) external;

declare function local:func($request as element() (:: schema-element(ns1:InputParameters) ::)) as element() (:: schema-element(ns2:financieros) ::) {
    <ns2:financieros>
        <ns2:codigoTipoIdentificacion>{fn:data($request/PV_IDENTIFICATION_TYPE)}</ns2:codigoTipoIdentificacion>
        <ns2:numeroIdentificacion>{fn:data($request/PT_NUMERO_IDENTIFICACION/PT_NUMERO_IDENTIFICACION_ITEM[1])}</ns2:numeroIdentificacion>
    </ns2:financieros>
};

local:func($request)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_Commons/Schemas/CloudCodeTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/GetFinancialSituationTypes.xsd">
            <con:schema ref="SBHN_Pension_GetFinancialSituation/Schemas/GetFinancialSituationTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>