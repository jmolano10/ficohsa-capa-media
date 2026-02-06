xquery version "2004-draft";
(:: pragma  parameter="$soapContent" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/DEI/registrarBitacora/xsd/registrarBitacora_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarBitacora";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TributosDEI/xq/registrarBitacoraDEIIn/";

declare function xf:registrarBitacoraDEIIn(
	$id as xs:string?,
    $recordDate as xs:dateTime?,
    $authUsername as xs:string?,
    $recordType as xs:string?,
    $soapContent as element(*)?,
    $requestId as xs:string?,
    $responseCode as xs:string?,
    $responseMessage as xs:string?,
    $requestHost as xs:string?,
    $operation as xs:string?)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_UUID>{ $id }</ns0:PV_UUID>
            <ns0:PD_FECHAREGISTRO>{ $recordDate }</ns0:PD_FECHAREGISTRO>
            <ns0:PV_NOMUSUARIOAUTENTICA>{ $authUsername }</ns0:PV_NOMUSUARIOAUTENTICA>
            <ns0:PV_TIPOREGISTRO>{ $recordType }</ns0:PV_TIPOREGISTRO>
            <ns0:PC_CONTENIDOSOAP>{ $soapContent }</ns0:PC_CONTENIDOSOAP>
            <ns0:PV_IDPETICION>{ $requestId }</ns0:PV_IDPETICION>
            <ns0:PV_CODIGORESPUESTA>{ $responseCode }</ns0:PV_CODIGORESPUESTA>
            <ns0:PV_MENSAJERESPUESTA>{ $responseMessage }</ns0:PV_MENSAJERESPUESTA>
            <ns0:PV_HOSTPETICION>{ $requestHost }</ns0:PV_HOSTPETICION>
            <ns0:PV_OPERACION>{ $operation }</ns0:PV_OPERACION>
        </ns0:InputParameters>
};

declare variable $id as xs:string? external;
declare variable $recordDate as xs:dateTime? external;
declare variable $authUsername as xs:string? external;
declare variable $recordType as xs:string? external;
declare variable $soapContent as element(*)? external;
declare variable $requestId as xs:string? external;
declare variable $responseCode as xs:string? external;
declare variable $responseMessage as xs:string? external;
declare variable $requestHost as xs:string? external;
declare variable $operation as xs:string? external;

xf:registrarBitacoraDEIIn($id,
    $recordDate,
    $authUsername,
    $recordType,
    $soapContent,
    $requestId,
    $responseCode,
    $responseMessage,
    $requestHost,
    $operation)