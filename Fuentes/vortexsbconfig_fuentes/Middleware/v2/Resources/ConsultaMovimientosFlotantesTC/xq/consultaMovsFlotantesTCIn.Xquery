<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMovimientosFlotantesTCRequest1" element="ns0:consultaMovimientosFlotantesTCRequest" location="../xsd/consultaMovimientosFlotantesTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultarXmlAutorizaciones" location="../../../BusinessServices/VASA/consultarFlotantesTC/wsdl/WSConsultas.asmx.wsdl" ::)

declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMovimientosFlotantesTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosFlotantesTC/xq/consultaMovsFlotantesTCIn/";

declare function xf:consultaMovsFlotantesTCIn($consultaMovimientosFlotantesTCRequest1 as element(ns0:consultaMovimientosFlotantesTCRequest))
    as element(ns1:ConsultarXmlAutorizaciones) {
        &lt;ns1:ConsultarXmlAutorizaciones>
            &lt;ns1:noTarjetaCredito>{ data($consultaMovimientosFlotantesTCRequest1/CARD_NUMBER) }&lt;/ns1:noTarjetaCredito>
        &lt;/ns1:ConsultarXmlAutorizaciones>
};

declare variable $consultaMovimientosFlotantesTCRequest1 as element(ns0:consultaMovimientosFlotantesTCRequest) external;

xf:consultaMovsFlotantesTCIn($consultaMovimientosFlotantesTCRequest1)</con:xquery>
    <con:dependency location="../xsd/consultaMovimientosFlotantesTCTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaMovimientosFlotantesTC/xsd/consultaMovimientosFlotantesTCTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/VASA/consultarFlotantesTC/wsdl/WSConsultas.asmx.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/VASA/consultarFlotantesTC/wsdl/WSConsultas.asmx"/>
    </con:dependency>
</con:xqueryEntry>