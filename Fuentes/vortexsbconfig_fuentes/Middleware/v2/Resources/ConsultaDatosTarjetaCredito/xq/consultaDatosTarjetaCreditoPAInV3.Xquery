<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDatosTarjetaCredito" element="ns0:consultaDatosTarjetaCredito" location="../../../BusinessServices/OSB/ConsultaDatosTarjetaCredito_v2/xsd/XMLSchema_914157276.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MasterDataPA/conDatoEstado/xsd/conDatoEstado_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoEstado";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaCredito/xq/consultaDatosTarjetaCreditoPAInV3/";

declare function xf:consultaDatosTarjetaCreditoPAInV3($consultaDatosTarjetaCredito as element(ns0:consultaDatosTarjetaCredito))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:NumTarjeta>{ data($consultaDatosTarjetaCredito/CARD_NUMBER) }&lt;/ns1:NumTarjeta>
        &lt;/ns1:InputParameters>
};

declare variable $consultaDatosTarjetaCredito as element(ns0:consultaDatosTarjetaCredito) external;

xf:consultaDatosTarjetaCreditoPAInV3($consultaDatosTarjetaCredito)</con:xquery>
    <con:dependency location="../../../BusinessServices/OSB/ConsultaDatosTarjetaCredito_v2/xsd/XMLSchema_914157276.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/OSB/ConsultaDatosTarjetaCredito_v2/xsd/XMLSchema_914157276"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/MasterDataPA/conDatoEstado/xsd/conDatoEstado_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MasterDataPA/conDatoEstado/xsd/conDatoEstado_sp"/>
    </con:dependency>
</con:xqueryEntry>