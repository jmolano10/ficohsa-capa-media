<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/autType";
(:: import schema at "../../SBRG_Pension_Commons/Schemas/Virtual/Header11gMapper.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetMultipleProductTypes.xsd" ::)

declare variable $responseRegional as element() (:: schema-element(ns1:getMultipleProductResponse) ::) external;

declare function local:funcRegionalToVirtualHeader11gHN($responseRegional as element() (:: schema-element(ns1:getMultipleProductResponse) ::)) as element() (:: schema-element(ns2:ResponseHeader) ::) {
     <ns2:ResponseHeader>
     { 
     if(upper-case($responseRegional/StatusInfo/Status) != "SUCCESS") then
        <messageId>{ fn:string($responseRegional/ErrorInfo/Error) }</messageId>
    else ()
    }
    {
     if ((upper-case($responseRegional/StatusInfo/Status) ="SUCCESS")) then (
        <successIndicator>{ data($responseRegional/StatusInfo/Status) }</successIndicator>
     )else  if ((upper-case($responseRegional/StatusInfo/Status) ="ERROR")) then (
        <successIndicator>{ upper-case(data($responseRegional/StatusInfo/Status) ) }</successIndicator>
     ) else
        <successIndicator>NO RECORDS</successIndicator>
     }
     {
      if(upper-case($responseRegional/StatusInfo/Status) = "SUCCESS") then
        ""
      else
        <messages>{ data($responseRegional/ErrorInfo/Description) }</messages>
      }
    </ns2:ResponseHeader>
};

local:funcRegionalToVirtualHeader11gHN($responseRegional)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../SBRG_Pension_Commons/Schemas/Virtual/Header11gMapper.xsd">
            <con:schema ref="SBRG_Pension_Commons/Schemas/Virtual/Header11gMapper"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/GetMultipleProductTypes.xsd">
            <con:schema ref="SBRG_Pension_GetMultipleProduct/Schemas/GetMultipleProductTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>