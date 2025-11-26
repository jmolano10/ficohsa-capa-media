(:: pragma bea:global-element-return element="ns0:registrarBitacoraOSB" location="../../RegistrarBitacoraOSB/xsd/registrarBitacoraOSBTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/registrarBitacoraOSBTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Generales/xq/registrarBitacoraOSBIn/";

declare function xf:registrarBitacoraOSBIn($Uuid as xs:string,
    $TipoMensaje as xs:string,
    $IdServicio as xs:string,
    $IdOperacion as xs:string,
    $IdOsb as xs:string,
    $BancoOrigen as xs:string,
    $BancoDestino as xs:string,
    $Usuario as xs:string,
    $IdTxn as xs:string,
    $Resultado as xs:string,
    $MensajeError as xs:string,
    $UuidReq as xs:string,
    $FechaTxn as xs:string,
    $Contenido as element(*))
    as element(ns0:registrarBitacoraOSB) {
        <ns0:registrarBitacoraOSB>
            <UUID>{ $Uuid }</UUID>
            <TIPO_MENSAJE>{ $TipoMensaje }</TIPO_MENSAJE>
            <ID_SERVICIO>{ $IdServicio }</ID_SERVICIO>
            <ID_OPERACION>{ $IdOperacion }</ID_OPERACION>
            <ID_OSB>{ $IdOsb }</ID_OSB>
            <BANCO_ORIGEN>{ $BancoOrigen }</BANCO_ORIGEN>
            <BANCO_DESTINO>{ $BancoDestino }</BANCO_DESTINO>
            <USUARIO>{ $Usuario }</USUARIO>
            <CONTENIDO>{ fn-bea:serialize($Contenido) }</CONTENIDO>
            <ID_TRANSACCION>{ $IdTxn }</ID_TRANSACCION>
            <RESULTADO>{ $Resultado }</RESULTADO>
            <MENSAJE_ERROR>{ $MensajeError }</MENSAJE_ERROR>
            <UUID_REQUEST>{ $UuidReq }</UUID_REQUEST>
            <FECHA_TRANSACCION>{ $FechaTxn }</FECHA_TRANSACCION>
        </ns0:registrarBitacoraOSB>
};

declare variable $Uuid as xs:string external;
declare variable $TipoMensaje as xs:string external;
declare variable $IdServicio as xs:string external;
declare variable $IdOperacion as xs:string external;
declare variable $IdOsb as xs:string external;
declare variable $BancoOrigen as xs:string external;
declare variable $BancoDestino as xs:string external;
declare variable $Usuario as xs:string external;
declare variable $IdTxn as xs:string external;
declare variable $Resultado as xs:string external;
declare variable $MensajeError as xs:string external;
declare variable $UuidReq as xs:string external;
declare variable $FechaTxn as xs:string external;
declare variable $Contenido as element(*) external;

xf:registrarBitacoraOSBIn($Uuid,
    $TipoMensaje,
    $IdServicio,
    $IdOperacion,
    $IdOsb,
    $BancoOrigen,
    $BancoDestino,
    $Usuario,
    $IdTxn,
    $Resultado,
    $MensajeError,
    $UuidReq,
    $FechaTxn,
    $Contenido)