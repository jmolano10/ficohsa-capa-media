<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:actualizaProductosCliente" location="../../ActualizaProductosCliente/xsd/actualizaProductosClienteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/actualizaProductosClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaCuentaCliente/xq/actualizaProductoIN/";

declare function xf:actualizaProductoIN($DocumentNumber as xs:string,
    $Type as xs:string)
    as element(ns0:actualizaProductosCliente) {
        <ns0:actualizaProductosCliente>
            <CUSTOMER_ID_TYPE>{ $Type }</CUSTOMER_ID_TYPE>
            <CUSTOMER_ID_VALUE>{ $DocumentNumber }</CUSTOMER_ID_VALUE>
        </ns0:actualizaProductosCliente>
};

declare variable $DocumentNumber as xs:string external;
declare variable $Type as xs:string external;

xf:actualizaProductoIN($DocumentNumber,
    $Type)]]></con:xquery>
    <con:dependency location="../../ActualizaProductosCliente/xsd/actualizaProductosClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ActualizaProductosCliente/xsd/actualizaProductosClienteTypes"/>
    </con:dependency>
</con:xqueryEntry>