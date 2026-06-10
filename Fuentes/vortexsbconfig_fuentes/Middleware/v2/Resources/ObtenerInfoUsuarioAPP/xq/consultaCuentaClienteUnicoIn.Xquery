<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$obtenerInfoUsuarioAPP" element="ns1:obtenerInfoUsuarioAPP" location="../xsd/obtenerInfoUsuarioAPPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ADQ/ConsultaCuentaClienteUnico/xsd/consultaCuentaClienteUnico_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/obtenerInfoUsuarioAPPTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCuentaClienteUnico";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ObtenerInfoUsuarioAPP/xq/consultaCuentaClienteUnicoIn/";

declare function xf:consultaCuentaClienteUnicoIn($obtenerInfoUsuarioAPP as element(ns1:obtenerInfoUsuarioAPP))
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:CodigoCliente>{ data($obtenerInfoUsuarioAPP/PROFILE) }&lt;/ns0:CodigoCliente>
        &lt;/ns0:InputParameters>
};

declare variable $obtenerInfoUsuarioAPP as element(ns1:obtenerInfoUsuarioAPP) external;

xf:consultaCuentaClienteUnicoIn($obtenerInfoUsuarioAPP)</con:xquery>
    <con:dependency location="../xsd/obtenerInfoUsuarioAPPTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ObtenerInfoUsuarioAPP/xsd/obtenerInfoUsuarioAPPTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ADQ/ConsultaCuentaClienteUnico/xsd/consultaCuentaClienteUnico_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ADQ/ConsultaCuentaClienteUnico/xsd/consultaCuentaClienteUnico_sp"/>
    </con:dependency>
</con:xqueryEntry>