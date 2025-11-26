xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/SetLogInfoService_BS";
(:: import schema at "../XSD/SetLogInfoService_BS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $uuid as xs:string external;
declare variable $codigoServicio as xs:integer external;
declare variable $version as xs:string external;
declare variable $codigoAplicacion as xs:integer external;
declare variable $tipoMensaje as xs:string external;
declare variable $codigoSistema as xs:integer external;
declare variable $endpoint as xs:string external;
declare variable $metodo as xs:string external;
declare variable $operacionServicio as xs:string external;
declare variable $bancoOrigen as xs:string external;
declare variable $bancoDestino as xs:string external;
declare variable $parametros as xs:string external;
declare variable $usuario as xs:string external;
declare variable $contenido as xs:string external;
declare variable $estado as xs:string external;
declare variable $codigoError as xs:string external;
declare variable $descripcionError as xs:string external;
declare variable $nombreFlujoError as xs:string external;
declare variable $fechaTX as xs:dateTime external;
declare variable $fechaHora as xs:string external;

declare function xq:Tx_Msg_To_SetLogInfo($uuid as xs:string, 
                                         $codigoServicio as xs:integer, 
                                         $version as xs:string, 
                                         $codigoAplicacion as xs:integer, 
                                         $tipoMensaje as xs:string, 
                                         $codigoSistema as xs:integer, 
                                         $endpoint as xs:string, 
                                         $metodo as xs:string, 
                                         $operacionServicio as xs:string, 
                                         $bancoOrigen as xs:string, 
                                         $bancoDestino as xs:string, 
                                         $parametros as xs:string, 
                                         $usuario as xs:string, 
                                         $contenido as xs:string, 
                                         $estado as xs:string, 
                                         $codigoError as xs:string, 
                                         $descripcionError as xs:string, 
                                         $nombreFlujoError as xs:string, 
                                         $fechaTX as xs:dateTime, 
                                         $fechaHora as xs:string) 
                                         as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:PV_UUID>{fn:data($uuid)}</ns1:PV_UUID>
        <ns1:PN_CODIGO_SERVICIO>{fn:data($codigoServicio)}</ns1:PN_CODIGO_SERVICIO>
        <ns1:PV_VERSION>{fn:data($version)}</ns1:PV_VERSION>
        <ns1:PN_CODIGO_APLICACION>{fn:data($codigoAplicacion)}</ns1:PN_CODIGO_APLICACION>
        <ns1:PV_TIPO_MENSAJE>{fn:data($tipoMensaje)}</ns1:PV_TIPO_MENSAJE>
        <ns1:PN_CODIGO_SISTEMA>{fn:data($codigoSistema)}</ns1:PN_CODIGO_SISTEMA>
        <ns1:PV_ENDPOINT>{fn:data($endpoint)}</ns1:PV_ENDPOINT>
        <ns1:PV_METODO>{fn:data($metodo)}</ns1:PV_METODO>
        <ns1:PV_OPERACION_SERVICIO>{fn:data($operacionServicio)}</ns1:PV_OPERACION_SERVICIO>
        <ns1:PV_BANCO_ORIGEN>{fn:data($bancoOrigen)}</ns1:PV_BANCO_ORIGEN>
        <ns1:PV_BANCO_DESTINO>{fn:data($bancoDestino)}</ns1:PV_BANCO_DESTINO>
        <ns1:PV_PARAMETROS>{fn:data($parametros)}</ns1:PV_PARAMETROS>
        <ns1:PV_USUARIO>{fn:data($usuario)}</ns1:PV_USUARIO>
        <ns1:PC_CONTENIDO>{fn:data($contenido)}</ns1:PC_CONTENIDO>
        <ns1:PV_ESTADO>{fn:data($estado)}</ns1:PV_ESTADO>
        <ns1:PV_CODIGO_ERROR>{fn:data($codigoError)}</ns1:PV_CODIGO_ERROR>
        <ns1:PV_DESCRIPCION_ERROR>{fn:data($descripcionError)}</ns1:PV_DESCRIPCION_ERROR>
        <ns1:PV_NOMBRE_FLUJO_ERROR>{fn:data($nombreFlujoError)}</ns1:PV_NOMBRE_FLUJO_ERROR>
        <ns1:PD_FECHA_TXN>{fn:data($fechaTX)}</ns1:PD_FECHA_TXN>
        <ns1:PD_FECHA_HORA>{fn:data($fechaHora)}</ns1:PD_FECHA_HORA>
    </ns1:InputParameters>
};

xq:Tx_Msg_To_SetLogInfo($uuid, $codigoServicio, $version, $codigoAplicacion, $tipoMensaje, $codigoSistema, $endpoint, $metodo, $operacionServicio, $bancoOrigen, $bancoDestino, $parametros, $usuario, $contenido, $estado, $codigoError, $descripcionError, $nombreFlujoError, $fechaTX, $fechaHora)