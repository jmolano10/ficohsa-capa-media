(:: pragma bea:global-element-parameter parameter="$solicitudTarjetaCreditoAdicional" element="ns1:solicitudTarjetaCreditoAdicional" location="../solicitudTarjetaCreditoAdicionalTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaAgenciasBanco" location="../../../Core/consultaAgenciasBanco/consultaAgenciasBancoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/solicitudTarjetaCreditoAdicionalTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaAgenciasBancoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/SolicitudTarjetaCreditoAdicional/ConsultaAgenciasBanco/consultaAgenciasBancoIn/";

declare function xf:consultaAgenciasBancoIn($solicitudTarjetaCreditoAdicional as element(ns1:solicitudTarjetaCreditoAdicional))
    as element(ns0:consultaAgenciasBanco) {
        <ns0:consultaAgenciasBanco>
            <BRANCH_CODE>{ data($solicitudTarjetaCreditoAdicional/WITHDRAWAL_BRANCH_CODE) }</BRANCH_CODE>
        </ns0:consultaAgenciasBanco>
};

declare variable $solicitudTarjetaCreditoAdicional as element(ns1:solicitudTarjetaCreditoAdicional) external;

xf:consultaAgenciasBancoIn($solicitudTarjetaCreditoAdicional)