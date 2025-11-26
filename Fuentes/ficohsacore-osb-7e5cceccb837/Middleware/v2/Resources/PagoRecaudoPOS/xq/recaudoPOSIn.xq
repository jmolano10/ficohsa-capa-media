xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/RecaudoPOS/xsd/recaudoPOS_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudoPOS/xq/recaudoPOSIn/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/recaudoPOS";

declare function xf:recaudoPOSIn($uuid as xs:string,
    $responseOSB as xs:string,
    $requestOSB as xs:string,
    $requestWS as xs:string,
    $responseWS as xs:string,
    $primaryKey as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_SOLICITUD>{ $uuid }</ns0:PV_SOLICITUD>
            <ns0:PV_CODIGOOPERACION>2</ns0:PV_CODIGOOPERACION>
            <ns0:PX_REQUESTOSB>{ $requestOSB }</ns0:PX_REQUESTOSB>
            <ns0:PV_PRIMARYKEY>{ $primaryKey }</ns0:PV_PRIMARYKEY>
            <ns0:PX_RESPONSEOSB>{ $responseOSB }</ns0:PX_RESPONSEOSB>
            <ns0:PX_REQUESTTERCERO>{ $requestWS }</ns0:PX_REQUESTTERCERO>
            <ns0:PX_RESPONSETERCERO>{ $responseWS }</ns0:PX_RESPONSETERCERO>
        </ns0:InputParameters>
};

declare variable $uuid as xs:string external;
declare variable $responseOSB as xs:string external;
declare variable $requestOSB as xs:string external;
declare variable $requestWS as xs:string external;
declare variable $responseWS as xs:string external;
declare variable $primaryKey as xs:string external;

xf:recaudoPOSIn($uuid,
    $responseOSB,
    $requestOSB,
    $requestWS,
    $responseWS,
    $primaryKey)
