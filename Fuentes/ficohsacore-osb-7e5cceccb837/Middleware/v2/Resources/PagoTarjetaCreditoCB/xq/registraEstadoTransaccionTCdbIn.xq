(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElementsCB.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCredito" element="ns1:pagoTarjetaCredito" location="../xsd/pagoTarjetaCreditoCBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/MDW/registraEstadoTransaccion/xsd/registraEstadoTransaccion_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraEstadoTransaccion";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoTarjetaCreditoCB/xq/registraEstadoTransaccionTCdbIn/";

declare function xf:registraEstadoTransaccionTCdbIn($requestHeader as element(ns0:RequestHeader),
    $pagoTarjetaCredito as element(ns1:pagoTarjetaCredito),
    $tipoTransaccion as xs:string,
    $codigoCanal as xs:string,
    $estadoTransaccion as xs:string,
    $referenciaT24 as xs:string,
    $referenciaT24Reversion as xs:string)
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:PV_CORRESPONSAL>{ data($requestHeader/Authentication/UserName) }</ns2:PV_CORRESPONSAL>
            <ns2:PN_TIPO_TRANSACCION>{ $tipoTransaccion }</ns2:PN_TIPO_TRANSACCION>
            <ns2:PV_CODIGO_CANAL>{ $codigoCanal }</ns2:PV_CODIGO_CANAL>
            <ns2:PV_ESTADO_TRANSACCION>{ $estadoTransaccion }</ns2:PV_ESTADO_TRANSACCION>
            <ns2:PN_MONTO>{ data($pagoTarjetaCredito/PAYMENT_AMOUNT) }</ns2:PN_MONTO>
            <ns2:PV_MONEDA>{ data($pagoTarjetaCredito/BALANCE_CURRENCY) }</ns2:PV_MONEDA>
            <ns2:PV_CODIGO_PAIS>{ data($requestHeader/Region/SourceBank) }</ns2:PV_CODIGO_PAIS>
            <ns2:PV_CLAVE_CORRESPONSAL>{ data($pagoTarjetaCredito/TRANSACTION_ID_BC) }</ns2:PV_CLAVE_CORRESPONSAL>
            <ns2:PV_REFERENCIA_T24>{ $referenciaT24 }</ns2:PV_REFERENCIA_T24>
            <ns2:PV_CLAVE_TRANSACCION>{ data($pagoTarjetaCredito/CREDIT_CARD_NUMBER) }</ns2:PV_CLAVE_TRANSACCION>
            <ns2:PV_COD_CORRESPONSAL>{ data($requestHeader/BankingCorrespondent/Id) }</ns2:PV_COD_CORRESPONSAL>
            <ns2:PV_PUNTO_VENTA_CORR>{ data($requestHeader/BankingCorrespondent/PointOfSale) }</ns2:PV_PUNTO_VENTA_CORR>    
            <ns2:PV_SUB_PUNTO_VENTA_CORR>{ data($requestHeader/BankingCorrespondent/SubPointOfSale) }</ns2:PV_SUB_PUNTO_VENTA_CORR>
            <ns2:PV_NUMERO_CUENTA>{ data($pagoTarjetaCredito/DEBIT_ACCOUNT) }</ns2:PV_NUMERO_CUENTA>
            <ns2:PV_REFERENCIA_T24_REV>{ $referenciaT24Reversion }</ns2:PV_REFERENCIA_T24_REV>
        </ns2:InputParameters>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $pagoTarjetaCredito as element(ns1:pagoTarjetaCredito) external;
declare variable $tipoTransaccion as xs:string external;
declare variable $codigoCanal as xs:string external;
declare variable $estadoTransaccion as xs:string external;
declare variable $referenciaT24 as xs:string external;
declare variable $referenciaT24Reversion as xs:string external;

xf:registraEstadoTransaccionTCdbIn($requestHeader,
    $pagoTarjetaCredito,
    $tipoTransaccion,
    $codigoCanal,
    $estadoTransaccion,
    $referenciaT24,
    $referenciaT24Reversion)