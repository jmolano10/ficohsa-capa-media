xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeaderCB" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElementsCB.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$depositoACuenta" element="ns0:depositoACuenta" location="../xsd/depositoACuentaCBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MDW/registraEstadoTransaccion/xsd/registraEstadoTransaccion_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/DepositoACuentaCB/xq/registraEstadoTransaccionDeposito/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraEstadoTransaccion";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/depositoACuentaCBTypes";

declare function xf:registraEstadoTransaccionDeposito($tipoTransaccion as xs:string,
    $codigoCanal as xs:string,
    $estadoTransaccion as xs:string,
    $referenciaT24 as xs:string,
    $requestHeaderCB as element(ns2:RequestHeader),
    $depositoACuenta as element(ns0:depositoACuenta))
    as element(ns1:InputParameters) {
            <ns1:InputParameters>
            <ns1:PV_CORRESPONSAL>{ data($requestHeaderCB/Authentication/UserName) }</ns1:PV_CORRESPONSAL>
            <ns1:PN_TIPO_TRANSACCION>{ $tipoTransaccion }</ns1:PN_TIPO_TRANSACCION>
            <ns1:PV_CODIGO_CANAL>{ $codigoCanal }</ns1:PV_CODIGO_CANAL>
            <ns1:PV_ESTADO_TRANSACCION>{ $estadoTransaccion }</ns1:PV_ESTADO_TRANSACCION>
            <ns1:PN_MONTO>{ data($depositoACuenta/DEPOSIT_ITEMS/DEPOSIT_ITEM/AMOUNT) }</ns1:PN_MONTO>
            <ns1:PV_MONEDA>{ data($depositoACuenta/CURRENCY) }</ns1:PV_MONEDA>
            <ns1:PV_CODIGO_PAIS>{ data($requestHeaderCB/Region/SourceBank) }</ns1:PV_CODIGO_PAIS>
            <ns1:PV_CLAVE_CORRESPONSAL>{ data($depositoACuenta/INSTRUCTING_PARTY/TRANSACTION_ID_BC) }</ns1:PV_CLAVE_CORRESPONSAL>
            <ns1:PV_REFERENCIA_T24>{ $referenciaT24 }</ns1:PV_REFERENCIA_T24>
            <ns1:PV_CLAVE_TRANSACCION>{ data($depositoACuenta/ACCOUNT_NUMBER) }</ns1:PV_CLAVE_TRANSACCION>
            <ns1:PV_COD_CORRESPONSAL>{ data($requestHeaderCB/BankingCorrespondent/Id) }</ns1:PV_COD_CORRESPONSAL>
            <ns1:PV_PUNTO_VENTA_CORR>{ data($requestHeaderCB/BankingCorrespondent/PointOfSale) }</ns1:PV_PUNTO_VENTA_CORR>
            <ns1:PV_SUB_PUNTO_VENTA_CORR>{ data($requestHeaderCB/BankingCorrespondent/SubPointOfSale) }</ns1:PV_SUB_PUNTO_VENTA_CORR>
            <ns1:PV_IDENTIDAD_SOLICITANTE>{ data($depositoACuenta/INSTRUCTING_PARTY/PAYER_ID) }</ns1:PV_IDENTIDAD_SOLICITANTE>
            <ns1:PV_NOMBRE_SOLICITANTE>{ data($depositoACuenta/INSTRUCTING_PARTY/PAYER_NAME) }</ns1:PV_NOMBRE_SOLICITANTE>
        </ns1:InputParameters>
};

declare variable $tipoTransaccion as xs:string external;
declare variable $codigoCanal as xs:string external;
declare variable $estadoTransaccion as xs:string external;
declare variable $referenciaT24 as xs:string external;
declare variable $requestHeaderCB as element(ns2:RequestHeader) external;
declare variable $depositoACuenta as element(ns0:depositoACuenta) external;

xf:registraEstadoTransaccionDeposito($tipoTransaccion,
    $codigoCanal,
    $estadoTransaccion,
    $referenciaT24,$requestHeaderCB,
    $depositoACuenta)