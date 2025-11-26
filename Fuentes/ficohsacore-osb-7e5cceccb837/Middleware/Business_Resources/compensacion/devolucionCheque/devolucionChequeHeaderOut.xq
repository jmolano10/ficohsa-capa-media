(:: pragma bea:global-element-parameter parameter="$aplicadevolucionporchequeResponse1" element="ns0:AplicadevolucionporchequeResponse" location="../resources/XMLSchema_1569843523.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/compensacion/devolucionCheque/devolucionChequeHeaderOut/";

declare function xf:devolucionChequeHeaderOut($aplicadevolucionporchequeResponse1 as element(ns0:AplicadevolucionporchequeResponse))
    as element(ns1:ResponseHeader) {
        let $Status := $aplicadevolucionporchequeResponse1/Status
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
                {
                    for $VALUEDATE in $aplicadevolucionporchequeResponse1/CHEQUECOLLECTIONType/VALUEDATE
                    return
                        <valueDate>{ data($VALUEDATE) }</valueDate>
                }
            </ns1:ResponseHeader>
};

declare variable $aplicadevolucionporchequeResponse1 as element(ns0:AplicadevolucionporchequeResponse) external;

xf:devolucionChequeHeaderOut($aplicadevolucionporchequeResponse1)