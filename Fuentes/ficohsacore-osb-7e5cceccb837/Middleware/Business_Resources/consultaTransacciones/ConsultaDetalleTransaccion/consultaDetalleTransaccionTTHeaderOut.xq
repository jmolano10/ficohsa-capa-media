(:: pragma bea:global-element-parameter parameter="$consultadetransaccionTTResponse1" element="ns0:ConsultadetransaccionTTResponse" location="../Resources/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaDetalleTransferencia/consultaDetalleTransaccion/consultaDetalleTransaccionTTHeaderOut/";

declare function xf:consultaDetalleTransaccionTTHeaderOut($consultadetransaccionTTResponse1 as element(ns0:ConsultadetransaccionTTResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $consultadetransaccionTTResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $consultadetransaccionTTResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $consultadetransaccionTTResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadetransaccionTTResponse1 as element(ns0:ConsultadetransaccionTTResponse) external;

xf:consultaDetalleTransaccionTTHeaderOut($consultadetransaccionTTResponse1)