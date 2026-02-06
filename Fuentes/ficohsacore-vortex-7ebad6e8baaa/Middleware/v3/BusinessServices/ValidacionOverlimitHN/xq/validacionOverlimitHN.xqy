xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../xsd/validacionOverlimit_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v3/BusinessServices/ValidacionOverlimitHN/xq/validacionOverlimitHN/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validacionOverlimit";

declare function xf:validacionOverlimitHN($Monto as xs:decimal,
    $Saldo as xs:decimal,
    $Moneda as xs:string,
    $Debitos as xs:decimal,
    $Creditos as xs:decimal,
    $Pais as xs:string,
    $CruceMoneda as xs:string,
    $TasaCambio as xs:decimal,
    $Identidad as xs:string,
    $CodCliente as xs:decimal)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PN_MONTOPAGO>{ $Monto }</ns0:PN_MONTOPAGO>
            <ns0:PN_SALDOACTUAL>{ $Saldo }</ns0:PN_SALDOACTUAL>
            <ns0:PV_MONEDASALDO>{ $Moneda }</ns0:PV_MONEDASALDO>
            <ns0:PN_MEMO_DB>{ $Debitos }</ns0:PN_MEMO_DB>
            <ns0:PN_MEMO_CR>{ $Creditos }</ns0:PN_MEMO_CR>
            <ns0:PV_PAIS>{ $Pais }</ns0:PV_PAIS>
            <ns0:PV_CRUCE_MONEDA>{$CruceMoneda }</ns0:PV_CRUCE_MONEDA>
            <ns0:PN_TASA_CAMBIO>{ $TasaCambio }</ns0:PN_TASA_CAMBIO>
            <ns0:PV_IDENTIDAD>{ $Identidad }</ns0:PV_IDENTIDAD>
            <ns0:PN_CODIGO_CLIENTE>{ $CodCliente }</ns0:PN_CODIGO_CLIENTE>
        </ns0:InputParameters>
};

declare variable $Monto as xs:decimal external;
declare variable $Saldo as xs:decimal external;
declare variable $Moneda as xs:string external;
declare variable $Debitos as xs:decimal external;
declare variable $Creditos as xs:decimal external;
declare variable $Pais as xs:string external;
declare variable $CruceMoneda as xs:string external;
declare variable $TasaCambio as xs:decimal external;
declare variable $Identidad as xs:string external;
declare variable $CodCliente as xs:decimal external;

xf:validacionOverlimitHN($Monto,
    $Saldo,
    $Moneda,
    $Debitos,
    $Creditos,
    $Pais,
    $CruceMoneda,
    $TasaCambio,
    $Identidad,
    $CodCliente)