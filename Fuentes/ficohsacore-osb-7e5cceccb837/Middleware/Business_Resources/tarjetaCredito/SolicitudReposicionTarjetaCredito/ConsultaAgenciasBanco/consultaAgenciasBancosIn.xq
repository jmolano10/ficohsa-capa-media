(:: pragma bea:global-element-parameter parameter="$solicitudReposicionTarjetaCredito" element="ns1:solicitudReposicionTarjetaCredito" location="../solicitudReposicionTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaAgenciasBanco" location="../../../Core/consultaAgenciasBanco/consultaAgenciasBancoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/solicitudReposicionTarjetaCreditoTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaAgenciasBancoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/SolicitudReposicionTarjetaCredito/ConsultaAgenciasBanco/consultaAgenciasBancosIn/";

declare function xf:consultaAgenciasBancosIn($solicitudReposicionTarjetaCredito as element(ns1:solicitudReposicionTarjetaCredito))
    as element(ns0:consultaAgenciasBanco) {
        <ns0:consultaAgenciasBanco>
            <BRANCH_CODE>{ data($solicitudReposicionTarjetaCredito/WITHDRAWAL_BRANCH_CODE) }</BRANCH_CODE>
        </ns0:consultaAgenciasBanco>
};

declare variable $solicitudReposicionTarjetaCredito as element(ns1:solicitudReposicionTarjetaCredito) external;

xf:consultaAgenciasBancosIn($solicitudReposicionTarjetaCredito)