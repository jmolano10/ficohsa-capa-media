<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMovimientosRecientesTC" element="ns1:consultaMovimientosRecientesTC" location="../../../../Business_Resources/tarjetaCredito/ConsultaMovimientosRecientesTC/consultaMovimientosRecientesTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:sjConsultaMovsRecientesTCNIRequest" location="../../../BusinessServices/SJS/consultaMovsRecientesTCNI/xsd/sjConsultaMovsRecientesTCNI.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMovimientosRecientesTCTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMovsRecientesTCNI";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosRecientesTC/xq/sjConsultaMovsRecientesTCNIIn/";

declare function xf:sjConsultaMovsRecientesTCNIIn($consultaMovimientosRecientesTC as element(ns1:consultaMovimientosRecientesTC))
    as element(ns0:sjConsultaMovsRecientesTCNIRequest) {
        &lt;ns0:sjConsultaMovsRecientesTCNIRequest>
            &lt;ns0:CARD_NUMBER>{ data($consultaMovimientosRecientesTC/CARD_NUMBER) }&lt;/ns0:CARD_NUMBER>
        &lt;/ns0:sjConsultaMovsRecientesTCNIRequest>
};

declare variable $consultaMovimientosRecientesTC as element(ns1:consultaMovimientosRecientesTC) external;

xf:sjConsultaMovsRecientesTCNIIn($consultaMovimientosRecientesTC)</con:xquery>
    <con:dependency location="../../../../Business_Resources/tarjetaCredito/ConsultaMovimientosRecientesTC/consultaMovimientosRecientesTCTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/tarjetaCredito/ConsultaMovimientosRecientesTC/consultaMovimientosRecientesTCTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/SJS/consultaMovsRecientesTCNI/xsd/sjConsultaMovsRecientesTCNI.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/consultaMovsRecientesTCNI/xsd/sjConsultaMovsRecientesTCNI"/>
    </con:dependency>
</con:xqueryEntry>