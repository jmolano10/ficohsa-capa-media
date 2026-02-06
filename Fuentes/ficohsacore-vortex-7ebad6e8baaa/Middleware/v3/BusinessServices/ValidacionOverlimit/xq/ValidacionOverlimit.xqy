xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../xsd/ValidacionOverlimit_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidacionOverlimit";
declare namespace xf = "http://tempuri.org/Middleware/v3/BusinessServices/ValidacionOverlimit/xq/ValidacionOverlimit/";

declare function xf:ValidacionOverlimit($Monto as xs:decimal,
    $Saldo as xs:decimal,
    $Moneda as xs:string,
    $Debitos as xs:decimal,
    $Creditos as xs:decimal,
    $Pais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PN_MONTOPAGO>{ $Monto }</ns0:PN_MONTOPAGO>
            <ns0:PN_SALDOACTUAL>{ $Saldo }</ns0:PN_SALDOACTUAL>
            <ns0:PV_MONEDASALDO>{ $Moneda }</ns0:PV_MONEDASALDO>
            <ns0:PN_MEMO_DB>{ $Debitos }</ns0:PN_MEMO_DB>
            <ns0:PN_MEMO_CR>{ $Creditos }</ns0:PN_MEMO_CR>
            <ns0:PV_PAIS>{ $Pais }</ns0:PV_PAIS>
        </ns0:InputParameters>
};

declare variable $Monto as xs:decimal external;
declare variable $Saldo as xs:decimal external;
declare variable $Moneda as xs:string external;
declare variable $Debitos as xs:decimal external;
declare variable $Creditos as xs:decimal external;
declare variable $Pais as xs:string external;

xf:ValidacionOverlimit($Monto,
    $Saldo,
    $Moneda,
    $Debitos,
    $Creditos,
    $Pais)