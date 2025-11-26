(:: pragma bea:global-element-parameter parameter="$pagodeTCenFTResponse" element="ns1:PagodeTCenFTResponse" location="../../../../v2/BusinessServices/T24/svcPagoTarjetaCredito_DebitoCuenta/xsd/PagoTarjetaCredito_DebitoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/pagoTCHNHeaderOut/";

declare function xf:pagoTCHNHeaderOut($pagodeTCenFTResponse as element(ns1:PagodeTCenFTResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $transactionId in $pagodeTCenFTResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $pagodeTCenFTResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $pagodeTCenFTResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $CREDITVALUEDATE in $pagodeTCenFTResponse/FUNDSTRANSFERType/CREDITVALUEDATE
                return
                    <valueDate>{ data($CREDITVALUEDATE) }</valueDate>
            }
        </ns0:ResponseHeader>
};

declare variable $pagodeTCenFTResponse as element(ns1:PagodeTCenFTResponse) external;

xf:pagoTCHNHeaderOut($pagodeTCenFTResponse)
