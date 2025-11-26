(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TransaccionesAsincronas/DB/ActualizarEstadoErrorTrx/xsd/actualizarEstadoTRXErrorCB_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizarEstadoTRXErrorCB";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoTarjetaCreditoCB/xq/actualizarEstadoErrorAscinPagoTCCB/";

declare function xf:actualizarEstadoErrorAscinPagoTCCB($uuid as xs:string,
    $indicador as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_UUID>{ $uuid }</ns0:PV_UUID>
            <ns0:PN_TIPO_ESTADO>{ $indicador }</ns0:PN_TIPO_ESTADO>
        </ns0:InputParameters>
};

declare variable $uuid as xs:string external;
declare variable $indicador as xs:string external;

xf:actualizarEstadoErrorAscinPagoTCCB($uuid,
    $indicador)
