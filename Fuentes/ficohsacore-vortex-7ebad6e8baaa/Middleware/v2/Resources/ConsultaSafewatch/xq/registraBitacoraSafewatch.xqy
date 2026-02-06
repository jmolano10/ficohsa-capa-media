xquery version "2004-draft";
(:: pragma  parameter="$Contenido" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/SafewatchRegistraBitacora/xsd/safewatchRegistraBitacora_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/safewatchRegistraBitacora";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSafewatch/xq/registraBitacoraSafewatch/";

declare function xf:registraBitacoraSafewatch($Uuid as xs:string,
    $TipoMensaje as xs:string,
    $IdServicio as xs:string,
    $IdOperacion as xs:string,
    $IdOsb as xs:string,
    $BancoOrigen as xs:string,
    $BancoDestino as xs:string,
    $Usuario as xs:string,
    $Contenido as element(*),
    $Resultado as xs:string,
    $MensajeError as xs:string,
    $NombreArchivo as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_UUID>{ $Uuid }</ns0:PV_UUID>
            <ns0:PV_TIPOMENSAJE>{ $TipoMensaje }</ns0:PV_TIPOMENSAJE>
            <ns0:PV_IDSERVICIO>{ $IdServicio }</ns0:PV_IDSERVICIO>
            <ns0:PV_IDOPERACION>{ $IdOperacion }</ns0:PV_IDOPERACION>
            <ns0:PV_IDOSB>{ $IdOsb }</ns0:PV_IDOSB>
            <ns0:PV_BANCOORIGEN>{ $BancoOrigen }</ns0:PV_BANCOORIGEN>
            <ns0:PV_BANCODESTINO>{ $BancoDestino }</ns0:PV_BANCODESTINO>
            <ns0:PV_USUARIO>{ $Usuario }</ns0:PV_USUARIO>
            <ns0:PV_CONTENIDO>{ fn-bea:serialize($Contenido) }</ns0:PV_CONTENIDO>
            <ns0:PV_RESULTADO>{ $Resultado }</ns0:PV_RESULTADO>
            <ns0:PV_MENSAJEERROR>{ $MensajeError }</ns0:PV_MENSAJEERROR>
            <ns0:PV_NOMBREARCHIVO>{ $NombreArchivo }</ns0:PV_NOMBREARCHIVO>
        </ns0:InputParameters>
};

declare variable $Uuid as xs:string external;
declare variable $TipoMensaje as xs:string external;
declare variable $IdServicio as xs:string external;
declare variable $IdOperacion as xs:string external;
declare variable $IdOsb as xs:string external;
declare variable $BancoOrigen as xs:string external;
declare variable $BancoDestino as xs:string external;
declare variable $Usuario as xs:string external;
declare variable $Contenido as element(*) external;
declare variable $Resultado as xs:string external;
declare variable $MensajeError as xs:string external;
declare variable $NombreArchivo as xs:string external;

xf:registraBitacoraSafewatch($Uuid,
    $TipoMensaje,
    $IdServicio,
    $IdOperacion,
    $IdOsb,
    $BancoOrigen,
    $BancoDestino,
    $Usuario,
    $Contenido,
    $Resultado,
    $MensajeError,
    $NombreArchivo)