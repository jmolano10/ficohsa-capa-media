<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:reversarTransaccion" location="../../../../Business_Resources/ReversarTransaccion/ReversarTransaccion/reversarTransaccionTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reversarTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversarTransaccion/xq/reversarTransaccionFTIn_StringParams/";

declare function xf:reversarTransaccionFTIn_StringParams($TransactionID as xs:string,
    $TansactionType as xs:string)
    as element(ns0:reversarTransaccion) {
        &lt;ns0:reversarTransaccion>
            &lt;TRANSACTION_ID>{ $TransactionID }&lt;/TRANSACTION_ID>
        &lt;/ns0:reversarTransaccion>
};

declare variable $TransactionID as xs:string external;
declare variable $TansactionType as xs:string external;

xf:reversarTransaccionFTIn_StringParams($TransactionID,
    $TansactionType)</con:xquery>
    <con:dependency location="../../../../Business_Resources/ReversarTransaccion/ReversarTransaccion/reversarTransaccionTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/ReversarTransaccion/ReversarTransaccion/reversarTransaccionTypes"/>
    </con:dependency>
</con:xqueryEntry>