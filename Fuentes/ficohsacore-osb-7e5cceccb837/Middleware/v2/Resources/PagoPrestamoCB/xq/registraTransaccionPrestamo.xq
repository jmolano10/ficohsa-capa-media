xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$pagoPrestamo" element="ns0:pagoPrestamo" location="../../../BusinessServices/OSB/PagoPrestamoCB/xsd/XMLSchema_-541390746.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElementsCB.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MDW/registraEstadoTransaccion/xsd/registraEstadoTransaccion_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoPrestamoCB/xq/registraTransaccionPrestamo/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraEstadoTransaccion";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";

declare function xf:registraTransaccionPrestamo($tipoTransaccion as xs:string,
    $codigoCanal as xs:string,
    $estadoTransaccion as xs:string,
    $referenciaT24 as xs:string,
    $pagoPrestamo as element(ns0:pagoPrestamo),
    $requestHeader as element(ns2:RequestHeader))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CORRESPONSAL>{ data($requestHeader/Authentication/UserName) }</ns1:PV_CORRESPONSAL>
            <ns1:PN_TIPO_TRANSACCION>{ $tipoTransaccion }</ns1:PN_TIPO_TRANSACCION>
            <ns1:PV_CODIGO_CANAL>{ $codigoCanal }</ns1:PV_CODIGO_CANAL>
            <ns1:PV_ESTADO_TRANSACCION>{ $estadoTransaccion }</ns1:PV_ESTADO_TRANSACCION>
            <ns1:PN_MONTO>{ data($pagoPrestamo/PAYMENT_AMOUNT) }</ns1:PN_MONTO>
            <ns1:PV_MONEDA>{ data($pagoPrestamo/PAYMENT_CURRENCY) }</ns1:PV_MONEDA>
            <ns1:PV_CODIGO_PAIS>{ data($requestHeader/Region/SourceBank) }</ns1:PV_CODIGO_PAIS>
            <ns1:PV_CLAVE_CORRESPONSAL>{ data($pagoPrestamo/TRANSACTION_ID_BC) }</ns1:PV_CLAVE_CORRESPONSAL>
            <ns1:PV_REFERENCIA_T24>{ $referenciaT24 }</ns1:PV_REFERENCIA_T24>
            <ns1:PV_CLAVE_TRANSACCION>{ data($pagoPrestamo/LOAN_NUMBER) }</ns1:PV_CLAVE_TRANSACCION>
            <ns1:PV_COD_CORRESPONSAL>{ data($requestHeader/BankingCorrespondent/Id) }</ns1:PV_COD_CORRESPONSAL>
            <ns1:PV_PUNTO_VENTA_CORR>{ data($requestHeader/BankingCorrespondent/PointOfSale) }</ns1:PV_PUNTO_VENTA_CORR>
            <ns1:PV_SUB_PUNTO_VENTA_CORR>{ data($requestHeader/BankingCorrespondent/SubPointOfSale) }</ns1:PV_SUB_PUNTO_VENTA_CORR>
        </ns1:InputParameters>
};

declare variable $tipoTransaccion as xs:string external;
declare variable $codigoCanal as xs:string external;
declare variable $estadoTransaccion as xs:string external;
declare variable $referenciaT24 as xs:string external;
declare variable $pagoPrestamo as element(ns0:pagoPrestamo) external;
declare variable $requestHeader as element(ns2:RequestHeader) external;

xf:registraTransaccionPrestamo($tipoTransaccion,
    $codigoCanal,
    $estadoTransaccion,
    $referenciaT24,
    $pagoPrestamo,
    $requestHeader)