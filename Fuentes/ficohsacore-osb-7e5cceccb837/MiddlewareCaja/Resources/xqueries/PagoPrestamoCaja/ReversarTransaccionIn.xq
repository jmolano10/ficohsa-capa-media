(:: pragma bea:global-element-return element="ns0:reversarTransaccion" location="../../xsds/ReversarTransaccion/ReversarTransaccion.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reversarTransaccionTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoPrestamoCaja/ReversarTransaccionIn/";

declare function xf:ReversarTransaccionIn($transactionId as xs:string)
    as element(ns0:reversarTransaccion) {
        <ns0:reversarTransaccion>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
        </ns0:reversarTransaccion>
};

declare variable $transactionId as xs:string external;

xf:ReversarTransaccionIn($transactionId)