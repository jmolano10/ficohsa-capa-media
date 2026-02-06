xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/Terceros/xsd/registraBitacoraTerceroEncabezado_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraBitacoraTerceroEncabezado";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaRemesa/xq/registraBitacoraTerceroEncabezadoIn/";

declare function xf:registraBitacoraTerceroEncabezadoIn($uuid as xs:string,
    $contractId as xs:string,
    $primaryKey as xs:string,
    $userName as xs:string,
    $amount as xs:string,
    $currency as xs:string,
    $dueDate as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_ID>{ $uuid }</ns0:PV_ID>
            <ns0:PV_PRIMARYKEY>{ $primaryKey }</ns0:PV_PRIMARYKEY>
            <ns0:PV_TRANSACTIONCODE>4</ns0:PV_TRANSACTIONCODE>
            <ns0:PV_CONTRACTNUMBER>{ $contractId }</ns0:PV_CONTRACTNUMBER>
            <ns0:PV_TRANSACTIONCHANNEL>{ $userName }</ns0:PV_TRANSACTIONCHANNEL>
            <ns0:PV_TRANSACTIONUSER>{ $userName }</ns0:PV_TRANSACTIONUSER>
            <ns0:PN_TRANSACTIONAMOUNT>{ data($amount) }</ns0:PN_TRANSACTIONAMOUNT>
            <ns0:PV_TRANSACTIONCURRENCY>{ $currency }</ns0:PV_TRANSACTIONCURRENCY>
            <ns0:PV_DUEDATE>{ fn-bea:dateTime-to-string-with-format("yyMMddHHmm", fn-bea:dateTime-from-string-with-format("yyyy-MM-dd HH:mm", concat($dueDate, " 00:00"))) }</ns0:PV_DUEDATE>
        </ns0:InputParameters>
};

declare variable $uuid as xs:string external;
declare variable $contractId as xs:string external;
declare variable $primaryKey as xs:string external;
declare variable $userName as xs:string external;
declare variable $amount as xs:string external;
declare variable $currency as xs:string external;
declare variable $dueDate as xs:string external;

xf:registraBitacoraTerceroEncabezadoIn($uuid,
    $contractId,
    $primaryKey,
    $userName,
    $amount,
    $currency,
    $dueDate)