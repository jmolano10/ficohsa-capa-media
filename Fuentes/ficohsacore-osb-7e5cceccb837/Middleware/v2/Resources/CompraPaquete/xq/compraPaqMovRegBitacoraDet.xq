(:: pragma  parameter="$request" type="anyType" ::)
(:: pragma  parameter="$response" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/Terceros/xsd/registraBitacoraTerceroDetalle_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraBitacoraTerceroDetalle";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CompraPaquete/xq/compraPaqMovRegBitacoraDet/";

declare function xf:compraPaqMovRegBitacoraDet($uuid as xs:string,
    $serviceId as xs:string,
    $target as xs:string,
    $primaryKey as xs:string,
    $operationCode as xs:string,
    $request as element(*),
    $response as element(*),
    $successIndicator as xs:string,
    $message as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_ID>{ $uuid }</ns0:PV_ID>
            <ns0:PV_PRIMARYKEY>{ $primaryKey }</ns0:PV_PRIMARYKEY>
            <ns0:PV_TRANSACTIONCODE>{ $operationCode }</ns0:PV_TRANSACTIONCODE>
            <ns0:PV_SERVICEID>{ $serviceId }</ns0:PV_SERVICEID>
            <ns0:PV_DESTINO>{ $target }</ns0:PV_DESTINO>
            <ns0:PV_SERVICEREQUEST>{ fn-bea:serialize($request) }</ns0:PV_SERVICEREQUEST>
            <ns0:PV_SERVICERESPONSE>{ fn-bea:serialize($response) }</ns0:PV_SERVICERESPONSE>
            <ns0:PV_ERRORID>{ $successIndicator }</ns0:PV_ERRORID>
            <ns0:PV_ERRORDESCRIPTION>{ $message }</ns0:PV_ERRORDESCRIPTION>
        </ns0:InputParameters>
};

declare variable $uuid as xs:string external;
declare variable $serviceId as xs:string external;
declare variable $target as xs:string external;
declare variable $primaryKey as xs:string external;
declare variable $operationCode as xs:string external;
declare variable $request as element(*) external;
declare variable $response as element(*) external;
declare variable $successIndicator as xs:string external;
declare variable $message as xs:string external;

xf:compraPaqMovRegBitacoraDet($uuid,
    $serviceId,
    $target,
    $primaryKey,
    $operationCode,
    $request,
    $response,
    $successIndicator,
    $message)