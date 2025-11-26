(:: pragma bea:global-element-parameter parameter="$consultaCalendarioPagoPrestamoCB" element="ns0:consultaCalendarioPagoPrestamo" location="../xsd/ConsultaCalendarioPagoPrestamoCBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaCalendarioPagoPrestamo" location="../../../../Business_Resources/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaCalendarioPagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCalendarioPagoPrestamoCB/xq/consultaCalendarioPagoPrestamoCBIN/";

declare function xf:consultaCalendarioPagoPrestamoCBIN($consultaCalendarioPagoPrestamoCB as element(ns0:consultaCalendarioPagoPrestamo))
    as element(ns0:consultaCalendarioPagoPrestamo) {
        <ns0:consultaCalendarioPagoPrestamo>
            <LOAN_ID>{ data($consultaCalendarioPagoPrestamoCB/LOAN_ID) }</LOAN_ID>
        </ns0:consultaCalendarioPagoPrestamo>
};

declare variable $consultaCalendarioPagoPrestamoCB as element(ns0:consultaCalendarioPagoPrestamo) external;

xf:consultaCalendarioPagoPrestamoCBIN($consultaCalendarioPagoPrestamoCB)