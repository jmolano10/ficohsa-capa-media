(:: pragma bea:global-element-parameter parameter="$consultaMovimientosCuentaResponse1" element="ns1:ConsultaMovimientosCuentaResponse" location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosCuenta/xq/ConsultaMovimientosCuentaHeaderOut/";

declare function xf:ConsultaMovimientosCuentaHeaderOut($consultaMovimientosCuentaResponse1 as element(ns1:ConsultaMovimientosCuentaResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $successIndicator in $consultaMovimientosCuentaResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
        </ns0:ResponseHeader>
};

declare variable $consultaMovimientosCuentaResponse1 as element(ns1:ConsultaMovimientosCuentaResponse) external;

xf:ConsultaMovimientosCuentaHeaderOut($consultaMovimientosCuentaResponse1)