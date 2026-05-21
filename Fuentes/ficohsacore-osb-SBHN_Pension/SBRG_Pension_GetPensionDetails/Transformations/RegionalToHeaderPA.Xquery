<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace aut="http://www.ficohsa.com.hn/middleware.services/autType";
(:: import schema at "../../SBRG_Pension_Commons/Schemas/Virtual/Header11gMapper.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/pension";
(:: import schema at "../../SBRG_Pension_Commons/Schemas/PensionInquiryTypes.xsd" ::)

declare variable $responseRegional as element() (:: schema-element(ns1:getPensionDetailsResponse) ::) external;

declare function local:func($responseRegional as element() (:: schema-element(ns1:getPensionDetailsResponse) ::)) as element() (:: schema-element(aut:ResponseHeader) ::) {
    <aut:ResponseHeader>
  { if(upper-case($responseRegional/StatusInfo/Status) != "SUCCESS") then
                <messageId>{ fn:string($responseRegional/ErrorInfo/Error) }</messageId>
              
              else ()
            }
            
            {
               if ((upper-case($responseRegional/StatusInfo/Status) ="SUCCESS")) then (
                    <successIndicator>{ upper-case(data($responseRegional/StatusInfo/Status) ) }</successIndicator>
              )else  if ((upper-case($responseRegional/StatusInfo/Status) ="ERROR")) then (
                    <successIndicator>{ upper-case(data($responseRegional/StatusInfo/Status) ) }</successIndicator>
              ) else
                    <successIndicator>NO RECORDS</successIndicator>
               
            }
             {
                 if(upper-case($responseRegional/StatusInfo/Status) = "SUCCESS") then
                  <messages/>
                else
                   <messages>{ data($responseRegional/ErrorInfo/Description) }</messages>
             } 
    </aut:ResponseHeader>
};

local:func($responseRegional)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../SBRG_Pension_Commons/Schemas/Virtual/Header11gMapper.xsd">
            <con:schema ref="SBRG_Pension_Commons/Schemas/Virtual/Header11gMapper"/>
        </con:importSchema>
        <con:importSchema location="../../SBRG_Pension_Commons/Schemas/PensionInquiryTypes.xsd">
            <con:schema ref="SBRG_Pension_Commons/Schemas/PensionInquiryTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>