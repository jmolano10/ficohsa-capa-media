(:: pragma bea:global-element-parameter parameter="$solicitudReposicionTarjetaCredito" element="ns0:solicitudReposicionTarjetaCredito" location="../solicitudReposicionTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaCliente" location="../../../consultasCliente/Resources/consultaClientesTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/solicitudReposicionTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/SolicitudReposicionTarjetaCredito/ConsultaCliente/consultaClienteIn/";

declare function xf:consultaClienteIn($solicitudReposicionTarjetaCredito as element(ns0:solicitudReposicionTarjetaCredito))
    as element(ns1:consultaCliente) {
        <ns1:consultaCliente>
            <CUSTOMER_ID>{ data($solicitudReposicionTarjetaCredito/CUSTOMER_ID) }</CUSTOMER_ID>
        </ns1:consultaCliente>
};

declare variable $solicitudReposicionTarjetaCredito as element(ns0:solicitudReposicionTarjetaCredito) external;

xf:consultaClienteIn($solicitudReposicionTarjetaCredito)