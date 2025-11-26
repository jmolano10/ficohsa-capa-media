(:: pragma bea:global-element-parameter parameter="$depositoACuenta" element="ns1:depositoACuenta" location="../xsd/depositoACuentaCBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TransaccionesAsincronas/DB/RegistrarTransaccionPendiente/xsd/registrarTransaccionPendienteCB_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/depositoACuentaCBTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarTransaccionPendienteCB";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/DepositoACuentaCB/xq/registraTransaccionPendienteCB/";


declare function xf:registraTransaccionPendienteCB($tipotrx as xs:integer,
    $codEstado as xs:integer,
    $codCanal as xs:integer,
    $tipoTrxT24 as xs:string,
    $cuentaDebito as xs:string,
    $depositoACuenta as element(ns1:depositoACuenta))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_UUID>{ data($depositoACuenta/INSTRUCTING_PARTY/TRANSACTION_UUID) }</ns0:PV_UUID>
            <ns0:PN_TIPO_TRANSACCION>{ $tipotrx }</ns0:PN_TIPO_TRANSACCION>
            <ns0:PN_CODIGO_ESTADO>{ $codEstado }</ns0:PN_CODIGO_ESTADO>
            <ns0:PN_CODIGO_CANAL>{ $codCanal }</ns0:PN_CODIGO_CANAL>
            <ns0:PN_TIPO_TRANSACCION_T24>{ $tipoTrxT24 }</ns0:PN_TIPO_TRANSACCION_T24>
            <ns0:PV_CUENTA_DEBITO>{ $cuentaDebito }</ns0:PV_CUENTA_DEBITO>
            <ns0:PV_MONEDA_DEBITO>{ data($depositoACuenta/CURRENCY) }</ns0:PV_MONEDA_DEBITO>
            <ns0:PN_MONTO>{ data($depositoACuenta/DEPOSIT_ITEMS/DEPOSIT_ITEM[1]/AMOUNT) }</ns0:PN_MONTO>
            <ns0:PV_CUENTA_CREDITO>{ data($depositoACuenta/ACCOUNT_NUMBER) }</ns0:PV_CUENTA_CREDITO>
            <ns0:PV_ID_REFERENCIA_CANAL>{ data($depositoACuenta/INSTRUCTING_PARTY/TRANSACTION_ID_BC) }</ns0:PV_ID_REFERENCIA_CANAL>
            <ns0:PV_PAYMENT_DETAILS>{ concat($depositoACuenta/INSTRUCTING_PARTY/PAYER_ID ,'@FM', $depositoACuenta/INSTRUCTING_PARTY/PAYER_NAME) }</ns0:PV_PAYMENT_DETAILS>
        </ns0:InputParameters>
};

declare variable $tipotrx as xs:integer external;
declare variable $codEstado as xs:integer external;
declare variable $codCanal as xs:integer external;
declare variable $tipoTrxT24 as xs:string external;
declare variable $cuentaDebito as xs:string external;
declare variable $depositoACuenta as element(ns1:depositoACuenta) external;

xf:registraTransaccionPendienteCB($tipotrx,
    $codEstado,
    $codCanal,
    $tipoTrxT24,
    $cuentaDebito,
    $depositoACuenta)
