xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagodetarjetaCreditoResponse" element="ns1:PagoTarjetaCreditoV4Response" location="../../../BusinessServices/T24/svcPayCreditCardFT/XMLSchema_1.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v4/Resources/PagoTarjetaCredito/xq/pagoTarjetaCreditoHeaderOut1/";

declare function xf:pagoTarjetaCreditoHeaderOut1($pagodetarjetaCreditoResponse as element(ns1:PagoTarjetaCreditoV4Response))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $transactionId in $pagodetarjetaCreditoResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $pagodetarjetaCreditoResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $pagodetarjetaCreditoResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $DEBITVALUEDATE in $pagodetarjetaCreditoResponse/FUNDSTRANSFERType/DEBITVALUEDATE
                return
                    <valueDate>{ data($DEBITVALUEDATE) }</valueDate>
            }
        </ns0:ResponseHeader>
};

declare variable $pagodetarjetaCreditoResponse as element(ns1:PagoTarjetaCreditoV4Response) external;

xf:pagoTarjetaCreditoHeaderOut1($pagodetarjetaCreditoResponse)