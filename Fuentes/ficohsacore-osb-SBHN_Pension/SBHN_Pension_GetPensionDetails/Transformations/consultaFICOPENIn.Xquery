<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns0="http://xmlns.oracle.com/pcbpel/adapter/db/FICOPEN/OSB_K_CONSULTAFICOPEN/TOPLEVEL-24OSB_CON_FICOPEN/";
(:: import schema at "../Schemas/Ficopen.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/pension";
(:: import schema at "../../SBHN_Pension_Commons/Schemas/PensionInquiryTypes.xsd" ::)

declare variable $consultaFICOPEN1 as element() (:: schema-element(ns1:getPensionDetails) ::) external;
declare variable $fecha as xs:string := translate(substring(string(current-dateTime()),1,19),"T:-","");

declare function local:func($consultaFICOPEN1 as element() (:: schema-element(ns1:getPensionDetails) ::))
as element() (:: schema-element(ns0:InputParameters) ::) {
      <ns0:InputParameters>
            <ns0:INVESTMENT_CODE>{ data($consultaFICOPEN1/InvestmentCode) }</ns0:INVESTMENT_CODE>
            <ns0:START_DATE>{ replace(xs:string($consultaFICOPEN1/StartDate/text()), '-', '') }</ns0:START_DATE>
            <ns0:END_DATE>{ replace(xs:string($consultaFICOPEN1/EndDate/text()), '-', '') }</ns0:END_DATE>
        </ns0:InputParameters>
};

local:func($consultaFICOPEN1)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/Ficopen.xsd">
            <con:schema ref="SBHN_Pension_GetPensionDetails/Schemas/Ficopen"/>
        </con:importSchema>
        <con:importSchema location="../../SBHN_Pension_Commons/Schemas/PensionInquiryTypes.xsd">
            <con:schema ref="SBHN_Pension_Commons/Schemas/PensionInquiryTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>