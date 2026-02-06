xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadetransaccionFTResponse" element="ns0:ConsultadetransaccionFTResponse" location="../Resources/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaTransacciones/ConsultaDetalleCompletoTransaccion/consultaDetalleCompletoTransaccionFTHeaderOut/";

declare function xf:consultaDetalleCompletoTransaccionFTHeaderOut($consultadetransaccionFTResponse as element(ns0:ConsultadetransaccionFTResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $successIndicator in $consultadetransaccionFTResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $consultadetransaccionFTResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadetransaccionFTResponse as element(ns0:ConsultadetransaccionFTResponse) external;

xf:consultaDetalleCompletoTransaccionFTHeaderOut($consultadetransaccionFTResponse)