(:: pragma bea:global-element-return element="ns0:reversarTransaccion" location="../../../../Business_Resources/ReversarTransaccion/ReversarTransaccion/reversarTransaccionTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reversarTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoDETDEI/xq/pagpDETDEIReversarTransaccion/";

declare function xf:pagpDETDEIReversarTransaccion($TRANSACTIONID as xs:string,
    $TRANSACTIONTYPE as xs:string)
    as element(ns0:reversarTransaccion) {
        <ns0:reversarTransaccion>
            <TRANSACTION_ID>{ $TRANSACTIONID }</TRANSACTION_ID>
            <TRANSACTION_TYPE>{ $TRANSACTIONTYPE }</TRANSACTION_TYPE>
        </ns0:reversarTransaccion>
};

declare variable $TRANSACTIONID as xs:string external;
declare variable $TRANSACTIONTYPE as xs:string external;

xf:pagpDETDEIReversarTransaccion($TRANSACTIONID,
    $TRANSACTIONTYPE)