<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:schema-type-parameter parameter="$pagingInfo" type="ns0:pagingInfo" location="../../esquemas_generales/PagingTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/PagingTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Generales/xq/validaPaginacion/";

declare function xf:validaPaginacion($pagingInfo as element())
    as xs:boolean {
    if (fn:string($pagingInfo/PAGING/text()) = "YES") then
    	if (fn:string($pagingInfo/INITIAL_RECORD/text()) = "" 
    		or fn:string($pagingInfo/RECORD_COUNT/text()) = "") then
        	xs:boolean("0")
        else
        	xs:boolean("1")
    else
        xs:boolean("1")
};

declare variable $pagingInfo as element() external;

xf:validaPaginacion($pagingInfo)</con:xquery>
    <con:dependency location="../../esquemas_generales/PagingTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/PagingTypes"/>
    </con:dependency>
</con:xqueryEntry>