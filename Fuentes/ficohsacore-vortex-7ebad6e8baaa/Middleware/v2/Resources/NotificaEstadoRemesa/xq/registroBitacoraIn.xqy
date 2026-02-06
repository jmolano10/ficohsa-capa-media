xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$notificaEstadoRemesaResponse" element="ns0:notificaEstadoRemesaResponse" location="../xsd/notificaEstadoRemesaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/Remesas/NotificaEstadoRemesa/xsd/registraBitacoraRemesa_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/notificaEstadoRemesaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraBitacoraRemesa";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaEstadoRemesa/xq/registroBitacoraIn/";

declare function xf:registroBitacoraIn($notificaEstadoRemesaResponse as element(ns0:notificaEstadoRemesaResponse),
    $usuario as xs:string,
    $numeroContrato as xs:string,
    $codigoError as xs:string,
    $descripcion as xs:string,
    $request as xs:string,
    $response as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_USUARIO>{ $usuario }</ns1:PV_USUARIO>
            <ns1:PV_NUMERO_CONTRATO>{ $numeroContrato }</ns1:PV_NUMERO_CONTRATO>
            <ns1:PV_CODIGO_ERROR>{ $codigoError }</ns1:PV_CODIGO_ERROR>
            <ns1:PV_DESCRIPCION>{ $descripcion }</ns1:PV_DESCRIPCION>
            <ns1:PC_REQUEST_RECIBIDO>{ $response }</ns1:PC_REQUEST_RECIBIDO>
            <ns1:PC_REQUEST_ENVIADO>{ $request }</ns1:PC_REQUEST_ENVIADO>
        </ns1:InputParameters>
};

declare variable $notificaEstadoRemesaResponse as element(ns0:notificaEstadoRemesaResponse) external;
declare variable $usuario as xs:string external;
declare variable $numeroContrato as xs:string external;
declare variable $codigoError as xs:string external;
declare variable $descripcion as xs:string external;
declare variable $request as xs:string external;
declare variable $response as xs:string external;

xf:registroBitacoraIn($notificaEstadoRemesaResponse,
    $usuario,
    $numeroContrato,
    $codigoError,
    $descripcion,
    $request,
    $response)