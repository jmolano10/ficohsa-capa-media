(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TransaccionesGenericasCB/ActualizarTransaccionGenericaCB/xsd/actualizarTransaccionGenCB_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizarTransaccionGenCB";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversarTransaccionID/xq/actualizarTrxGenReversaIn/";

declare function xf:actualizarTrxGenReversaIn($UUID as xs:string,
    $FT as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_UUID_TRXS>{ $UUID }</ns0:PV_UUID_TRXS>
            <ns0:PV_REF_T24>{ $FT }</ns0:PV_REF_T24>
            <ns0:PN_INTERCEPTOR>{ 3 }</ns0:PN_INTERCEPTOR>
        </ns0:InputParameters>
};

declare variable $UUID as xs:string external;
declare variable $FT as xs:string external;

xf:actualizarTrxGenReversaIn($UUID,
    $FT)
