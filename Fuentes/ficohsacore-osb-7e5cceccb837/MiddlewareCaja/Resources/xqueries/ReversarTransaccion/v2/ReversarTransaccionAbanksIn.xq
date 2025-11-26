(:: pragma bea:global-element-parameter parameter="$reversarTransaccion1" element="ns0:reversarTransaccion" location="../../../xsds/ReversarTransaccion/ReversarTransaccion.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../xsds/ReversaTransaccion/ReversionRecaudoAbanks/v2/reversionRecaudoAbanks_v2_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/reversionRecaudoAbanks_v2";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reversarTransaccionTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversarTransaccion/v2/ReversarTransaccionAbanksIn/";

declare function xf:ReversarTransaccionAbanksIn($reversarTransaccion1 as element(ns0:reversarTransaccion),
    $userId as xs:string,
    $branchCode as xs:string,
    $date as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_USUARIO>{ $userId }</ns1:PV_USUARIO>
            <ns1:PV_AGENCIA>{ $branchCode }</ns1:PV_AGENCIA>
            <ns1:PV_TRANSACCION>{ data($reversarTransaccion1/TRANSACTION_ID) }</ns1:PV_TRANSACCION>
            <ns1:PV_FECHA>{ $date }</ns1:PV_FECHA>
        </ns1:InputParameters>
};

declare variable $reversarTransaccion1 as element(ns0:reversarTransaccion) external;
declare variable $userId as xs:string external;
declare variable $branchCode as xs:string external;
declare variable $date as xs:string external;

xf:ReversarTransaccionAbanksIn($reversarTransaccion1,
    $userId,
    $branchCode,
    $date)