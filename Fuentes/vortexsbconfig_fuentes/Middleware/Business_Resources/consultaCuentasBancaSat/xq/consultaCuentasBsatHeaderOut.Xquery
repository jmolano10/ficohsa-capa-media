<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitaTDCliente/xq/SolicitaTDClienteHeaderIN/";

declare function xf:SolicitaTDClienteHeaderIN($ErrorCode as xs:string,
    $MessageError as xs:string)
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            <successIndicator>{ $ErrorCode }</successIndicator>
            {
            if ($ErrorCode!='SUCCESS') then(
            <messages>{ $MessageError }</messages>          
            )else()
            }
        </ns0:ResponseHeader>
};

declare variable $ErrorCode as xs:string external;
declare variable $MessageError as xs:string external;

xf:SolicitaTDClienteHeaderIN($ErrorCode,
    $MessageError)]]></con:xquery>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>