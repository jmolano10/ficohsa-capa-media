xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagodetarjetadecreditoResponse" element="ns1:PagodetarjetadecreditoResponse" location="../../../../Business_Resources/tarjetaCredito/Resources/XMLSchema_-604480245.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/pagoTarjetaCreditoHeaderOut/";

declare function xf:pagoTarjetaCreditoHeaderOut($pagodetarjetadecreditoResponse as element(ns1:PagodetarjetadecreditoResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
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
        </ns0:ResponseHeader>
};

declare variable $pagodetarjetadecreditoResponse as element(ns1:PagodetarjetadecreditoResponse) external;

xf:pagoTarjetaCreditoHeaderOut($pagodetarjetadecreditoResponse)