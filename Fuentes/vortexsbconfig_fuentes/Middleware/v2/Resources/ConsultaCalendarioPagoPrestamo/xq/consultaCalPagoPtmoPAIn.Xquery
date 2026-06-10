<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaCalendarioPagoPrestamo1" element="ns1:consultaCalendarioPagoPrestamo" location="../../../../Business_Resources/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/consultaCalendarioPagoPrestamo/xsd/consultaCalendarioPagoPrestamo_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCalendarioPagoPrestamo";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCalendarioPagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaCalendarioPagoPrestamo/xq/consultaCalendarioPagoPrestamoIn/";

declare function xf:consultaCalendarioPagoPrestamoIn($consultaCalendarioPagoPrestamo1 as element(ns1:consultaCalendarioPagoPrestamo))
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:LOAN_ID>{ data($consultaCalendarioPagoPrestamo1/LOAN_ID) }&lt;/ns0:LOAN_ID>
        &lt;/ns0:InputParameters>
};

declare variable $consultaCalendarioPagoPrestamo1 as element(ns1:consultaCalendarioPagoPrestamo) external;

xf:consultaCalendarioPagoPrestamoIn($consultaCalendarioPagoPrestamo1)</con:xquery>
    <con:dependency location="../../../../Business_Resources/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamoTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKPA/consultaCalendarioPagoPrestamo/xsd/consultaCalendarioPagoPrestamo_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKPA/consultaCalendarioPagoPrestamo/xsd/consultaCalendarioPagoPrestamo_sp"/>
    </con:dependency>
</con:xqueryEntry>