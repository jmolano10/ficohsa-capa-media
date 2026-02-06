xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ValidacionOverlimit/xsd/ValidacionOverlimit_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidacionOverlimit";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/ConnectionProxyAbanksPA/";

declare function xf:ConnectionProxyAbanksPA($MONTO_PAGO as xs:decimal,
    $SALDO_ACTUAL as xs:decimal,
    $MEMO_DB as xs:decimal,
    $MEMO_CR as xs:decimal,
    $PAIS as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PN_MONTOPAGO>{ $MONTO_PAGO }</ns0:PN_MONTOPAGO>
            <ns0:PN_SALDOACTUAL>{ $SALDO_ACTUAL }</ns0:PN_SALDOACTUAL>
            <ns0:PN_MEMO_DB>{ $MEMO_DB }</ns0:PN_MEMO_DB>
            <ns0:PN_MEMO_CR>{ $MEMO_CR }</ns0:PN_MEMO_CR>
            <ns0:PV_PAIS>{ $PAIS }</ns0:PV_PAIS>
        </ns0:InputParameters>
};

declare variable $MONTO_PAGO as xs:decimal external;
declare variable $SALDO_ACTUAL as xs:decimal external;
declare variable $MEMO_DB as xs:decimal external;
declare variable $MEMO_CR as xs:decimal external;
declare variable $PAIS as xs:string external;

xf:ConnectionProxyAbanksPA($MONTO_PAGO,
    $SALDO_ACTUAL,
    $MEMO_DB,
    $MEMO_CR,
    $PAIS)