<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetEmploymentInformationTypes.xsd" ::)

declare variable $request as element() (:: schema-element(ns1:getEmploymentInformation) ::) external;

declare function local:func($request as element() (:: schema-element(ns1:getEmploymentInformation) ::)) 
                            as element() (:: schema-element(ns2:historicasLaborales) ::) {
    <ns2:historicasLaborales>
        <ns2:codigoCuenta>{fn:data($request/AccountCode)}</ns2:codigoCuenta>
        <ns2:fechaInicio>{fn:data($request/StartDate)}</ns2:fechaInicio>
        <ns2:fechaFin>{fn:data($request/DateEnd)}</ns2:fechaFin>
    </ns2:historicasLaborales>
};

local:func($request)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_Commons/Schemas/CloudCodeTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/GetEmploymentInformationTypes.xsd">
            <con:schema ref="SBHN_Pension_GetEmploymentInformation/Schemas/GetEmploymentInformationTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>