<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns1:opConsultaPrestamoSolicitud" location="../../../CTS/prestamo/xsd/services.xsd" ::)

declare namespace ns1 = "http://service.srvaplcobisprestamo.ecobis.cobiscorp";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosNI/xq/consultaPrestamoIn/";

declare function xf:consultaPrestamoIn($productID as xs:string)
    as element(ns1:opConsultaPrestamoSolicitud) {
        <ns1:opConsultaPrestamoSolicitud>
            <ns0:prestamo>
                <ns0:producto>
                    <ns0:valNumeroProducto>{ $productID }</ns0:valNumeroProducto>
                </ns0:producto>
            </ns0:prestamo>
            <ns0:contextoTransaccional>
                <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
            </ns0:contextoTransaccional>
        </ns1:opConsultaPrestamoSolicitud>
};

declare variable $productID as xs:string external;

xf:consultaPrestamoIn($productID)]]></con:xquery>
    <con:dependency location="../../../CTS/prestamo/xsd/services.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CTS/prestamo/xsd/services"/>
    </con:dependency>
</con:xqueryEntry>