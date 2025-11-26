(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../BusinessServices/MDW/obtenerDescripcion/xsd/ObtenerDescripcion_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ObtenerDescripcion";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Genericos/ObtenerDescripcionIN/";

declare function xf:ObtenerDescripcionIN($txnValues as xs:string,
    $codTxn as xs:string,
    $userCode as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_TRX_CODE>{ $codTxn }</ns0:PV_TRX_CODE>
            <ns0:PV_TRX_VALUES>{ $txnValues }</ns0:PV_TRX_VALUES>
            <ns0:PV_USERCODE>{ $userCode }</ns0:PV_USERCODE>
        </ns0:InputParameters>
};

declare variable $txnValues as xs:string external;
declare variable $codTxn as xs:string external;
declare variable $userCode as xs:string external;

xf:ObtenerDescripcionIN($txnValues,
    $codTxn,
    $userCode)