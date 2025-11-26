(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../BusinessServices/TransaccionesGenericasCB/ActualizarTransaccionGenericaCB/xsd/actualizarTransaccionGenCB_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizarTransaccionGenCB";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransaccionesGenericasCB/ProcesarTransaccionesGenericaCB/xq/actualizarEstadoTrxCBIndb/";

declare function xf:actualizarEstadoTrxCBIndb($UUID as xs:string,
    $refT24 as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_UUID_TRXS>{ $UUID }</ns0:PV_UUID_TRXS>
            <ns0:PV_REF_T24>{ $refT24 }</ns0:PV_REF_T24>
            {
             if ($refT24 != '') then (
              <ns0:PN_INTERCEPTOR>{ 1 }</ns0:PN_INTERCEPTOR>
             ) else (
              <ns0:PN_INTERCEPTOR>{ 2 }</ns0:PN_INTERCEPTOR>
             )
            }
        </ns0:InputParameters>
};

declare variable $UUID as xs:string external;
declare variable $refT24 as xs:string external;

xf:actualizarEstadoTrxCBIndb($UUID,
    $refT24)
