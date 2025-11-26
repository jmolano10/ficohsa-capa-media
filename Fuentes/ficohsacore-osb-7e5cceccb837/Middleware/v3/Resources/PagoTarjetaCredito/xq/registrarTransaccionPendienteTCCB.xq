(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCredito" element="ns1:pagoTarjetaCredito" location="../xsd/pagoTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v2/BusinessServices/TransaccionesAsincronas/DB/RegistrarTransaccionPendiente/xsd/registrarTransaccionPendienteCB_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarTransaccionPendienteCB";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/registrarTransaccionPendienteTCCB/";

declare function xf:registrarTransaccionPendienteTCCB($uuidcb as xs:string,
    $montotrx as xs:string,
    $pagoTarjetaCredito as element(ns1:pagoTarjetaCredito),
    $refCB as xs:string,
    $idcliente as xs:string,
    $uuid as xs:string,
    $currentBalance as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_UUID>{ $uuidcb }</ns0:PV_UUID>
            <ns0:PN_TIPO_TRANSACCION>5</ns0:PN_TIPO_TRANSACCION>
            <ns0:PN_CODIGO_ESTADO>3</ns0:PN_CODIGO_ESTADO>
            <ns0:PN_CODIGO_CANAL>1</ns0:PN_CODIGO_CANAL>
            <ns0:PV_MONEDA_DEBITO>{ data($pagoTarjetaCredito/BALANCE_CURRENCY) }</ns0:PV_MONEDA_DEBITO>
            <ns0:PN_MONTO>{ data($pagoTarjetaCredito/PAYMENT_AMOUNT) }</ns0:PN_MONTO>
            <ns0:PV_CUENTA_CREDITO>{ data($pagoTarjetaCredito/DEBIT_ACCOUNT) }</ns0:PV_CUENTA_CREDITO>
            <ns0:PV_ID_REFERENCIA_CANAL>{ $refCB }</ns0:PV_ID_REFERENCIA_CANAL>
            <ns0:PV_CREDIT_CARD_NUMBER>{ data($pagoTarjetaCredito/CREDIT_CARD_NUMBER) }</ns0:PV_CREDIT_CARD_NUMBER>
            <ns0:PV_LR_CR_CCY>{ data($pagoTarjetaCredito/BALANCE_CURRENCY) }</ns0:PV_LR_CR_CCY>
            <ns0:PV_LR_AMT>{ $currentBalance }</ns0:PV_LR_AMT>
            <ns0:PV_ID_CLIENTE>{ $idcliente }</ns0:PV_ID_CLIENTE>
            <ns0:PV_MESSAGE_ID>{ $uuid }</ns0:PV_MESSAGE_ID>
            <ns0:PV_PAYMENT_DETAILS>{ concat(data($pagoTarjetaCredito/REGIONAL_DETAILS/DESTINATION/KV_PAIR[1]/VALUE),'@FM', $montotrx) }</ns0:PV_PAYMENT_DETAILS>
        </ns0:InputParameters>
};

declare variable $uuidcb as xs:string external;
declare variable $montotrx as xs:string external;
declare variable $pagoTarjetaCredito as element(ns1:pagoTarjetaCredito) external;
declare variable $refCB as xs:string external;
declare variable $idcliente as xs:string external;
declare variable $uuid as xs:string external;
declare variable $currentBalance as xs:string external;

xf:registrarTransaccionPendienteTCCB($uuidcb,
    $montotrx,
    $pagoTarjetaCredito,
    $refCB,
    $idcliente,
    $uuid,
    $currentBalance)
