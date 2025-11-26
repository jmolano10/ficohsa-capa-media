(:: pragma bea:global-element-parameter parameter="$requestHeaderCB" element="ns2:RequestHeader" location="../../../esquemas_generales/HeaderElementsCB.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$procesaTransaccionesGenericasRequest" element="ns0:procesaTransaccionesGenericasRequest" location="../xsd/procesaTransaccionesGenericasType.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../BusinessServices/TransaccionesGenericasCB/RegistrarTransaccionGenericaCB/xsd/registrarTransaccionGenCB_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarTransaccionGenCB";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaTransaccionesGenericasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransaccionesGenericasCB/ProcesarTransaccionesGenericaCB/xq/registrarTransaccionGenericaDBIn/";

declare function xf:registrarTransaccionGenericaDBIn($requestHeaderCB as element(ns2:RequestHeader),
    $procesaTransaccionesGenericasRequest as element(ns0:procesaTransaccionesGenericasRequest),
    $cuentaDebito as xs:string,
    $cuentaCredito as xs:string,
    $UUID as xs:string,
    $tipoTRXT24 as xs:string,
    $tipoTRX as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_UUID_TRX>{ $UUID }</ns1:PV_UUID_TRX>
            <ns1:PV_CLAVE_CONVENIO>{ data($procesaTransaccionesGenericasRequest/CLAVE_CONVENIO) }</ns1:PV_CLAVE_CONVENIO>
            <ns1:PN_MONTO_TRX>{ data($procesaTransaccionesGenericasRequest/MONTO_TRX) }</ns1:PN_MONTO_TRX>
            <ns1:PV_MONEDA>{ data($procesaTransaccionesGenericasRequest/MONEDA) }</ns1:PV_MONEDA>
            <ns1:PV_CUENTA_DEBITO>{ $cuentaDebito }</ns1:PV_CUENTA_DEBITO>
            <ns1:PV_TIPO_TRANSACCION_T24>{ $tipoTRXT24 }</ns1:PV_TIPO_TRANSACCION_T24>
            <ns1:PV_CANAL>{ data($requestHeaderCB/Authentication/UserName) }</ns1:PV_CANAL>
            <ns1:PV_PAIS>{ data($requestHeaderCB/Region/SourceBank) }</ns1:PV_PAIS>
            <ns1:PV_CODIGO_CORRESPONSAL>{ data($requestHeaderCB/BankingCorrespondent/Id) }</ns1:PV_CODIGO_CORRESPONSAL>
            <ns1:PN_CLAVE_CORRESPONSAL>{ data($procesaTransaccionesGenericasRequest/CLAVE_CORRESPONSAL) }</ns1:PN_CLAVE_CORRESPONSAL>
            <ns1:PV_TIPO_TRANSACCION>{ $tipoTRX }</ns1:PV_TIPO_TRANSACCION>
            <ns1:PN_ESTADO_TRX>3</ns1:PN_ESTADO_TRX>
            <ns1:PV_PUNTO_DE_VENTA_CORRESPONSAL>{ data($requestHeaderCB/BankingCorrespondent/PointOfSale) }</ns1:PV_PUNTO_DE_VENTA_CORRESPONSAL>
            <ns1:PV_SUB_PUNTO_DE_VENTA_CORRESPONSAL>{ data($requestHeaderCB/BankingCorrespondent/SubPointOfSale) }</ns1:PV_SUB_PUNTO_DE_VENTA_CORRESPONSAL>
            <ns1:PV_ID_CLIENTE>{ data($procesaTransaccionesGenericasRequest/ID_CLIENTE) }</ns1:PV_ID_CLIENTE>
            <ns1:PV_NOMBRE_CLIENTE>{ data($procesaTransaccionesGenericasRequest/NOMBRE_CLIENTE) }</ns1:PV_NOMBRE_CLIENTE>
            <ns1:PV_PAYMENT_DETAILS>{ data($procesaTransaccionesGenericasRequest/PAYMENT_DETAILS) }</ns1:PV_PAYMENT_DETAILS>
            <ns1:PV_CUENTA_CREDITO>{ $cuentaCredito }</ns1:PV_CUENTA_CREDITO>
            <ns1:PV_COD_OPERACION_OSB>{ data($procesaTransaccionesGenericasRequest/TIPO_TRANSACCION) }</ns1:PV_COD_OPERACION_OSB>
        </ns1:InputParameters>
};

declare variable $requestHeaderCB as element(ns2:RequestHeader) external;
declare variable $procesaTransaccionesGenericasRequest as element(ns0:procesaTransaccionesGenericasRequest) external;
declare variable $cuentaDebito as xs:string external;
declare variable $cuentaCredito as xs:string external;
declare variable $UUID as xs:string external;
declare variable $tipoTRXT24 as xs:string external;
declare variable $tipoTRX as xs:string external;

xf:registrarTransaccionGenericaDBIn($requestHeaderCB,
    $procesaTransaccionesGenericasRequest,
    $cuentaDebito,
    $cuentaCredito,
    $UUID,
    $tipoTRXT24,
    $tipoTRX)
