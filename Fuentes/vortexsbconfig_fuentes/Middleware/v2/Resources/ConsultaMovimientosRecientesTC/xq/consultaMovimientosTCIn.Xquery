<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/CLIENTDATA/consultaMovimientosRecientesTC/xsd/consultaMovimientosRecientesTC_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMovimientosRecientesTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosRecientesTC/xq/consultaMovimientosTCIn/";

declare function xf:consultaMovimientosTCIn($requestHeader as element(ns1:RequestHeader),
    $cardNumber as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CARD_NUMBER>{ $cardNumber }</ns0:PV_CARD_NUMBER>
            <ns0:PV_COUNTRY_CODE>{ data($requestHeader/Region/SourceBank) }</ns0:PV_COUNTRY_CODE>
        </ns0:InputParameters>
};

declare variable $requestHeader as element(ns1:RequestHeader) external;
declare variable $cardNumber as xs:string external;

xf:consultaMovimientosTCIn($requestHeader,
    $cardNumber)]]></con:xquery>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/CLIENTDATA/consultaMovimientosRecientesTC/xsd/consultaMovimientosRecientesTC_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CLIENTDATA/consultaMovimientosRecientesTC/xsd/consultaMovimientosRecientesTC_sp"/>
    </con:dependency>
</con:xqueryEntry>