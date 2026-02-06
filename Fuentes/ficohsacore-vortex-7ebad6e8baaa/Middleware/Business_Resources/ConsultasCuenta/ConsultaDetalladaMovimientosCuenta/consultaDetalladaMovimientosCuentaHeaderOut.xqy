xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadetalladademovscuentaResponse" element="ns0:ConsultadetalladademovscuentaResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaDetalladaMovimientosCuenta/consultaDetalladaMovimientosCuentaHeaderOut/";

declare function xf:consultaDetalladaMovimientosCuentaHeaderOut($consultadetalladademovscuentaResponse as element(ns0:ConsultadetalladademovscuentaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $successIndicator in $consultadetalladademovscuentaResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $consultadetalladademovscuentaResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadetalladademovscuentaResponse as element(ns0:ConsultadetalladademovscuentaResponse) external;

xf:consultaDetalladaMovimientosCuentaHeaderOut($consultadetalladademovscuentaResponse)