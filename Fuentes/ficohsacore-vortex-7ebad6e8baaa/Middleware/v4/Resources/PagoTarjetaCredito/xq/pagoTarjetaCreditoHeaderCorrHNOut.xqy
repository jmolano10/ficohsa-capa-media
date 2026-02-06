xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCreditoTengoResponse" element="ns1:PagoTarjetaCreditoTengoResponse" location="../../../../v2/BusinessServices/T24/svcRegistraTransaccionTengo/xsd/scvRegistraTransaccionTengoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/pagoTarjetaCreditoHeaderCorrHNOut/";

declare function xf:pagoTarjetaCreditoHeaderCorrHNOut($pagoTarjetaCreditoTengoResponse as element(ns1:PagoTarjetaCreditoTengoResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $transactionId in $pagoTarjetaCreditoTengoResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $pagoTarjetaCreditoTengoResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $pagoTarjetaCreditoTengoResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
             {
                for $DRVALUEDATE in $pagoTarjetaCreditoTengoResponse/TELLERFINANCIALSERVICESType/gTRANSACTION/mTRANSACTION[1]/DRVALUEDATE
                return
                    <valueDate>{ data($DRVALUEDATE) }</valueDate>
            }
        </ns0:ResponseHeader>
};

declare variable $pagoTarjetaCreditoTengoResponse as element(ns1:PagoTarjetaCreditoTengoResponse) external;

xf:pagoTarjetaCreditoHeaderCorrHNOut($pagoTarjetaCreditoTengoResponse)