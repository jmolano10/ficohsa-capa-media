(:: pragma bea:global-element-parameter parameter="$autorizacionreversionFTResponse" element="ns0:AutorizacionreversionFTResponse" location="../../xsds/ReversaTransaccion/XMLSchema_-193201527.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionFTHeaderOut/";

declare function xf:ReversarTransaccionFTHeaderOut($autorizacionreversionFTResponse as element(ns0:AutorizacionreversionFTResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $autorizacionreversionFTResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $autorizacionreversionFTResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $autorizacionreversionFTResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $CREDITVALUEDATE in $autorizacionreversionFTResponse/FUNDSTRANSFERType/CREDITVALUEDATE
                return
                    <valueDate>{ data($CREDITVALUEDATE) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $autorizacionreversionFTResponse as element(ns0:AutorizacionreversionFTResponse) external;

xf:ReversarTransaccionFTHeaderOut($autorizacionreversionFTResponse)