xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TransferenciasACH/svcActualizacionACHMasivasPending/xsd/actualizarEstadoACHMasivasPending_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizarEstadoACHMasivasPending";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTransaccionACH/xq/actualizarEstadoACHMasivasPendingIn/";

declare function xf:actualizarEstadoACHMasivasPendingIn($transactionId as xs:string,
    $estado as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_TRANSACTION_ID>{ $transactionId }</ns0:PV_TRANSACTION_ID>
            <ns0:PV_ESTADO>{ $estado }</ns0:PV_ESTADO>
        </ns0:InputParameters>
};

declare variable $transactionId as xs:string external;
declare variable $estado as xs:string external;

xf:actualizarEstadoACHMasivasPendingIn($transactionId,
    $estado)