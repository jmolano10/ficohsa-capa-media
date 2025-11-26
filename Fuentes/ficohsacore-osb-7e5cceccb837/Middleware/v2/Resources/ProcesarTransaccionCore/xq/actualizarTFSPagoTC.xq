(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TransaccionesAsincronas/DB/ActualizarTFSPagoTCCB/xsd/actualizarTFSPagoTCCB_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizarTFSPagoTCCB";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesarTransaccionCore/xq/actualizarTFSPagoTC/";

declare function xf:actualizarTFSPagoTC($uuid as xs:string,
    $TFS as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_UUID>{ $uuid }</ns0:PV_UUID>
            <ns0:PV_TFS>{ $TFS }</ns0:PV_TFS>
        </ns0:InputParameters>
};

declare variable $uuid as xs:string external;
declare variable $TFS as xs:string external;

xf:actualizarTFSPagoTC($uuid,
    $TFS)
