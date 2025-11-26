(:: pragma bea:global-element-parameter parameter="$consultaCalendarioPagoPrestamo1" element="ns1:consultaCalendarioPagoPrestamo" location="../../../../Business_Resources/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/consultaCalendarioPagoPrestamo/xsd/consultaCalendarioPagoPrestamo_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCalendarioPagoPrestamo";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCalendarioPagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaCalendarioPagoPrestamo/xq/consultaCalendarioPagoPrestamoIn/";

declare function xf:consultaCalendarioPagoPrestamoIn($consultaCalendarioPagoPrestamo1 as element(ns1:consultaCalendarioPagoPrestamo))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:LOAN_ID>{ data($consultaCalendarioPagoPrestamo1/LOAN_ID) }</ns0:LOAN_ID>
        </ns0:InputParameters>
};

declare variable $consultaCalendarioPagoPrestamo1 as element(ns1:consultaCalendarioPagoPrestamo) external;

xf:consultaCalendarioPagoPrestamoIn($consultaCalendarioPagoPrestamo1)