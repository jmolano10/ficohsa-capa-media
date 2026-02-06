xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/PWS/reversaTC/xsd/reversaTC_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/reversaTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversaEfectivoTC/xq/reversaTCIn/";

declare function xf:reversaTCIn($cardNumber as xs:string,
    $transactionID as xs:string,
    $referenceNumber as xs:string,
    $sourceBank as xs:string,
    $destinationBank as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_NUMERO_TARJETA>{ fn-bea:pad-left($cardNumber, 19, '0') }</ns0:PV_NUMERO_TARJETA>
            {
            	if(fn-bea:trim($transactionID) != "")then(
            		<ns0:PV_SECUENCIA_MOVIMIENTO>{ $transactionID }</ns0:PV_SECUENCIA_MOVIMIENTO>
            	)else()
            }
            <ns0:PV_REFERENCIA_RECUPERACION>{ $referenceNumber }</ns0:PV_REFERENCIA_RECUPERACION>
            <ns0:PV_BANCOORIGEN>{ $sourceBank }</ns0:PV_BANCOORIGEN>
            <ns0:PV_BANCODESTINO>{ $destinationBank }</ns0:PV_BANCODESTINO>
        </ns0:InputParameters>
};

declare variable $cardNumber as xs:string external;
declare variable $transactionID as xs:string external;
declare variable $referenceNumber as xs:string external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;

xf:reversaTCIn($cardNumber,
    $transactionID,
    $referenceNumber,
    $sourceBank,
    $destinationBank)