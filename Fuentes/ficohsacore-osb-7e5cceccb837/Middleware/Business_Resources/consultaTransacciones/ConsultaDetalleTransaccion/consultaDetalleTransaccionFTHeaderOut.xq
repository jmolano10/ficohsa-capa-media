(:: pragma bea:global-element-parameter parameter="$consultadetransaccionFTResponse1" element="ns0:ConsultadetransaccionFTResponse" location="../Resources/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaDetalleTransferencia/consultaDetalleTransaccion/consultaDetalleTransaccionFTHeaderOut/";

declare function xf:consultaDetalleTransaccionFTHeaderOut($consultadetransaccionFTResponse1 as element(ns0:ConsultadetransaccionFTResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $consultadetransaccionFTResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $consultadetransaccionFTResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $consultadetransaccionFTResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadetransaccionFTResponse1 as element(ns0:ConsultadetransaccionFTResponse) external;

xf:consultaDetalleTransaccionFTHeaderOut($consultadetransaccionFTResponse1)