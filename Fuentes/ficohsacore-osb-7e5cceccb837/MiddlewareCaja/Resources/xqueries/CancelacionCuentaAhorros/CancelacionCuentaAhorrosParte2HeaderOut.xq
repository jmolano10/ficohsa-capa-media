(:: pragma bea:global-element-parameter parameter="$cancelaciondecuentaparte2Response" element="ns0:Cancelaciondecuentaparte2Response" location="../../xsds/CancelacionCuenta/XMLSchema_1790235882.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/CancelacionCuentaAhorros/CancelacionCuentaAhorrosParte2HeaderOut/";

declare function xf:CancelacionCuentaAhorrosParte2HeaderOut($cancelaciondecuentaparte2Response as element(ns0:Cancelaciondecuentaparte2Response))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $cancelaciondecuentaparte2Response/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $cancelaciondecuentaparte2Response/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $cancelaciondecuentaparte2Response/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $VALUEDATE1 in $cancelaciondecuentaparte2Response/TELLERType/VALUEDATE1
                return
                    <valueDate>{ data($VALUEDATE1) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $cancelaciondecuentaparte2Response as element(ns0:Cancelaciondecuentaparte2Response) external;

xf:CancelacionCuentaAhorrosParte2HeaderOut($cancelaciondecuentaparte2Response)