(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/INTFC/registrarBitacoraH2H/xsd/registrarBitacoraH2H_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarBitacoraH2H";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/CobranzasH2H/xq/registrarBitacoraH2HIn/";

declare function xf:registrarBitacoraH2HIn(
    $uuid as xs:string,
    $codigoCliente as xs:string,
    $servicio as xs:string,
    $fechaRegistro as xs:dateTime?,
    $usuario as xs:string?,
    $tipoRegistro as xs:string,
    $contenidoSOAP as element(*)?,
    $idPeticion as xs:string?,
    $codigoRespuesta as xs:string?,
    $mensajeRespuesta as xs:string?,
    $host as xs:string?,
    $operacion as xs:string?
    ) as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_UUID>{ $uuid }</ns0:PV_UUID>
            <ns0:PV_CODIGOCLIENTE>{ $codigoCliente }</ns0:PV_CODIGOCLIENTE>
            <ns0:PV_NOMBRESERVICIO>{ $servicio }</ns0:PV_NOMBRESERVICIO>
            <ns0:PD_FECHAREGISTRO>{ data($fechaRegistro) }</ns0:PD_FECHAREGISTRO>
            <ns0:PV_NOMBREUSUARIO>{ $usuario }</ns0:PV_NOMBREUSUARIO>
            <ns0:PV_TIPOREGISTRO>{ $tipoRegistro }</ns0:PV_TIPOREGISTRO>
            <ns0:PC_CONTENIDOSOAP>{ $contenidoSOAP }</ns0:PC_CONTENIDOSOAP>
            <ns0:PV_IDPETICION>{ $idPeticion }</ns0:PV_IDPETICION>
            <ns0:PV_CODIGORESPUESTA>{ $codigoRespuesta }</ns0:PV_CODIGORESPUESTA>
            <ns0:PV_MENSAJERESPUESTA>{ $mensajeRespuesta }</ns0:PV_MENSAJERESPUESTA>
            <ns0:PV_HOSTPETICION>{ $host }</ns0:PV_HOSTPETICION>
            <ns0:PV_OPERACION>{ $operacion }</ns0:PV_OPERACION>
        </ns0:InputParameters>
};

declare variable $uuid as xs:string external;
declare variable $codigoCliente as xs:string external;
declare variable $servicio as xs:string external;
declare variable $fechaRegistro as xs:dateTime? external;
declare variable $usuario as xs:string? external;
declare variable $tipoRegistro as xs:string external;
declare variable $contenidoSOAP as element(*)? external;
declare variable $idPeticion as xs:string? external;
declare variable $codigoRespuesta as xs:string? external;
declare variable $mensajeRespuesta as xs:string? external;
declare variable $host as xs:string? external;
declare variable $operacion as xs:string? external;

xf:registrarBitacoraH2HIn(
    $uuid,
    $codigoCliente,
    $servicio,
    $fechaRegistro,
    $usuario,
    $tipoRegistro,
    $contenidoSOAP,
    $idPeticion,
    $codigoRespuesta,
    $mensajeRespuesta,
    $host,
    $operacion
)