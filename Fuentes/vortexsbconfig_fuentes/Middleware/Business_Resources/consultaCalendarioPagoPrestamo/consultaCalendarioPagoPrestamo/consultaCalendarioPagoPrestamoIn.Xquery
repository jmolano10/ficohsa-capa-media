<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaCalendarioPagoPrestamo" element="ns0:consultaCalendarioPagoPrestamo" location="consultaCalendarioPagoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../Resources/ConsultaCalendarioPagoPrestamo/xsd/ORA_BANK_OSB_K_CONSULTAPLANPAGOPRESTAMO_TOPLEVEL-24OSB_CON_PLAN_PAGO_PR.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_CONSULTAPLANPAGOPRESTAMO/TOPLEVEL-24OSB_CON_PLAN_PAGO_PR/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaCalendarioPagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamoIn/";

declare function xf:consultaCalendarioPagoPrestamoIn($consultaCalendarioPagoPrestamo as element(ns0:consultaCalendarioPagoPrestamo))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:LOAN_ID>{ data($consultaCalendarioPagoPrestamo/LOAN_ID) }&lt;/ns1:LOAN_ID>
        &lt;/ns1:InputParameters>
};

declare variable $consultaCalendarioPagoPrestamo as element(ns0:consultaCalendarioPagoPrestamo) external;

xf:consultaCalendarioPagoPrestamoIn($consultaCalendarioPagoPrestamo)</con:xquery>
    <con:dependency location="consultaCalendarioPagoPrestamoTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamoTypes"/>
    </con:dependency>
    <con:dependency location="../Resources/ConsultaCalendarioPagoPrestamo/xsd/ORA_BANK_OSB_K_CONSULTAPLANPAGOPRESTAMO_TOPLEVEL-24OSB_CON_PLAN_PAGO_PR.xsd">
        <con:schema ref="Middleware/Business_Resources/consultaCalendarioPagoPrestamo/Resources/ConsultaCalendarioPagoPrestamo/xsd/ORA_BANK_OSB_K_CONSULTAPLANPAGOPRESTAMO_TOPLEVEL-24OSB_CON_PLAN_PAGO_PR"/>
    </con:dependency>
</con:xqueryEntry>