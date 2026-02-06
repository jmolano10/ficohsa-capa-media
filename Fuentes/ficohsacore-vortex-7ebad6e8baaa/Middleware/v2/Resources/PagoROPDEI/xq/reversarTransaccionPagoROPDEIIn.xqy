xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:reversarTransaccion" location="../../../../Business_Resources/ReversarTransaccion/ReversarTransaccion/reversarTransaccionTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reversarTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoROPDEI/xq/reversarTransaccionPagoROPDEI/";

declare function xf:reversarTransaccionPagoROPDEI($transactionID as xs:string,
    $transactionType as xs:string)
    as element(ns0:reversarTransaccion) {
        <ns0:reversarTransaccion>
            <TRANSACTION_ID>{ $transactionID }</TRANSACTION_ID>
            <TRANSACTION_TYPE>{ $transactionType }</TRANSACTION_TYPE>
        </ns0:reversarTransaccion>
};

declare variable $transactionID as xs:string external;
declare variable $transactionType as xs:string external;

xf:reversarTransaccionPagoROPDEI($transactionID,
    $transactionType)