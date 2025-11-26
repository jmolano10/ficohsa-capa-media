(:: pragma bea:global-element-parameter parameter="$transferenciaInternacionalResponse" element="ns0:TransferenciaInternacionalResponse" location="../Resources/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Transferencias/TransferenciaInternacional/transferenciaInternacionalHeaderOut/";

declare function xf:transferenciaInternacionalHeaderOut($transferenciaInternacionalResponse as element(ns0:TransferenciaInternacionalResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $transferenciaInternacionalResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $transferenciaInternacionalResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $transferenciaInternacionalResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $DEBITVALUEDATE in $transferenciaInternacionalResponse/FUNDSTRANSFERType/DEBITVALUEDATE
                return
                    <valueDate>{ data($DEBITVALUEDATE) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $transferenciaInternacionalResponse as element(ns0:TransferenciaInternacionalResponse) external;

xf:transferenciaInternacionalHeaderOut($transferenciaInternacionalResponse)