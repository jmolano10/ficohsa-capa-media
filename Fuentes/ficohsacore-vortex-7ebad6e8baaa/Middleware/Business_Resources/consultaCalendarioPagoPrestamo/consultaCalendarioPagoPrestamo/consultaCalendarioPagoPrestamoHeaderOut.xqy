xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../Resources/ConsultaCalendarioPagoPrestamo/xsd/ORA_BANK_OSB_K_CONSULTAPLANPAGOPRESTAMO_TOPLEVEL-24OSB_CON_PLAN_PAGO_PR.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_CONSULTAPLANPAGOPRESTAMO/TOPLEVEL-24OSB_CON_PLAN_PAGO_PR/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamoHeaderOut/";

declare function xf:consultaCalendarioPagoPrestamoHeaderOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $ERROR_CODE in $outputParameters/ns0:ERROR_CODE
                return
                    <successIndicator>{ data($ERROR_CODE) }</successIndicator>
            }
            {
                for $ERROR_MESSAGE in $outputParameters/ns0:ERROR_MESSAGE
                return
                    <messages>{ data($ERROR_MESSAGE) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaCalendarioPagoPrestamoHeaderOut($outputParameters)