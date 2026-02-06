xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:reversarTransaccion" location="../../ReversarTransaccion/ReversarTransaccion/reversarTransaccionTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reversarTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoPrestamo/reversarTransaccion/reversarTransaccionIn/";

declare function xf:reversarTransaccionIn($transactionId as xs:string)
    as element(ns0:reversarTransaccion) {
        <ns0:reversarTransaccion>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
        </ns0:reversarTransaccion>
};

declare variable $transactionId as xs:string external;

xf:reversarTransaccionIn($transactionId)