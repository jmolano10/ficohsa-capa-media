(:: pragma bea:global-element-parameter parameter="$procesaTransaccionesGenericasRequest1" element="ns0:procesaTransaccionesGenericasRequest" location="../xsd/procesaTransaccionesGenericasType.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaTransaccionesGenericasRequest" location="../xsd/procesaTransaccionesGenericasType.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaTransaccionesGenericasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransaccionesGenericasCB/ProcesarTransaccionesGenericaCB/xq/procesarTransaccionGenericaCBToT24In/";

declare function xf:procesarTransaccionGenericaCBToT24In($procesaTransaccionesGenericasRequest1 as element(ns0:procesaTransaccionesGenericasRequest),
    $UUID as xs:string,
    $Debito as xs:string,
    $Credito as xs:string,
    $Ft as xs:string)
    as element(ns0:procesaTransaccionesGenericasRequest) {
        <ns0:procesaTransaccionesGenericasRequest>
            <TIPO_TRANSACCION>{ data($procesaTransaccionesGenericasRequest1/TIPO_TRANSACCION) }</TIPO_TRANSACCION>
            <CODIGO_TRANSACCION>{ $UUID }</CODIGO_TRANSACCION>
            <CLAVE_CONVENIO>{ $Debito }</CLAVE_CONVENIO>
            <MONTO_TRX>{ data($procesaTransaccionesGenericasRequest1/MONTO_TRX) }</MONTO_TRX>
            <MONEDA>{ data($procesaTransaccionesGenericasRequest1/MONEDA) }</MONEDA>
            <CLAVE_CORRESPONSAL>{ data($procesaTransaccionesGenericasRequest1/CLAVE_CORRESPONSAL) }</CLAVE_CORRESPONSAL>
            <ID_CLIENTE>{ $Ft }</ID_CLIENTE>
            {
                for $NOMBRE_CLIENTE in $procesaTransaccionesGenericasRequest1/NOMBRE_CLIENTE
                return
                    <NOMBRE_CLIENTE>{ data($NOMBRE_CLIENTE) }</NOMBRE_CLIENTE>
            }
            <PAYMENT_DETAILS>{ $Credito }</PAYMENT_DETAILS>
        </ns0:procesaTransaccionesGenericasRequest>
};

declare variable $procesaTransaccionesGenericasRequest1 as element(ns0:procesaTransaccionesGenericasRequest) external;
declare variable $UUID as xs:string external;
declare variable $Debito as xs:string external;
declare variable $Credito as xs:string external;
declare variable $Ft as xs:string external;

xf:procesarTransaccionGenericaCBToT24In($procesaTransaccionesGenericasRequest1,
    $UUID,
    $Debito,
    $Credito,
    $Ft)
