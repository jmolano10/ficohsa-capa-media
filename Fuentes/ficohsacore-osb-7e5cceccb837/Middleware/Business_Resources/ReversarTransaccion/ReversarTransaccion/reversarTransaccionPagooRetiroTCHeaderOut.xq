(:: pragma bea:global-element-parameter parameter="$autorizareversapagooretiroTCResponse" element="ns0:AutorizareversapagooretiroTCResponse" location="../Resources/XMLSchema_-193201527.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ReversarTransaccion/ReversarTransaccion/reversarTransaccionPagooRetiroTCHeaderOut/";

declare function xf:reversarTransaccionPagooRetiroTCHeaderOut($autorizareversapagooretiroTCResponse as element(ns0:AutorizareversapagooretiroTCResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $autorizareversapagooretiroTCResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $autorizareversapagooretiroTCResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $autorizareversapagooretiroTCResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $result :=
                    for $DATETIME in $autorizareversapagooretiroTCResponse/TELLERFINANCIALSERVICESType/gDATETIME/DATETIME
                    return
                        <valueDate>{ concat("20",$DATETIME) }</valueDate>
                return
                    $result[1]
            }
        </ns1:ResponseHeader>
};

declare variable $autorizareversapagooretiroTCResponse as element(ns0:AutorizareversapagooretiroTCResponse) external;

xf:reversarTransaccionPagooRetiroTCHeaderOut($autorizareversapagooretiroTCResponse)