(:: pragma bea:global-element-parameter parameter="$cancelaciondecuentaparte1Response1" element="ns0:Cancelaciondecuentaparte1Response" location="../Resources/XMLSchema_1790235882.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/cancelacionCuentaAhorros/CancelacionCuentaAhorros/cancelacionCuentaAhorrosParte1HeaderOut/";

declare function xf:cancelacionCuentaAhorrosParte1HeaderOut($cancelaciondecuentaparte1Response1 as element(ns0:Cancelaciondecuentaparte1Response))
    as element(ns1:ResponseHeader) {
        let $Status := $cancelaciondecuentaparte1Response1/Status
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

declare variable $cancelaciondecuentaparte1Response1 as element(ns0:Cancelaciondecuentaparte1Response) external;

xf:cancelacionCuentaAhorrosParte1HeaderOut($cancelaciondecuentaparte1Response1)