(:: pragma bea:global-element-parameter parameter="$solicitudAmpliacionLimiteTarjetaCredito" element="ns1:solicitudAmpliacionLimiteTarjetaCredito" location="../solicitudAmpliacionLimiteTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaCliente" location="../../../consultasCliente/Resources/consultaClientesTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/solicitudAmpliacionLimiteTarjetaCreditoTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/SolicitudAmpliacionLimiteTarjetaCredito/ConsultaCliente/consultaClienteIn/";

declare function xf:consultaClienteIn($solicitudAmpliacionLimiteTarjetaCredito as element(ns1:solicitudAmpliacionLimiteTarjetaCredito))
    as element(ns0:consultaCliente) {
        <ns0:consultaCliente>
            <CUSTOMER_ID>{ data($solicitudAmpliacionLimiteTarjetaCredito/CUSTOMER_ID) }</CUSTOMER_ID>
        </ns0:consultaCliente>
};

declare variable $solicitudAmpliacionLimiteTarjetaCredito as element(ns1:solicitudAmpliacionLimiteTarjetaCredito) external;

xf:consultaClienteIn($solicitudAmpliacionLimiteTarjetaCredito)