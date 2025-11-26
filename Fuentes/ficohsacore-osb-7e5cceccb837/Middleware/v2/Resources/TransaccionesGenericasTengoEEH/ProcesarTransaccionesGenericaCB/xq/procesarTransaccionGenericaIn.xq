(:: pragma bea:global-element-parameter parameter="$procesaTransaccionesGenericasRequest1" element="ns0:procesaTransaccionesGenericasRequest" location="../xsd/procesaTransaccionesGenericasType.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../BusinessServices/MDW/TransaccionesGenericasEEH/ProcesarTransaccionesGenericas/xsd/registrarTransaccionesGenericas_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarTransaccionesGenericas";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaTransaccionesGenericasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransaccionesGenericasTengoEEH/ProcesarTransaccionesGenericaCB/xq/procesarTransaccionGenericaIn/";

declare function xf:procesarTransaccionGenericaIn($procesaTransaccionesGenericasRequest1 as element(ns0:procesaTransaccionesGenericasRequest),
    $UUID_TRX as xs:string,
    $CUENTA_DEBITO as xs:string,
    $TIPO_TRANSACCION_T24 as xs:string,
    $PV_CANAL as xs:string,
    $PAIS as xs:string,
    $PV_CODIGO_CORRESPONSAL as xs:string,
    $CLAVE_CORRESPONSAL as xs:string,
    $ESTADO_TRX as xs:decimal,
    $FECHA_TRX as xs:dateTime,
    $REFERENCIA_T24 as xs:string,
    $PUNTO_DE_VENTA_CORRESPONSAL as xs:string,
    $SUB_PUNTO_DE_VENTA_CORRESPONSAL as xs:string,
    $FECHA_REVERSION_TRX as xs:dateTime,
    $CUENTA_CREDITO as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_UUID_TRX>{ $UUID_TRX }</ns1:PV_UUID_TRX>
            <ns1:PV_CLAVE_CONVENIO>{ data($procesaTransaccionesGenericasRequest1/CLAVE_CONVENIO) }</ns1:PV_CLAVE_CONVENIO>
            <ns1:PN_MONTO_TRX>{ data($procesaTransaccionesGenericasRequest1/MONTO_TRX) }</ns1:PN_MONTO_TRX>
            <ns1:PV_MONEDA>{ data($procesaTransaccionesGenericasRequest1/MONEDA) }</ns1:PV_MONEDA>
            <ns1:PV_CUENTA_DEBITO>{ $CUENTA_DEBITO }</ns1:PV_CUENTA_DEBITO>
            <ns1:PV_TIPO_TRANSACCION_T24>{ $TIPO_TRANSACCION_T24 }</ns1:PV_TIPO_TRANSACCION_T24>
            <ns1:PV_CANAL>{ $PV_CANAL }</ns1:PV_CANAL>
            <ns1:PV_PAIS>{ $PAIS }</ns1:PV_PAIS>
            <ns1:PV_CODIGO_CORRESPONSAL>{ $PV_CODIGO_CORRESPONSAL }</ns1:PV_CODIGO_CORRESPONSAL>
            <ns1:PN_CLAVE_CORRESPONSAL>{ data($procesaTransaccionesGenericasRequest1/CLAVE_CORRESPONSAL) }</ns1:PN_CLAVE_CORRESPONSAL>
            <ns1:PV_TIPO_TRANSACCION>{ data($procesaTransaccionesGenericasRequest1/TIPO_TRANSACCION) }</ns1:PV_TIPO_TRANSACCION>
            <ns1:PN_ESTADO_TRX>{ $ESTADO_TRX }</ns1:PN_ESTADO_TRX>
            <ns1:PV_FECHA_TRX_PAGO>{ $FECHA_TRX }</ns1:PV_FECHA_TRX_PAGO>
            <ns1:PV_REFERENCIA_T24>{ $REFERENCIA_T24 }</ns1:PV_REFERENCIA_T24>
            <ns1:PV_PUNTO_DE_VENTA_CORRESPONSAL>{ $PUNTO_DE_VENTA_CORRESPONSAL }</ns1:PV_PUNTO_DE_VENTA_CORRESPONSAL>
            <ns1:PV_SUB_PUNTO_DE_VENTA_CORRESPONSAL>{ $SUB_PUNTO_DE_VENTA_CORRESPONSAL }</ns1:PV_SUB_PUNTO_DE_VENTA_CORRESPONSAL>
            {
                for $ID_CLIENTE in $procesaTransaccionesGenericasRequest1/ID_CLIENTE
                return
                    <ns1:PV_ID_CLIENTE>{ data($ID_CLIENTE) }</ns1:PV_ID_CLIENTE>
            }
            {
                for $NOMBRE_CLIENTE in $procesaTransaccionesGenericasRequest1/NOMBRE_CLIENTE
                return
                    <ns1:PV_NOMBRE_CLIENTE>{ data($NOMBRE_CLIENTE) }</ns1:PV_NOMBRE_CLIENTE>
            }
            <ns1:PV_FECHA_REVERSION_TRX>{ $FECHA_REVERSION_TRX }</ns1:PV_FECHA_REVERSION_TRX>
            {
                for $PAYMENT_DETAILS in $procesaTransaccionesGenericasRequest1/PAYMENT_DETAILS
                return
                    <ns1:PV_PAYMENT_DETAILS>{ data($PAYMENT_DETAILS) }</ns1:PV_PAYMENT_DETAILS>
            }
            <ns1:PV_CUENTA_CREDITO>{ $CUENTA_CREDITO }</ns1:PV_CUENTA_CREDITO>
        </ns1:InputParameters>
};

declare variable $procesaTransaccionesGenericasRequest1 as element(ns0:procesaTransaccionesGenericasRequest) external;
declare variable $UUID_TRX as xs:string external;
declare variable $CUENTA_DEBITO as xs:string external;
declare variable $TIPO_TRANSACCION_T24 as xs:string external;
declare variable $PV_CANAL as xs:string external;
declare variable $PAIS as xs:string external;
declare variable $PV_CODIGO_CORRESPONSAL as xs:string external;
declare variable $CLAVE_CORRESPONSAL as xs:string external;
declare variable $ESTADO_TRX as xs:decimal external;
declare variable $FECHA_TRX as xs:dateTime external;
declare variable $REFERENCIA_T24 as xs:string external;
declare variable $PUNTO_DE_VENTA_CORRESPONSAL as xs:string external;
declare variable $SUB_PUNTO_DE_VENTA_CORRESPONSAL as xs:string external;
declare variable $FECHA_REVERSION_TRX as xs:dateTime external;
declare variable $CUENTA_CREDITO as xs:string external;

xf:procesarTransaccionGenericaIn($procesaTransaccionesGenericasRequest1,
    $UUID_TRX,
    $CUENTA_DEBITO,
    $TIPO_TRANSACCION_T24,
    $PV_CANAL,
    $PAIS,
    $PV_CODIGO_CORRESPONSAL,
    $CLAVE_CORRESPONSAL,
    $ESTADO_TRX,
    $FECHA_TRX,
    $REFERENCIA_T24,
    $PUNTO_DE_VENTA_CORRESPONSAL,
    $SUB_PUNTO_DE_VENTA_CORRESPONSAL,
    $FECHA_REVERSION_TRX,
    $CUENTA_CREDITO)
