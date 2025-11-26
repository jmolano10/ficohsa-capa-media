(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElementsCB.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$depositoACuenta1" element="ns0:depositoACuenta" location="../xsd/depositoACuentaCBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/TransaccionesAsincronas/DB/RegistrarTransaccionNoAsinc/xsd/registrarTrxNoAsincCB_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarTrxNoAsincCB";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/depositoACuentaCBTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/DepositoACuentaCB/xq/registrarTransansaccionNoAsincIn/";

declare function xf:registrarTransansaccionNoAsincIn($requestHeader1 as element(ns2:RequestHeader),
    $depositoACuenta1 as element(ns0:depositoACuenta),
    $TipoTrxT24 as xs:string,
    $estadoTrx as xs:string,
    $tipoTransaccion as xs:string,
    $FT as xs:string,
    $codCanal as xs:string,
    $cuentaDebito as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_UUID>{ data($depositoACuenta1/INSTRUCTING_PARTY/TRANSACTION_UUID) }</ns1:PV_UUID>
            <ns1:PV_CORRESPONSAL>{ data($requestHeader1/Authentication/UserName) }</ns1:PV_CORRESPONSAL>
            <ns1:PN_TIPO_TRANSACCION>{ $tipoTransaccion }</ns1:PN_TIPO_TRANSACCION>
            <ns1:PV_CODIGO_CANAL>{ $codCanal }</ns1:PV_CODIGO_CANAL>
            <ns1:PN_ESTADO_TRANSACCION>{ $estadoTrx }</ns1:PN_ESTADO_TRANSACCION>
            <ns1:PN_MONTO>{ data($depositoACuenta1/DEPOSIT_ITEMS/DEPOSIT_ITEM[1]/AMOUNT) }</ns1:PN_MONTO>
            <ns1:PV_MONEDA>{ data($depositoACuenta1/CURRENCY) }</ns1:PV_MONEDA>
            <ns1:PV_CODIGO_PAIS>{ data($requestHeader1/Region/SourceBank) }</ns1:PV_CODIGO_PAIS>
            <ns1:PV_CLAVE_CORRESPONSAL>{ data($depositoACuenta1/INSTRUCTING_PARTY/TRANSACTION_ID_BC) }</ns1:PV_CLAVE_CORRESPONSAL>
            <ns1:PV_REFERENCIA_T24>{ $FT }</ns1:PV_REFERENCIA_T24>
            <ns1:PV_CLAVE_TRANSACCION>{ data($depositoACuenta1/ACCOUNT_NUMBER) }</ns1:PV_CLAVE_TRANSACCION>
            <ns1:PV_COD_CORRESPONSAL>{ data($requestHeader1/BankingCorrespondent/Id) }</ns1:PV_COD_CORRESPONSAL>
            <ns1:PV_PUNTO_VENTA_CORR>{ data($requestHeader1/BankingCorrespondent/PointOfSale) }</ns1:PV_PUNTO_VENTA_CORR>
            <ns1:PV_SUB_PUNTO_VENTA_CORR>{ data($requestHeader1/BankingCorrespondent/SubPointOfSale) }</ns1:PV_SUB_PUNTO_VENTA_CORR>
            <ns1:PV_IDENTIDAD_SOLICITANTE>{ data($depositoACuenta1/INSTRUCTING_PARTY/PAYER_ID) }</ns1:PV_IDENTIDAD_SOLICITANTE>
            <ns1:PV_NOMBRE_SOLICITANTE>{ data($depositoACuenta1/INSTRUCTING_PARTY/PAYER_NAME) }</ns1:PV_NOMBRE_SOLICITANTE>
            <ns1:PV_NUMERO_CUENTA>{ data($depositoACuenta1/ACCOUNT_NUMBER) }</ns1:PV_NUMERO_CUENTA>
            <ns1:PV_TIPO_TRANSACCION_T24>{ $TipoTrxT24 }</ns1:PV_TIPO_TRANSACCION_T24>
            <ns1:PV_CUENTA_DEBITO>{ $cuentaDebito }</ns1:PV_CUENTA_DEBITO>
        </ns1:InputParameters>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $depositoACuenta1 as element(ns0:depositoACuenta) external;
declare variable $TipoTrxT24 as xs:string external;
declare variable $estadoTrx as xs:string external;
declare variable $tipoTransaccion as xs:string external;
declare variable $FT as xs:string external;
declare variable $codCanal as xs:string external;
declare variable $cuentaDebito as xs:string external;

xf:registrarTransansaccionNoAsincIn($requestHeader1,
    $depositoACuenta1,
    $TipoTrxT24,
    $estadoTrx,
    $tipoTransaccion,
    $FT,
    $codCanal,
    $cuentaDebito)
