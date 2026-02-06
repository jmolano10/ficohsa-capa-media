xquery version "2004-draft";
(:: pragma  parameter="$contenido" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:registrarBitacoraOSB" location="../../RegistrarBitacoraOSB/xsd/registrarBitacoraOSBTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/registrarBitacoraOSBTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Generales/registrarBitacoraOSBv2In/";

declare function xf:registrarBitacoraOSBv2In($uuid as xs:string,
    $tipoMensaje as xs:string,
    $idServicio as xs:string,
    $idOperacion as xs:string,
    $idOsb as xs:string,
    $bancoOrigen as xs:string,
    $bancoDestino as xs:string,
    $usuario as xs:string,
    $idTxn as xs:string,
    $resultado as xs:string,
    $mensajeError as xs:string,
    $uuidReq as xs:string,
    $fechaTxn as xs:dateTime,
    $contenido as element(*),
    $clavePrimaria as xs:string)
    as element(ns0:registrarBitacoraOSB) {
        <ns0:registrarBitacoraOSB>
            <UUID>{ $uuid }</UUID>
            <TIPO_MENSAJE>{ $tipoMensaje }</TIPO_MENSAJE>
            <ID_SERVICIO>{ $idServicio }</ID_SERVICIO>
            <ID_OPERACION>{ $idOperacion }</ID_OPERACION>
            <ID_OSB>{ $idOsb }</ID_OSB>
            <BANCO_ORIGEN>{ $bancoOrigen }</BANCO_ORIGEN>
            <BANCO_DESTINO>{ $bancoDestino }</BANCO_DESTINO>
            <USUARIO>{ $usuario }</USUARIO>
            <CONTENIDO>{ fn-bea:serialize($contenido) }</CONTENIDO>
            <ID_TRANSACCION>{ $idTxn }</ID_TRANSACCION>
            <RESULTADO>{ $resultado }</RESULTADO>
            <MENSAJE_ERROR>{ $mensajeError }</MENSAJE_ERROR>
            <UUID_REQUEST>{ $uuidReq }</UUID_REQUEST>
            <FECHA_TRANSACCION>{ $fechaTxn }</FECHA_TRANSACCION>
            <CLAVE_PRIMARIA>{ $clavePrimaria }</CLAVE_PRIMARIA>
        </ns0:registrarBitacoraOSB>
};

declare variable $uuid as xs:string external;
declare variable $tipoMensaje as xs:string external;
declare variable $idServicio as xs:string external;
declare variable $idOperacion as xs:string external;
declare variable $idOsb as xs:string external;
declare variable $bancoOrigen as xs:string external;
declare variable $bancoDestino as xs:string external;
declare variable $usuario as xs:string external;
declare variable $idTxn as xs:string external;
declare variable $resultado as xs:string external;
declare variable $mensajeError as xs:string external;
declare variable $uuidReq as xs:string external;
declare variable $fechaTxn as xs:dateTime external;
declare variable $contenido as element(*) external;
declare variable $clavePrimaria as xs:string external;

xf:registrarBitacoraOSBv2In($uuid,
    $tipoMensaje,
    $idServicio,
    $idOperacion,
    $idOsb,
    $bancoOrigen,
    $bancoDestino,
    $usuario,
    $idTxn,
    $resultado,
    $mensajeError,
    $uuidReq,
    $fechaTxn,
    $contenido,
    $clavePrimaria)