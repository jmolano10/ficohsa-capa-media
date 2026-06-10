<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v3/BusinessServices/ABKGT/consultarTarjetaDebito/xsd/consultarTarjetaDebito_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarTarjetaDebito";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultaCliente/xq/ConsultaDatosTarjetaDebitoGT/";

declare function xf:consultaTarjetaDebito($numeroTarjeta as xs:string)
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;PV_NUMERO_TARJETA>{ data($numeroTarjeta) }&lt;/PV_NUMERO_TARJETA>
        &lt;/ns0:InputParameters>
};

declare variable $numeroTarjeta as xs:string external;

xf:consultaTarjetaDebito($numeroTarjeta)</con:xquery>
    <con:dependency location="../../../../v3/BusinessServices/ABKGT/consultarTarjetaDebito/xsd/consultarTarjetaDebito_sp.xsd">
        <con:schema ref="Middleware/v3/BusinessServices/ABKGT/consultarTarjetaDebito/xsd/consultarTarjetaDebito_sp"/>
    </con:dependency>
</con:xqueryEntry>