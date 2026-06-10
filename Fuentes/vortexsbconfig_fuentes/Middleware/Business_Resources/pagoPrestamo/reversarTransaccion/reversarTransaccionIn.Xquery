<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:reversarTransaccion" location="../../ReversarTransaccion/ReversarTransaccion/reversarTransaccionTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reversarTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoPrestamo/reversarTransaccion/reversarTransaccionIn/";

declare function xf:reversarTransaccionIn($transactionId as xs:string)
    as element(ns0:reversarTransaccion) {
        &lt;ns0:reversarTransaccion>
            &lt;TRANSACTION_ID>{ $transactionId }&lt;/TRANSACTION_ID>
        &lt;/ns0:reversarTransaccion>
};

declare variable $transactionId as xs:string external;

xf:reversarTransaccionIn($transactionId)</con:xquery>
    <con:dependency location="../../ReversarTransaccion/ReversarTransaccion/reversarTransaccionTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/ReversarTransaccion/ReversarTransaccion/reversarTransaccionTypes"/>
    </con:dependency>
</con:xqueryEntry>