(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/TransaccionesGenericasEEH/ActualizarTransaccionesGenericas/xsd/actualizarTransaccionesGenericas_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizarTransaccionesGenericas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversarTransaccionID/xq/actualizarTrxGenericadb/";

declare function xf:actualizarTrxGenericadb($uuid as xs:string,
    $estado as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_UUID_TRXS>{ $uuid }</ns0:PV_UUID_TRXS>
            <ns0:PN_ESTADO_TRX>{ $estado }</ns0:PN_ESTADO_TRX>
        </ns0:InputParameters>
};

declare variable $uuid as xs:string external;
declare variable $estado as xs:string external;

xf:actualizarTrxGenericadb($uuid,
    $estado)