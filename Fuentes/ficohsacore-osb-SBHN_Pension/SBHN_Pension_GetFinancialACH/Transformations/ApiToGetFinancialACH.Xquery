<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/honduras/pension";
(:: import schema at "../Schemas/GetFinancialACHTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd" ::)

declare variable $responseApi as element() (:: schema-element(ns1:bancostResponse) ::) external;
declare variable $globalId as xs:string external;
declare variable $status as xs:string external;


declare function local:func($responseApi as element() (:: schema-element(ns1:bancostResponse) ::), 
                            $globalId as xs:string, 
                            $status as xs:string) as element() (:: schema-element(ns2:getFinancialACHResponse) ::) {
    <ns2:getFinancialACHResponse>
      <StatusInfo>
            <Status>{fn:data($status)}</Status>
            <TransactionId></TransactionId>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
      </StatusInfo>
      <Data>
        {
           for $entesItem in $responseApi/ns1:datos/ns1:entes
           return		
            <Entities>
                <Code>{ fn:data($entesItem/ns1:codigo) }</Code>
                <Description>{ fn:data($entesItem/ns1:descripcion) }</Description>
            </Entities>
        }
      </Data>
    </ns2:getFinancialACHResponse>
};

local:func($responseApi, $globalId, $status)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/GetFinancialACHTypes.xsd">
            <con:schema ref="SBHN_Pension_GetFinancialACH/Schemas/GetFinancialACHTypes"/>
        </con:importSchema>
        <con:importSchema location="../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_Commons/Schemas/CloudCodeTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>