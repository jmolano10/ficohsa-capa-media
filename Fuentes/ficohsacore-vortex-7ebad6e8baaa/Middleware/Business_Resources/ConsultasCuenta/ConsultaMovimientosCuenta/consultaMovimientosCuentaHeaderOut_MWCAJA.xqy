xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultademovimientosdectaResponse1" element="ns0:ConsultademovimientosdectaResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaMovimientosCuenta/consultaMovimientosCuentaHeaderOutt/";

declare function xf:consultaMovimientosCuentaHeaderOutt($consultademovimientosdectaResponse1 as element(ns0:ConsultademovimientosdectaResponse))
    as element(ns1:ResponseHeader) {
        let $Status := $consultademovimientosdectaResponse1/Status
        return
            <ns1:ResponseHeader>
                {
                    for $transactionId in $Status/transactionId
                    return
                        <transactionId>{ data($transactionId) }</transactionId>
                }
                {
                    for $successIndicator in $Status/successIndicator
                    return
                        <successIndicator>{ data($successIndicator) }</successIndicator>
                }
                {
                    for $messages in $Status/messages
                    return
                        <messages>{ data($messages) }</messages>
                }
            </ns1:ResponseHeader>
};

declare variable $consultademovimientosdectaResponse1 as element(ns0:ConsultademovimientosdectaResponse) external;

xf:consultaMovimientosCuentaHeaderOutt($consultademovimientosdectaResponse1)