<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$bloqueoTC" element="ns0:bloqueoTC" location="../../GestionesTarjetas/xsd/gestionesTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:CardBlockRequest" location="../../../BusinessServices/VisionPlus/fdcs/wsdl/Fdcs.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesTarjetasTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjeta";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/BloqueoTC/xq/cardBlockIn/";

declare function xf:cardBlockIn($orgNumber as xs:string,
    $accountNumber as xs:string,
    $blockCode as xs:string)
    as element(ns1:CardBlockRequest) {
        <ns1:CardBlockRequest>
            <OrgNumber>{ data($orgNumber) }</OrgNumber>
            <AccountNumber>{ data($accountNumber) }</AccountNumber>
            <BlockCode>{ data($blockCode) }</BlockCode>
        </ns1:CardBlockRequest>
};

declare variable $orgNumber as xs:string external;
declare variable $accountNumber as xs:string external;
declare variable $blockCode as xs:string external;

xf:cardBlockIn($orgNumber,
    $accountNumber,
    $blockCode)]]></con:xquery>
    <con:dependency location="../../GestionesTarjetas/xsd/gestionesTarjetasTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/GestionesTarjetas/xsd/gestionesTarjetasTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/VisionPlus/fdcs/wsdl/Fdcs.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/VisionPlus/fdcs/wsdl/Fdcs"/>
    </con:dependency>
</con:xqueryEntry>