xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$autorizareversapagooretiroTCResponse" element="ns0:AutorizareversapagooretiroTCResponse" location="../../xsds/ReversaTransaccion/XMLSchema_-193201527.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionPagooRetiroTCHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:ReversarTransaccionPagooRetiroTCHeaderOut($autorizareversapagooretiroTCResponse as element(ns0:AutorizareversapagooretiroTCResponse))
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

xf:ReversarTransaccionPagooRetiroTCHeaderOut($autorizareversapagooretiroTCResponse)