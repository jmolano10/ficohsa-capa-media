xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:reversarTransaccion" location="../../../../Business_Resources/ReversarTransaccion/ReversarTransaccion/reversarTransaccionTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reversarTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversarTransaccion/xq/reversarTransaccionFTIn_StringParams/";

declare function xf:reversarTransaccionFTIn_StringParams($TransactionID as xs:string,
    $TansactionType as xs:string)
    as element(ns0:reversarTransaccion) {
        <ns0:reversarTransaccion>
            <TRANSACTION_ID>{ $TransactionID }</TRANSACTION_ID>
        </ns0:reversarTransaccion>
};

declare variable $TransactionID as xs:string external;
declare variable $TansactionType as xs:string external;

xf:reversarTransaccionFTIn_StringParams($TransactionID,
    $TansactionType)