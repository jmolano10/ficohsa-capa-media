xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/Terceros/xsd/registraBitacoraTerceroEncabezado_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraBitacoraTerceroEncabezado";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CompraPaquete/xq/compraPaqMovRegBitacoraHdr/";

declare function xf:compraPaqMovRegBitacoraHdr($uuid as xs:string,
    $contractId as xs:string,
    $primaryKey as xs:string,
    $operationCode as xs:string,
    $contractNumber as xs:string,
    $channel as xs:string,
    $user as xs:string,
    $amount as xs:string,
    $currency as xs:string,
    $transactionId as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_ID>{ $uuid }</ns0:PV_ID>
            <ns0:PV_PRIMARYKEY>{ $primaryKey }</ns0:PV_PRIMARYKEY>
            <ns0:PV_TRANSACTIONCODE>{ $operationCode }</ns0:PV_TRANSACTIONCODE>
            <ns0:PV_CONTRACTNUMBER>{ $contractId }</ns0:PV_CONTRACTNUMBER>
            <ns0:PV_TRANSACTIONCHANNEL>{ $channel }</ns0:PV_TRANSACTIONCHANNEL>
            <ns0:PV_TRANSACTIONUSER>{ $user }</ns0:PV_TRANSACTIONUSER>
            <ns0:PN_TRANSACTIONAMOUNT>{ data($amount) }</ns0:PN_TRANSACTIONAMOUNT>
            <ns0:PV_TRANSACTIONCURRENCY>{ $currency }</ns0:PV_TRANSACTIONCURRENCY>
            <ns0:PV_TRANSACTIONID>{ $transactionId }</ns0:PV_TRANSACTIONID>
        </ns0:InputParameters>
};

declare variable $uuid as xs:string external;
declare variable $contractId as xs:string external;
declare variable $primaryKey as xs:string external;
declare variable $operationCode as xs:string external;
declare variable $contractNumber as xs:string external;
declare variable $channel as xs:string external;
declare variable $user as xs:string external;
declare variable $amount as xs:string external;
declare variable $currency as xs:string external;
declare variable $transactionId as xs:string external;

xf:compraPaqMovRegBitacoraHdr($uuid,
    $contractId,
    $primaryKey,
    $operationCode,
    $contractNumber,
    $channel,
    $user,
    $amount,
    $currency,
    $transactionId)