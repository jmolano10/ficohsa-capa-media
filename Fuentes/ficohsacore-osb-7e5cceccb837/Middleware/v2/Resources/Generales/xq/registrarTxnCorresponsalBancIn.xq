(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/registrarTxnCorresponsalB/xsd/registrarTxnCorresponsalB_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarTxnCorresponsalB";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Generales/xq/registrarTxnCorresponsalBancIn/";

declare function xf:registrarTxnCorresponsalBancIn($IdUnicoTrans as xs:string,
    $SecuenciaTrans as xs:string,
    $CodigoCorresponsal as xs:string,
    $PuntoVenta as xs:string,
    $SubPuntoVenta as xs:string,
    $FechaTrans as xs:string,
    $EstadoTrans as xs:string,
    $IdentidadSolicitante as xs:string,
    $NombreSolicitante as xs:string,
    $NumeroCuenta as xs:string,
    $Monto as xs:string,
    $Moneda as xs:string,
    $CodigoPais as xs:string,
    $CodigoTransaccion as xs:string,
    $ClavePrimaria as xs:string,
    $TokenId as xs:string?,
    $IdTransaccionComision as xs:string?,
    $montoComision as xs:string?,
    $monedaComision as xs:string?)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_ID_UNICO_TRANS>{ $IdUnicoTrans }</ns0:PV_ID_UNICO_TRANS>
            <ns0:PV_SECUENCIA_TRANSACCION>{ $SecuenciaTrans }</ns0:PV_SECUENCIA_TRANSACCION>
            <ns0:PV_CODIGO_CORRESPONSAL>{ $CodigoCorresponsal }</ns0:PV_CODIGO_CORRESPONSAL>
            <ns0:PV_PUNTO_VENTA>{ $PuntoVenta }</ns0:PV_PUNTO_VENTA>
            <ns0:PV_SUB_PUNTO_VENTA>{ $SubPuntoVenta }</ns0:PV_SUB_PUNTO_VENTA>
            <ns0:PD_FECHA_TRANSACCION>{ $FechaTrans }</ns0:PD_FECHA_TRANSACCION>
            <ns0:PV_ESTADO_TRANSACCION>{ $EstadoTrans }</ns0:PV_ESTADO_TRANSACCION>
            <ns0:PV_IDENTIDAD_SOLICITANTE>{ $IdentidadSolicitante }</ns0:PV_IDENTIDAD_SOLICITANTE>
            <ns0:PV_NOMBRE_SOLICITANTE>{ $NombreSolicitante }</ns0:PV_NOMBRE_SOLICITANTE>
            <ns0:PV_NUMERO_CUENTA>{ $NumeroCuenta }</ns0:PV_NUMERO_CUENTA>
            <ns0:PN_MONTO>{ $Monto }</ns0:PN_MONTO>
            <ns0:PV_MONEDA>{ $Moneda }</ns0:PV_MONEDA>
            <ns0:PV_CODIGO_PAIS>{ $CodigoPais }</ns0:PV_CODIGO_PAIS>
            <ns0:Pv_CODIGO_TRANSACCION>{ $CodigoTransaccion }</ns0:Pv_CODIGO_TRANSACCION>
            <ns0:Pv_CLAVE_PRIMARIA>{ $ClavePrimaria }</ns0:Pv_CLAVE_PRIMARIA>
            <ns0:Pv_TOKEN_ID>{ $TokenId }</ns0:Pv_TOKEN_ID>
            <ns0:Pv_ID_TRANSACCION_COMISION>{ $IdTransaccionComision }</ns0:Pv_ID_TRANSACCION_COMISION>
            <ns0:Pn_MONTO_COMISION>{ $montoComision }</ns0:Pn_MONTO_COMISION>
            <ns0:Pv_MONEDA_COMISION>{ $monedaComision }</ns0:Pv_MONEDA_COMISION>
        </ns0:InputParameters>
};

declare variable $IdUnicoTrans as xs:string external;
declare variable $SecuenciaTrans as xs:string external;
declare variable $CodigoCorresponsal as xs:string external;
declare variable $PuntoVenta as xs:string external;
declare variable $SubPuntoVenta as xs:string external;
declare variable $FechaTrans as xs:string external;
declare variable $EstadoTrans as xs:string external;
declare variable $IdentidadSolicitante as xs:string external;
declare variable $NombreSolicitante as xs:string external;
declare variable $NumeroCuenta as xs:string external;
declare variable $Monto as xs:string external;
declare variable $Moneda as xs:string external;
declare variable $CodigoPais as xs:string external;
declare variable $CodigoTransaccion as xs:string external;
declare variable $ClavePrimaria as xs:string external;
declare variable $TokenId as xs:string? external;
declare variable $IdTransaccionComision as xs:string? external;
declare variable $montoComision as xs:string? external;
declare variable $monedaComision as xs:string? external;

xf:registrarTxnCorresponsalBancIn($IdUnicoTrans,
    $SecuenciaTrans,
    $CodigoCorresponsal,
    $PuntoVenta,
    $SubPuntoVenta,
    $FechaTrans,
    $EstadoTrans,
    $IdentidadSolicitante,
    $NombreSolicitante,
    $NumeroCuenta,
    $Monto,
    $Moneda,
    $CodigoPais,
    $CodigoTransaccion,
    $ClavePrimaria,
    $TokenId,
    $IdTransaccionComision,
    $montoComision,
    $monedaComision)