(:: pragma bea:global-element-parameter parameter="$autorizacionreversionTTResponse" element="ns0:AutorizacionreversionTTResponse" location="../../xsds/ReversaTransaccion/XMLSchema_-193201527.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionTTHeaderOut/";

declare function xf:ReversarTransaccionTTHeaderOut($autorizacionreversionTTResponse as element(ns0:AutorizacionreversionTTResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $autorizacionreversionTTResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $autorizacionreversionTTResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $autorizacionreversionTTResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $VALUEDATE1 in $autorizacionreversionTTResponse/TELLERType/VALUEDATE1
                return
                    <valueDate>{ data($VALUEDATE1) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $autorizacionreversionTTResponse as element(ns0:AutorizacionreversionTTResponse) external;

xf:ReversarTransaccionTTHeaderOut($autorizacionreversionTTResponse)