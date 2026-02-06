xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/Terceros/xsd/registraBitacoraTerceroDetalle_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraBitacoraTerceroDetalle";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaEstadoRemesa/xq/aerRegistraBitacoraTerceroDetalleIn/";

declare function xf:aerRegistraBitacoraTerceroDetalleIn($uuid as xs:string,
    $serviceId as xs:string,
    $primaryKey as xs:string,
    $request as xs:string,
    $response as xs:string,
    $errorCode as xs:string,
    $message as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_ID>{ $uuid }</ns0:PV_ID>
            <ns0:PV_PRIMARYKEY>{ $primaryKey }</ns0:PV_PRIMARYKEY>
            <ns0:PV_TRANSACTIONCODE>5</ns0:PV_TRANSACTIONCODE>
            <ns0:PV_SERVICEID>{ $serviceId }</ns0:PV_SERVICEID>
            <ns0:PV_DESTINO>Remesas</ns0:PV_DESTINO>
            <ns0:PV_SERVICEREQUEST>{ fn-bea:serialize($request) }</ns0:PV_SERVICEREQUEST>
            <ns0:PV_SERVICERESPONSE>{ fn-bea:serialize($response) }</ns0:PV_SERVICERESPONSE>
            <ns0:PV_ERRORID>{ $errorCode }</ns0:PV_ERRORID>
            <ns0:PV_ERRORDESCRIPTION>{ $message }</ns0:PV_ERRORDESCRIPTION>
        </ns0:InputParameters>
};

declare variable $uuid as xs:string external;
declare variable $serviceId as xs:string external;
declare variable $primaryKey as xs:string external;
declare variable $request as element(*) external;
declare variable $response as element(*) external;
declare variable $errorCode as xs:string external;
declare variable $message as xs:string external;

xf:aerRegistraBitacoraTerceroDetalleIn($uuid,
    $serviceId,
    $primaryKey,
    $request,
    $response,
    $errorCode,
    $message)