(:: pragma bea:global-element-parameter parameter="$actualizaLimiteVentaClienteResponse" element="ns0:ActualizaLimiteVentaClienteResponse" location="../../../BusinessServices/AmpliacionLimiteClienteVenta/xsd/XMLSchema_161558775.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ampliacionLimiteClienteVentaResponse" location="../xsd/ampliacionLimiteClienteVentaTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/ampliacionLimiteClienteVentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AmpliacionLimiteClienteVenta/xq/ampliacionLimiteClienteVentaOut/";

declare function xf:ampliacionLimiteClienteVentaOut($actualizaLimiteVentaClienteResponse as element(ns0:ActualizaLimiteVentaClienteResponse))
    as element(ns1:ampliacionLimiteClienteVentaResponse) {
        <ns1:ampliacionLimiteClienteVentaResponse>
            <CUSTOMER_ID>{ data($actualizaLimiteVentaClienteResponse/CUSTOMERType/@id) }</CUSTOMER_ID>
        </ns1:ampliacionLimiteClienteVentaResponse>
};

declare variable $actualizaLimiteVentaClienteResponse as element(ns0:ActualizaLimiteVentaClienteResponse) external;

xf:ampliacionLimiteClienteVentaOut($actualizaLimiteVentaClienteResponse)