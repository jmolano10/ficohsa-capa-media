(:: pragma bea:global-element-parameter parameter="$requestHeaderCB" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElementsCB.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCredito" element="ns1:pagoTarjetaCredito" location="../xsd/pagoTarjetaCreditoCBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TransaccionesAsincronas/DB/RegistrarTransaccionCB/xsd/registrarTransaccionCB_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarTransaccionCB";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoTarjetaCreditoCB/xq/registrarPagoTCCB_db/";

declare function xf:registrarPagoTCCB_db($tipoTransaccion as xs:string,
    $codigoCanal as xs:string,
    $estadoTransaccion as xs:string,
    $requestHeaderCB as element(ns2:RequestHeader),
    $pagoTarjetaCredito as element(ns1:pagoTarjetaCredito))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_UUID>{ data($pagoTarjetaCredito/TRANSACTION_UUID) }</ns0:PV_UUID>
            <ns0:PV_CORRESPONSAL>{ data($requestHeaderCB/Authentication/UserName) }</ns0:PV_CORRESPONSAL>
            <ns0:PN_TIPO_TRANSACCION>{ $tipoTransaccion }</ns0:PN_TIPO_TRANSACCION>
            <ns0:PV_CODIGO_CANAL>{ $codigoCanal }</ns0:PV_CODIGO_CANAL>
            <ns0:PN_ESTADO_TRANSACCION>{ $estadoTransaccion }</ns0:PN_ESTADO_TRANSACCION>
            <ns0:PN_MONTO>{ data($pagoTarjetaCredito/PAYMENT_AMOUNT) }</ns0:PN_MONTO>
            <ns0:PV_MONEDA>{ data($pagoTarjetaCredito/BALANCE_CURRENCY) }</ns0:PV_MONEDA>
            <ns0:PV_CODIGO_PAIS>{ data($requestHeaderCB/Region/SourceBank) }</ns0:PV_CODIGO_PAIS>
            <ns0:PV_CLAVE_CORRESPONSAL>{ data($pagoTarjetaCredito/TRANSACTION_ID_BC) }</ns0:PV_CLAVE_CORRESPONSAL>
            <ns0:PV_CLAVE_TRANSACCION>{ data($pagoTarjetaCredito/CREDIT_CARD_NUMBER) }</ns0:PV_CLAVE_TRANSACCION>
            <ns0:PV_COD_CORRESPONSAL>{ data($requestHeaderCB/BankingCorrespondent/Id) }</ns0:PV_COD_CORRESPONSAL>
            <ns0:PV_PUNTO_VENTA_CORR>{ data($requestHeaderCB/BankingCorrespondent/PointOfSale) }</ns0:PV_PUNTO_VENTA_CORR>
            <ns0:PV_SUB_PUNTO_VENTA_CORR>{ data($requestHeaderCB/BankingCorrespondent/SubPointOfSale) }</ns0:PV_SUB_PUNTO_VENTA_CORR>
            <ns0:PV_NUMERO_CUENTA>{ data($pagoTarjetaCredito/DEBIT_ACCOUNT) }</ns0:PV_NUMERO_CUENTA>
        </ns0:InputParameters>
};

declare variable $tipoTransaccion as xs:string external;
declare variable $codigoCanal as xs:string external;
declare variable $estadoTransaccion as xs:string external;
declare variable $requestHeaderCB as element(ns2:RequestHeader) external;
declare variable $pagoTarjetaCredito as element(ns1:pagoTarjetaCredito) external;

xf:registrarPagoTCCB_db($tipoTransaccion,
    $codigoCanal,
    $estadoTransaccion,
    $requestHeaderCB,
    $pagoTarjetaCredito)
