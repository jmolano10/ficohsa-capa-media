(:: pragma bea:global-element-parameter parameter="$solicitudReposicionPinTarjetaCredito" element="ns1:solicitudReposicionPinTarjetaCredito" location="../solicitudReposicionPinTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaAgenciasBanco" location="../../../Core/consultaAgenciasBanco/consultaAgenciasBancoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/solicitudReposicionPinTarjetaCreditoTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaAgenciasBancoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/SolicitudReposicionPinTarjetaCredito/consultaAgenciasBanco/consultaAgenciasBanco/";

declare function xf:consultaAgenciasBanco($solicitudReposicionPinTarjetaCredito as element(ns1:solicitudReposicionPinTarjetaCredito))
    as element(ns0:consultaAgenciasBanco) {
        <ns0:consultaAgenciasBanco>
            <BRANCH_CODE>{ data($solicitudReposicionPinTarjetaCredito/WITHDRAWAL_BRANCH_CODE) }</BRANCH_CODE>
        </ns0:consultaAgenciasBanco>
};

declare variable $solicitudReposicionPinTarjetaCredito as element(ns1:solicitudReposicionPinTarjetaCredito) external;

xf:consultaAgenciasBanco($solicitudReposicionPinTarjetaCredito)