(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../BusinessServices/MDW/TransaccionesGenericasEEH/ProcesarTransaccionesGenericas/xsd/registrarTransaccionesGenericas_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarTransaccionesGenericas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransaccionesGenericasTengoEEH/ProcesarTransaccionesGenericaCB/xq/registrarTransaccion/";

declare function xf:registrarTransaccion($UUID as xs:string,
    $CLAVE_CONVENIO as xs:string,
    $MONTO as xs:decimal,
    $MONEDA as xs:string,
    $CUENTA_DEBITO as xs:string,
    $TIPO_TRANSACCION_T24 as xs:string,
    $CANAL as xs:string,
    $PAIS as xs:string,
    $CODIGO_CORRESPONSAL as xs:string,
    $CLAVE_CORRESPONSAL as xs:string,
    $TIPO_TRANSACCION as xs:string,
    $ESTADO as xs:decimal,
    $REFERENCIA_T24 as xs:string,
    $PUNTO_VENTA_CORRESPONSAL as xs:string,
    $SUB_PUNTO_VENTA_CORRESPONSAL as xs:string,
    $ID_CLIENTE as xs:string,
    $NOMBRE_CLIENTE as xs:string,
    $PAYMENT_DETAILS as xs:string,
    $CUENTA_CREDITO as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_UUID_TRX>{ $UUID }</ns0:PV_UUID_TRX>
            <ns0:PV_CLAVE_CONVENIO>{ $CLAVE_CONVENIO }</ns0:PV_CLAVE_CONVENIO>
            <ns0:PN_MONTO_TRX>{ $MONTO }</ns0:PN_MONTO_TRX>
            <ns0:PV_MONEDA>{ $MONEDA }</ns0:PV_MONEDA>
            <ns0:PV_CUENTA_DEBITO>{ $CUENTA_DEBITO }</ns0:PV_CUENTA_DEBITO>
            <ns0:PV_TIPO_TRANSACCION_T24>{ $TIPO_TRANSACCION_T24 }</ns0:PV_TIPO_TRANSACCION_T24>
            <ns0:PV_CANAL>{ $CANAL }</ns0:PV_CANAL>
            <ns0:PV_PAIS>{ $PAIS }</ns0:PV_PAIS>
            <ns0:PV_CODIGO_CORRESPONSAL>{ $CODIGO_CORRESPONSAL }</ns0:PV_CODIGO_CORRESPONSAL>
            <ns0:PN_CLAVE_CORRESPONSAL>{ $CLAVE_CORRESPONSAL }</ns0:PN_CLAVE_CORRESPONSAL>
            <ns0:PV_TIPO_TRANSACCION>{ $TIPO_TRANSACCION }</ns0:PV_TIPO_TRANSACCION>
            <ns0:PN_ESTADO_TRX>{ $ESTADO }</ns0:PN_ESTADO_TRX>
            <ns0:PV_REFERENCIA_T24>{ $REFERENCIA_T24 }</ns0:PV_REFERENCIA_T24>
            <ns0:PV_PUNTO_DE_VENTA_CORRESPONSAL>{ $PUNTO_VENTA_CORRESPONSAL }</ns0:PV_PUNTO_DE_VENTA_CORRESPONSAL>
            <ns0:PV_SUB_PUNTO_DE_VENTA_CORRESPONSAL>{ $SUB_PUNTO_VENTA_CORRESPONSAL }</ns0:PV_SUB_PUNTO_DE_VENTA_CORRESPONSAL>
            <ns0:PV_ID_CLIENTE>{ $ID_CLIENTE }</ns0:PV_ID_CLIENTE>
            <ns0:PV_NOMBRE_CLIENTE>{ $NOMBRE_CLIENTE }</ns0:PV_NOMBRE_CLIENTE>
            <ns0:PV_PAYMENT_DETAILS>{ $PAYMENT_DETAILS }</ns0:PV_PAYMENT_DETAILS>
            <ns0:PV_CUENTA_CREDITO>{ $CUENTA_CREDITO }</ns0:PV_CUENTA_CREDITO>
        </ns0:InputParameters>
};

declare variable $UUID as xs:string external;
declare variable $CLAVE_CONVENIO as xs:string external;
declare variable $MONTO as xs:decimal external;
declare variable $MONEDA as xs:string external;
declare variable $CUENTA_DEBITO as xs:string external;
declare variable $TIPO_TRANSACCION_T24 as xs:string external;
declare variable $CANAL as xs:string external;
declare variable $PAIS as xs:string external;
declare variable $CODIGO_CORRESPONSAL as xs:string external;
declare variable $CLAVE_CORRESPONSAL as xs:string external;
declare variable $TIPO_TRANSACCION as xs:string external;
declare variable $ESTADO as xs:decimal external;
declare variable $REFERENCIA_T24 as xs:string external;
declare variable $PUNTO_VENTA_CORRESPONSAL as xs:string external;
declare variable $SUB_PUNTO_VENTA_CORRESPONSAL as xs:string external;
declare variable $ID_CLIENTE as xs:string external;
declare variable $NOMBRE_CLIENTE as xs:string external;
declare variable $PAYMENT_DETAILS as xs:string external;
declare variable $CUENTA_CREDITO as xs:string external;

xf:registrarTransaccion($UUID,
    $CLAVE_CONVENIO,
    $MONTO,
    $MONEDA,
    $CUENTA_DEBITO,
    $TIPO_TRANSACCION_T24,
    $CANAL,
    $PAIS,
    $CODIGO_CORRESPONSAL,
    $CLAVE_CORRESPONSAL,
    $TIPO_TRANSACCION,
    $ESTADO,
    $REFERENCIA_T24,
    $PUNTO_VENTA_CORRESPONSAL,
    $SUB_PUNTO_VENTA_CORRESPONSAL,
    $ID_CLIENTE,
    $NOMBRE_CLIENTE,
    $PAYMENT_DETAILS,
    $CUENTA_CREDITO)
