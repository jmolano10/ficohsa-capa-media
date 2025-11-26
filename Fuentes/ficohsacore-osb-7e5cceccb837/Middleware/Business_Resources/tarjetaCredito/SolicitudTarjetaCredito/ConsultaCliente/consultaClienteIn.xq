(:: pragma bea:global-element-parameter parameter="$solicitudTarjetaCredito" element="ns1:solicitudTarjetaCredito" location="../solicitudTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaCliente" location="../../../consultasCliente/Resources/consultaClientesTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/solicitudTarjetaCreditoTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/SolicitudTarjetaCredito/ConsultaCliente/consultaClienteIn/";

declare function xf:consultaClienteIn($solicitudTarjetaCredito as element(ns1:solicitudTarjetaCredito))
    as element(ns0:consultaCliente) {
        <ns0:consultaCliente>
            <CUSTOMER_ID>{ data($solicitudTarjetaCredito/CUSTOMER_ID) }</CUSTOMER_ID>
        </ns0:consultaCliente>
};

declare variable $solicitudTarjetaCredito as element(ns1:solicitudTarjetaCredito) external;

xf:consultaClienteIn($solicitudTarjetaCredito)