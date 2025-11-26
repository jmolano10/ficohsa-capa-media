xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$pagodeTarjetaCreditoResponse" element="ns1:PagodeTarjetaCreditoResponse" location="../../xsds/TransaccionesAutobancos/XMLSchema_1271081668.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../xsds/General/Autenticacion_v2.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCredito/PagoTarjetaCreditoHeaderOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";

declare function xf:PagoTarjetaCreditoHeaderOut($pagodeTarjetaCreditoResponse as element(ns1:PagodeTarjetaCreditoResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $transactionId in $pagodeTarjetaCreditoResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $pagodeTarjetaCreditoResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $pagodeTarjetaCreditoResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $DRVALUEDATE in $pagodeTarjetaCreditoResponse/TELLERFINANCIALSERVICESType/gTRANSACTION/mTRANSACTION[1]/DRVALUEDATE
                return
                    <valueDate>{ data($DRVALUEDATE) }</valueDate>
            }
        </ns0:ResponseHeader>
};

declare variable $pagodeTarjetaCreditoResponse as element(ns1:PagodeTarjetaCreditoResponse) external;

xf:PagoTarjetaCreditoHeaderOut($pagodeTarjetaCreditoResponse)
