<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMovimientosRecientesTC" element="ns1:consultaMovimientosRecientesTC" location="../xsd/consultaMovimientosRecientesTCTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/CLIENTDATA/consultaMovimientosRecientesTC/xsd/consultaMovimientosRecientesTC_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMovimientosRecientesTCTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMovimientosRecientesTC";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaMovimientosRecientesTC/xq/consultaMovimientosRecientesTCIn/";

declare function xf:consultaMovimientosRecientesTCIn($consultaMovimientosRecientesTC as element(ns1:consultaMovimientosRecientesTC),
    $requestHeader as element(ns2:RequestHeader))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_NUMERO_TARJETA>{ data($consultaMovimientosRecientesTC/CARD_NUMBER) }</ns0:PV_NUMERO_TARJETA>
            <ns0:PV_COUNTRY_CODE>{ data($requestHeader/Region/SourceBank) }</ns0:PV_COUNTRY_CODE>
        </ns0:InputParameters>
};

declare variable $consultaMovimientosRecientesTC as element(ns1:consultaMovimientosRecientesTC) external;
declare variable $requestHeader as element(ns2:RequestHeader) external;

xf:consultaMovimientosRecientesTCIn($consultaMovimientosRecientesTC,
    $requestHeader)]]></con:xquery>
    <con:dependency location="../xsd/consultaMovimientosRecientesTCTypes.xsd">
        <con:schema ref="Middleware/v3/Resources/ConsultaMovimientosRecientesTC/xsd/consultaMovimientosRecientesTCTypes"/>
    </con:dependency>
    <con:dependency location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/CLIENTDATA/consultaMovimientosRecientesTC/xsd/consultaMovimientosRecientesTC_sp.xsd">
        <con:schema ref="Middleware/v3/BusinessServices/CLIENTDATA/consultaMovimientosRecientesTC/xsd/consultaMovimientosRecientesTC_sp"/>
    </con:dependency>
</con:xqueryEntry>