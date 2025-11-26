(:: pragma bea:global-element-parameter parameter="$consultaMovimientosRecientesTC" element="ns1:consultaMovimientosRecientesTC" location="../../../../Business_Resources/tarjetaCredito/ConsultaMovimientosRecientesTC/consultaMovimientosRecientesTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:sjConsultaMovsRecientesTCNIRequest" location="../../../BusinessServices/SJS/consultaMovsRecientesTCNI/xsd/sjConsultaMovsRecientesTCNI.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMovimientosRecientesTCTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMovsRecientesTCNI";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosRecientesTC/xq/sjConsultaMovsRecientesTCNIIn/";

declare function xf:sjConsultaMovsRecientesTCNIIn($consultaMovimientosRecientesTC as element(ns1:consultaMovimientosRecientesTC))
    as element(ns0:sjConsultaMovsRecientesTCNIRequest) {
        <ns0:sjConsultaMovsRecientesTCNIRequest>
            <ns0:CARD_NUMBER>{ data($consultaMovimientosRecientesTC/CARD_NUMBER) }</ns0:CARD_NUMBER>
        </ns0:sjConsultaMovsRecientesTCNIRequest>
};

declare variable $consultaMovimientosRecientesTC as element(ns1:consultaMovimientosRecientesTC) external;

xf:sjConsultaMovsRecientesTCNIIn($consultaMovimientosRecientesTC)