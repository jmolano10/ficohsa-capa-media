(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/RegistrarTransaccionACH/xsd/RegistrarTransaccionACH_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/RegistrarTransaccionACH";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/RegistrarEnvioACHIn/";

declare function xf:RegistrarEnvioACHIn($IDTransaction as xs:string,
    $idRegT24 as xs:string,
    $fechaEnvio as xs:dateTime,
    $fechaRespuesta as xs:dateTime,
    $rutaDestino as xs:string,
    $cuentaOrigen as xs:string,
    $cuentaDestino as xs:string,
    $tipoCuentaDestino as xs:decimal,
    $tipoMensaje as xs:string,
    $codigoRechazo as xs:string,
    $descripcionRechazo as xs:string,
    $monto as xs:decimal,
    $estado as xs:string,
    $moneda as xs:string,
    $EstadoLocal as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_ID_TRANSACCION>{ $IDTransaction }</ns0:PV_ID_TRANSACCION>
            <ns0:PV_ID_T24>{ $idRegT24 }</ns0:PV_ID_T24>
            <ns0:PD_FECHA_ENVIO>{ $fechaEnvio }</ns0:PD_FECHA_ENVIO>
            <ns0:PD_FECHA_RESPUESTA>{ $fechaRespuesta }</ns0:PD_FECHA_RESPUESTA>
            <ns0:PV_RUTA_DESTINO>{ fn:string($rutaDestino) }</ns0:PV_RUTA_DESTINO>
            <ns0:PV_CUENTA_ORIGEN>{ $cuentaOrigen }</ns0:PV_CUENTA_ORIGEN>
            <ns0:PV_CUENTA_DESTINO>{ $cuentaDestino }</ns0:PV_CUENTA_DESTINO>
            <ns0:PN_TIPO_CTA_DEST>{ $tipoCuentaDestino }</ns0:PN_TIPO_CTA_DEST>
            <ns0:PV_TIPO_MENSAJE>{ $tipoMensaje }</ns0:PV_TIPO_MENSAJE>
            <ns0:PV_CODIGO_RECHAZO>{ $codigoRechazo }</ns0:PV_CODIGO_RECHAZO>
            <ns0:PV_DESC_RECHAZO>{ fn:substring($descripcionRechazo,1,100) }</ns0:PV_DESC_RECHAZO>
            <ns0:PN_MONTO>{ $monto }</ns0:PN_MONTO>
            <ns0:PV_ESTADO>{ $estado }</ns0:PV_ESTADO>
            <ns0:PV_MONEDA>{ $moneda }</ns0:PV_MONEDA>
            <ns0:PV_ESTADO_LOCAL>{ $EstadoLocal }</ns0:PV_ESTADO_LOCAL>
        </ns0:InputParameters>
};

declare variable $IDTransaction as xs:string external;
declare variable $idRegT24 as xs:string external;
declare variable $fechaEnvio as xs:dateTime external;
declare variable $fechaRespuesta as xs:dateTime external;
declare variable $rutaDestino as xs:string external;
declare variable $cuentaOrigen as xs:string external;
declare variable $cuentaDestino as xs:string external;
declare variable $tipoCuentaDestino as xs:decimal external;
declare variable $tipoMensaje as xs:string external;
declare variable $codigoRechazo as xs:string external;
declare variable $descripcionRechazo as xs:string external;
declare variable $monto as xs:decimal external;
declare variable $estado as xs:string external;
declare variable $moneda as xs:string external;
declare variable $EstadoLocal as xs:string external;

xf:RegistrarEnvioACHIn($IDTransaction,
    $idRegT24,
    $fechaEnvio,
    $fechaRespuesta,
    $rutaDestino,
    $cuentaOrigen,
    $cuentaDestino,
    $tipoCuentaDestino,
    $tipoMensaje,
    $codigoRechazo,
    $descripcionRechazo,
    $monto,
    $estado,
    $moneda,
    $EstadoLocal)