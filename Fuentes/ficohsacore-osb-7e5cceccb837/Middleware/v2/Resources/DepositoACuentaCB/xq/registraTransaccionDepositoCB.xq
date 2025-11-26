(:: pragma bea:global-element-parameter parameter="$depositoACuenta" element="ns1:depositoACuenta" location="../xsd/depositoACuentaCBTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeaderCB" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElementsCB.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TransaccionesAsincronas/DB/RegistrarTransaccionCB/xsd/registrarTransaccionCB_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/depositoACuentaCBTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarTransaccionCB";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/DepositoACuentaCB/xq/registraTransaccionDepositoCB/";

declare function xf:registraTransaccionDepositoCB($tipoTransaccion as xs:string,
    $codigoCanal as xs:string,
    $estadoTransaccion as xs:string,
    $depositoACuenta as element(ns1:depositoACuenta),
    $requestHeaderCB as element(ns2:RequestHeader))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_UUID>{ data($depositoACuenta/INSTRUCTING_PARTY/TRANSACTION_UUID) }</ns0:PV_UUID>
            <ns0:PV_CORRESPONSAL>{ data($requestHeaderCB/Authentication/UserName) }</ns0:PV_CORRESPONSAL>
            <ns0:PN_TIPO_TRANSACCION>{ $tipoTransaccion }</ns0:PN_TIPO_TRANSACCION>
            <ns0:PV_CODIGO_CANAL>{ $codigoCanal }</ns0:PV_CODIGO_CANAL>
            <ns0:PN_ESTADO_TRANSACCION>{ $estadoTransaccion }</ns0:PN_ESTADO_TRANSACCION>
            <ns0:PN_MONTO>{ data($depositoACuenta/DEPOSIT_ITEMS/DEPOSIT_ITEM[1]/AMOUNT) }</ns0:PN_MONTO>
            <ns0:PV_MONEDA>{ data($depositoACuenta/CURRENCY) }</ns0:PV_MONEDA>
            <ns0:PV_CODIGO_PAIS>{ data($requestHeaderCB/Region/SourceBank) }</ns0:PV_CODIGO_PAIS>
            <ns0:PV_CLAVE_CORRESPONSAL>{ data($depositoACuenta/INSTRUCTING_PARTY/TRANSACTION_ID_BC) }</ns0:PV_CLAVE_CORRESPONSAL>
            <ns0:PV_CLAVE_TRANSACCION>{ data($depositoACuenta/ACCOUNT_NUMBER) }</ns0:PV_CLAVE_TRANSACCION>
            <ns0:PV_COD_CORRESPONSAL>{ data($requestHeaderCB/BankingCorrespondent/Id) }</ns0:PV_COD_CORRESPONSAL>
            <ns0:PV_PUNTO_VENTA_CORR>{ data($requestHeaderCB/BankingCorrespondent/PointOfSale) }</ns0:PV_PUNTO_VENTA_CORR>
            <ns0:PV_SUB_PUNTO_VENTA_CORR>{ data($requestHeaderCB/BankingCorrespondent/SubPointOfSale) }</ns0:PV_SUB_PUNTO_VENTA_CORR>
            <ns0:PV_IDENTIDAD_SOLICITANTE>{ data($depositoACuenta/INSTRUCTING_PARTY/PAYER_ID) }</ns0:PV_IDENTIDAD_SOLICITANTE>
            <ns0:PV_NOMBRE_SOLICITANTE>{ data($depositoACuenta/INSTRUCTING_PARTY/PAYER_NAME) }</ns0:PV_NOMBRE_SOLICITANTE>
        </ns0:InputParameters>
};

declare variable $tipoTransaccion as xs:string external;
declare variable $codigoCanal as xs:string external;
declare variable $estadoTransaccion as xs:string external;
declare variable $depositoACuenta as element(ns1:depositoACuenta) external;
declare variable $requestHeaderCB as element(ns2:RequestHeader) external;

xf:registraTransaccionDepositoCB($tipoTransaccion,
    $codigoCanal,
    $estadoTransaccion,
    $depositoACuenta,
    $requestHeaderCB)
