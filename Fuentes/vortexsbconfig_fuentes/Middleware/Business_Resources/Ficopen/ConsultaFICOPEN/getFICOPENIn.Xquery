<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaFICOPEN" element="ns0:consultaFICOPEN" location="consultaFICOPENTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaFICOPEN" location="../../../v2/BusinessServices/FPC/getFicopen12c/xsd/GetFicopenTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaFICOPENTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Ficopen/ConsultaFICOPEN/getFICOPENIn/";

declare function xf:getFICOPENIn($consultaFICOPEN as element(ns0:consultaFICOPEN))
    as element(ns0:consultaFICOPEN) {
        <ns0:consultaFICOPEN>
            <INVESTMENT_CODE>{ data($consultaFICOPEN/INVESTMENT_CODE) }</INVESTMENT_CODE>
            <START_DATE>{ data($consultaFICOPEN/START_DATE) }</START_DATE>
            <END_DATE>{ data($consultaFICOPEN/END_DATE) }</END_DATE>
        </ns0:consultaFICOPEN>
};

declare variable $consultaFICOPEN as element(ns0:consultaFICOPEN) external;

xf:getFICOPENIn($consultaFICOPEN)]]></con:xquery>
    <con:dependency location="consultaFICOPENTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/Ficopen/ConsultaFICOPEN/consultaFICOPENTypes"/>
    </con:dependency>
    <con:dependency location="../../../v2/BusinessServices/FPC/getFicopen12c/xsd/GetFicopenTypes.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/FPC/getFicopen12c/xsd/GetFicopenTypes"/>
    </con:dependency>
</con:xqueryEntry>