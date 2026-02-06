xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaCalendarioPagoPrestamo" element="ns0:consultaCalendarioPagoPrestamo" location="consultaCalendarioPagoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../Resources/ConsultaCalendarioPagoPrestamo/xsd/ORA_BANK_OSB_K_CONSULTAPLANPAGOPRESTAMO_TOPLEVEL-24OSB_CON_PLAN_PAGO_PR.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_CONSULTAPLANPAGOPRESTAMO/TOPLEVEL-24OSB_CON_PLAN_PAGO_PR/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaCalendarioPagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamoIn/";

declare function xf:consultaCalendarioPagoPrestamoIn($consultaCalendarioPagoPrestamo as element(ns0:consultaCalendarioPagoPrestamo))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:LOAN_ID>{ data($consultaCalendarioPagoPrestamo/LOAN_ID) }</ns1:LOAN_ID>
        </ns1:InputParameters>
};

declare variable $consultaCalendarioPagoPrestamo as element(ns0:consultaCalendarioPagoPrestamo) external;

xf:consultaCalendarioPagoPrestamoIn($consultaCalendarioPagoPrestamo)