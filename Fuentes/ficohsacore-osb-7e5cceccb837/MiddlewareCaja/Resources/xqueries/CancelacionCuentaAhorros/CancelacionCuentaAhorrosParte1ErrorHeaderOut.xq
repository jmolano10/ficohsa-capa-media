(:: pragma bea:global-element-parameter parameter="$cancelaciondecuentaparte1Response" element="ns0:Cancelaciondecuentaparte1Response" location="../../xsds/CancelacionCuenta/XMLSchema_1790235882.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/CancelacionCuentaAhorros/CancelacionCuentaAhorrosParte1ErrorHeaderOut/";

declare function xf:CancelacionCuentaAhorrosParte1ErrorHeaderOut($cancelaciondecuentaparte1Response as element(ns0:Cancelaciondecuentaparte1Response))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $cancelaciondecuentaparte1Response/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $cancelaciondecuentaparte1Response/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $cancelaciondecuentaparte1Response/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $cancelaciondecuentaparte1Response as element(ns0:Cancelaciondecuentaparte1Response) external;

xf:CancelacionCuentaAhorrosParte1ErrorHeaderOut($cancelaciondecuentaparte1Response)