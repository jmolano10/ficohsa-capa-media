(:: pragma bea:global-element-parameter parameter="$cancelaciondecuentaparte2Response1" element="ns0:Cancelaciondecuentaparte2Response" location="../Resources/XMLSchema_1790235882.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/cancelacionCuentaAhorros/CancelacionCuentaAhorros/cancelacionCuentaAhorrosParte2ErrorHeaderOut/";

declare function xf:cancelacionCuentaAhorrosParte2ErrorHeaderOut($cancelaciondecuentaparte2Response1 as element(ns0:Cancelaciondecuentaparte2Response))
    as element(ns1:ResponseHeader) {
        let $Status := $cancelaciondecuentaparte2Response1/Status
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
                		<messages>REMITIR CLIENTE A SAC</messages>
            </ns1:ResponseHeader>
};

declare variable $cancelaciondecuentaparte2Response1 as element(ns0:Cancelaciondecuentaparte2Response) external;

xf:cancelacionCuentaAhorrosParte2ErrorHeaderOut($cancelaciondecuentaparte2Response1)