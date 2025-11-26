(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v3/BusinessServices/PAGOSWSTC/registrarReversionTCCB/xsd/registrarReversionTCCB_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarReversionTCCB";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversarTransaccionID/xq/registrarReversionTCID/";

declare function xf:registrarReversionTCID($transaccionId as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_TRANSACTION_ID>{ $transaccionId }</ns0:PV_TRANSACTION_ID>
        </ns0:InputParameters>
};

declare variable $transaccionId as xs:string external;

xf:registrarReversionTCID($transaccionId)
