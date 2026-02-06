xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagodetarjetadecreditoResponse" element="ns0:PagodetarjetadecreditoResponse" location="../Resources/XMLSchema_-604480245.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/PagoTarjetaCredito/pagoTarjetaCreditoHeaderOut/";

declare function xf:pagoTarjetaCreditoHeaderOut($pagodetarjetadecreditoResponse as element(ns0:PagodetarjetadecreditoResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $pagodetarjetadecreditoResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $pagodetarjetadecreditoResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $pagodetarjetadecreditoResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $DRVALUEDATE in $pagodetarjetadecreditoResponse/TELLERFINANCIALSERVICESType/gTRANSACTION/mTRANSACTION[1]/DRVALUEDATE
                return
                    <valueDate>{ data($DRVALUEDATE) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $pagodetarjetadecreditoResponse as element(ns0:PagodetarjetadecreditoResponse) external;

xf:pagoTarjetaCreditoHeaderOut($pagodetarjetadecreditoResponse)