(:: pragma bea:global-element-parameter parameter="$HeaderCB" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElementsCB.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$retiroEfectivoCB" element="ns1:retiroEfectivo" location="../xsd/retiroEfectivoCBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/MDW/registraEstadoTransaccion/xsd/registraEstadoTransaccion_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraEstadoTransaccion";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroEfectivoCBTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroEfectivoCBS/xq/registraEstadoTransaccion/";

declare function xf:registraEstadoTransaccion($tipoTransaccion as xs:string,
    $codigoCanal as xs:string,
    $estadoTransaccion as xs:string,
    $referenciaT24 as xs:string,
    $referenciaT24Comision as xs:string,
    $montoComision as xs:string,
    $monedaComision as xs:string,
    $referenciaT24Reversion as xs:string,
    $HeaderCB as element(ns0:RequestHeader),
    $retiroEfectivoCB as element(ns1:retiroEfectivo))
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:PV_CORRESPONSAL>{ data($HeaderCB/Authentication/UserName) }</ns2:PV_CORRESPONSAL>
            <ns2:PN_TIPO_TRANSACCION>{ $tipoTransaccion }</ns2:PN_TIPO_TRANSACCION>
            <ns2:PV_CODIGO_CANAL>{ $codigoCanal }</ns2:PV_CODIGO_CANAL>
            <ns2:PV_ESTADO_TRANSACCION>{ $estadoTransaccion }</ns2:PV_ESTADO_TRANSACCION>
            <ns2:PN_MONTO>{ data($retiroEfectivoCB/AMOUNT) }</ns2:PN_MONTO>
            <ns2:PV_MONEDA>{ data($retiroEfectivoCB/CURRENCY) }</ns2:PV_MONEDA>
            <ns2:PV_CODIGO_PAIS>{ data($HeaderCB/Region/SourceBank) }</ns2:PV_CODIGO_PAIS>
            <ns2:PV_CLAVE_CORRESPONSAL>{ data($retiroEfectivoCB/TRANSACTION_ID_CB) }</ns2:PV_CLAVE_CORRESPONSAL>
            <ns2:PV_REFERENCIA_T24>{ $referenciaT24 }</ns2:PV_REFERENCIA_T24>
            <ns2:PV_CLAVE_TRANSACCION>{ data($retiroEfectivoCB/ACCOUNT_NUMBER) }</ns2:PV_CLAVE_TRANSACCION>
            <ns2:PV_COD_CORRESPONSAL>{ data($HeaderCB/BankingCorrespondent/Id) }</ns2:PV_COD_CORRESPONSAL>
            <ns2:PV_PUNTO_VENTA_CORR>{ data($HeaderCB/BankingCorrespondent/PointOfSale) }</ns2:PV_PUNTO_VENTA_CORR>
            <ns2:PV_SUB_PUNTO_VENTA_CORR>{ data($HeaderCB/BankingCorrespondent/SubPointOfSale) }</ns2:PV_SUB_PUNTO_VENTA_CORR>
            <ns2:PV_TOKEN_ID>{ data($retiroEfectivoCB/TOKEN_ID) }</ns2:PV_TOKEN_ID>
            <ns2:PV_ID_TRANSACCION_COMISION>{ $referenciaT24Comision }</ns2:PV_ID_TRANSACCION_COMISION>
            <ns2:PD_MONTO_COMISION>{ $montoComision }</ns2:PD_MONTO_COMISION>
            <ns2:PV_MONEDA_COMISION>{ $monedaComision }</ns2:PV_MONEDA_COMISION>
            <ns2:PV_REFERENCIA_T24_REV>{ $referenciaT24Reversion }</ns2:PV_REFERENCIA_T24_REV>
        </ns2:InputParameters>
};

declare variable $tipoTransaccion as xs:string external;
declare variable $codigoCanal as xs:string external;
declare variable $estadoTransaccion as xs:string external;
declare variable $referenciaT24 as xs:string external;
declare variable $referenciaT24Comision as xs:string external;
declare variable $montoComision as xs:string external;
declare variable $monedaComision as xs:string external;
declare variable $referenciaT24Reversion as xs:string external;
declare variable $HeaderCB as element(ns0:RequestHeader) external;
declare variable $retiroEfectivoCB as element(ns1:retiroEfectivo) external;

xf:registraEstadoTransaccion($tipoTransaccion,
    $codigoCanal,
    $estadoTransaccion,
    $referenciaT24,
    $referenciaT24Comision,
    $montoComision,
    $monedaComision,
    $referenciaT24Reversion,
    $HeaderCB,
    $retiroEfectivoCB)