xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterData/conTransaccionRedencion/xsd/conTransaccionRedencion_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTransaccionRedencion";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversionPuntosLealtad/xq/conTransaccionRedencion/";

declare function xf:conTransaccionRedencion($pais as xs:string,
    $cardNumber as xs:string,
    $transactionID as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:NumeroTarjeta>{ data($cardNumber) }</ns0:NumeroTarjeta>
            <ns0:IDTransaccion>{ data($transactionID) }</ns0:IDTransaccion>
            <ns0:Pais>{ data($pais) }</ns0:Pais>
        </ns0:InputParameters>
};

declare variable $pais as xs:string external;
declare variable $cardNumber as xs:string external;
declare variable $transactionID as xs:string external;

xf:conTransaccionRedencion($pais,
    $cardNumber,
    $transactionID)