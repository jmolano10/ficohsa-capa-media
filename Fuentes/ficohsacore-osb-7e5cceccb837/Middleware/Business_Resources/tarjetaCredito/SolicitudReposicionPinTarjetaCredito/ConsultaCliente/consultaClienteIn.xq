(:: pragma bea:global-element-parameter parameter="$solicitudReposicionPinTarjetaCredito" element="ns1:solicitudReposicionPinTarjetaCredito" location="../solicitudReposicionPinTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaCliente" location="../../../consultasCliente/Resources/consultaClientesTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/solicitudReposicionPinTarjetaCreditoTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/SolicitudReposicionPinTarjetaCredito/ConsultaCliente/consultaClienteIn/";

declare function xf:consultaClienteIn($solicitudReposicionPinTarjetaCredito as element(ns1:solicitudReposicionPinTarjetaCredito))
    as element(ns0:consultaCliente) {
        <ns0:consultaCliente>
            <CUSTOMER_ID>{ data($solicitudReposicionPinTarjetaCredito/CUSTOMER_ID) }</CUSTOMER_ID>
        </ns0:consultaCliente>
};

declare variable $solicitudReposicionPinTarjetaCredito as element(ns1:solicitudReposicionPinTarjetaCredito) external;

xf:consultaClienteIn($solicitudReposicionPinTarjetaCredito)