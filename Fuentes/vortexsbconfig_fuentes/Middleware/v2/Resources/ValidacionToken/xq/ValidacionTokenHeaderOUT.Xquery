<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:schema-type-return type="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidacionToken/xq/ValidacionTokenHeaderOUT/";

declare function xf:ValidacionTokenHeaderOUT($SuccessIndicator as xs:string,
    $ErrorMessage as xs:string)
    as element() {
        <ns0:ResponseHeader>
            <successIndicator>{ $SuccessIndicator }</successIndicator>
          {
           if($SuccessIndicator="ERROR") then (
             <messages>{ $ErrorMessage }</messages>
           )
           else()
          }
        </ns0:ResponseHeader>
};

declare variable $SuccessIndicator as xs:string external;
declare variable $ErrorMessage as xs:string external;

xf:ValidacionTokenHeaderOUT($SuccessIndicator,
    $ErrorMessage)]]></con:xquery>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>