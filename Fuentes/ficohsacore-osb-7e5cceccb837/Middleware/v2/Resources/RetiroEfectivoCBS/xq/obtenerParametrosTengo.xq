(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/obtenerParametrizacionTengo/xsd/obtenerParametrizacionTengo_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerParametrizacionTengo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroEfectivoCBS/xq/obtenerParametrosTengo/";

declare function xf:obtenerParametrosTengo($codigoServicio as xs:string,
    $paisOrigen as xs:string,
    $paisDestino as xs:string,
    $usuarioCorres as xs:string,
    $tipoTransaccion as xs:string,
    $operacion as xs:string,
    $monto as xs:string,
    $moneda as xs:string,
    $codCorres as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_COD_SERVICIO>{ $codigoServicio }</ns0:PV_COD_SERVICIO>
            <ns0:PV_ORIGEN>{ $paisOrigen }</ns0:PV_ORIGEN>
            <ns0:PV_DESTINO>{ $paisDestino }</ns0:PV_DESTINO>
            <ns0:PV_USER_CORRESPONSAL>{ $usuarioCorres }</ns0:PV_USER_CORRESPONSAL>
            <ns0:PV_TIPO_TRANSACCION>{ $tipoTransaccion }</ns0:PV_TIPO_TRANSACCION>
            <ns0:PN_OPERACION>{ $operacion }</ns0:PN_OPERACION>
            <ns0:PV_MONTO>{ $monto }</ns0:PV_MONTO>
            <ns0:PV_MONEDA>{ $moneda }</ns0:PV_MONEDA>
            <ns0:PV_CODIGO_CORRESPONSAL>{ $codCorres }</ns0:PV_CODIGO_CORRESPONSAL>
        </ns0:InputParameters>
};

declare variable $codigoServicio as xs:string external;
declare variable $paisOrigen as xs:string external;
declare variable $paisDestino as xs:string external;
declare variable $usuarioCorres as xs:string external;
declare variable $tipoTransaccion as xs:string external;
declare variable $operacion as xs:string external;
declare variable $monto as xs:string external;
declare variable $moneda as xs:string external;
declare variable $codCorres as xs:string external;

xf:obtenerParametrosTengo($codigoServicio,
    $paisOrigen,
    $paisDestino,
    $usuarioCorres,
    $tipoTransaccion,
    $operacion,
    $monto,
    $moneda,
    $codCorres)