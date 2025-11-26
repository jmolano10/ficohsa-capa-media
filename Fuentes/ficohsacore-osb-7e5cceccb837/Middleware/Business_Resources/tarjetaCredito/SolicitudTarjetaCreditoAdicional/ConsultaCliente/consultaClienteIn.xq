(:: pragma bea:global-element-parameter parameter="$solicitudTarjetaCreditoAdicional" element="ns0:solicitudTarjetaCreditoAdicional" location="../solicitudTarjetaCreditoAdicionalTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaCliente" location="../../../consultasCliente/Resources/consultaClientesTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/solicitudTarjetaCreditoAdicionalTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/SolicitudTarjetaCreditoAdicional/ConsultaCliente/consultaClienteIn/";

declare function xf:consultaClienteIn($solicitudTarjetaCreditoAdicional as element(ns0:solicitudTarjetaCreditoAdicional))
    as element(ns1:consultaCliente) {
        <ns1:consultaCliente>
            <CUSTOMER_ID>{ data($solicitudTarjetaCreditoAdicional/CUSTOMER_ID) }</CUSTOMER_ID>
        </ns1:consultaCliente>
};

declare variable $solicitudTarjetaCreditoAdicional as element(ns0:solicitudTarjetaCreditoAdicional) external;

xf:consultaClienteIn($solicitudTarjetaCreditoAdicional)