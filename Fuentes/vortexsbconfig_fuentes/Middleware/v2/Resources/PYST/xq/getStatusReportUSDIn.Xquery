<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:GetStatusReportUSD" location="../../../BusinessServices/PYST/envioTransfACH/xsd/XMLSchema_-1986733638.xsd" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PYST/xq/getStatusReportUSDIn/";

declare function xf:getStatusReportUSDIn($searchCriteria as xs:string,
    $searchValue as xs:string)
    as element(ns0:GetStatusReportUSD) {
        <ns0:GetStatusReportUSD>
            <ns0:SearchCriteria>{ $searchCriteria }</ns0:SearchCriteria>
            <ns0:SearchValue>{ $searchValue }</ns0:SearchValue>
        </ns0:GetStatusReportUSD>
};

declare variable $searchCriteria as xs:string external;
declare variable $searchValue as xs:string external;

xf:getStatusReportUSDIn($searchCriteria,
    $searchValue)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/PYST/envioTransfACH/xsd/XMLSchema_-1986733638.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/PYST/envioTransfACH/xsd/XMLSchema_-1986733638"/>
    </con:dependency>
</con:xqueryEntry>